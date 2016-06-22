//
//  HIObjectParser.m
//  HIDevKit
//
//  Created by Sunhong Kim on 2014. 9. 16..
//  Copyright (c) 2014년 Sunhong Kim. All rights reserved.
//

#import "HIObjectParser.h"

#import "HIObjectScheme.h"
#import "HIObject.h"

#import "NSArray+HIDev.h"

@implementation HIObjectParser

- (NSDictionary*)decodeServerResponse:(NSDictionary*)response objectScheme:(HIObjectScheme*)scheme {
    NSMutableDictionary* result = [[NSMutableDictionary alloc] init];
    [scheme enumerateUsingBlock:^(HIObjectValue *value, BOOL *stop) {
        if ( value.isList ) {
            NSArray* data = [response objectForKey:value.propertyKey];
            if ( nil != data ) {
                NSAssert([data isKindOfClass:[NSArray class]], @"Invalid data class");
                [result setObject:[data mapObjectsUsingBlock:^id(id obj, NSUInteger idx) {
                    return [self _parseWithBaseResponse:obj withObjectValue:value];
                }] forKey:value.propertyKey];
            }
        } else {
            id parsedResult = [self _parseWithBaseResponse:[response valueForKey:value.propertyKey] withObjectValue:value];
            if ( nil != parsedResult ) {
                [result setObject:parsedResult forKey:value.propertyKey];
            }
        }
    }];
    
    return [NSDictionary dictionaryWithDictionary:result];
}

- (NSDictionary*)encodeLocalData:(NSDictionary*)data objectScheme:(HIObjectScheme*)scheme {
    NSMutableDictionary* result = [[NSMutableDictionary alloc] init];
    [scheme enumerateUsingBlock:^(HIObjectValue *value, BOOL *stop) {
        if ( value.isList ) {
            NSArray* list = [[data objectForKey:value.propertyKey] mapObjectsUsingBlock:^id(id obj, NSUInteger idx) {
                return [self _encodeWithBaseData:obj withObjectValue:value];
            }];
            
            if ( nil != list ) {
                [result setObject:list forKey:value.propertyKey];
            }
        } else {
            // consider empty value first
            id objectValue = [data objectForKey:value.propertyKey];
            if ( nil == objectValue ) {
                switch ( value.emptyValueHandleType ) {
                    case HIObjectEmptyValueHandleTypeNull:
                    case HIObjectEmptyValueHandleTypeRemove:
                        break;
                    case HIObjectEmptyValueHandleTypeBlankString:
                        [result setObject:@"" forKey:value.propertyKey];
                        break;
                    case HIObjectEmptyValueHandleTypeAssert:
                        NSAssert(NO, @"This value should not be nil. %@", value.propertyKey);
                    default:
                        NSAssert(NO, @"Unknown empty value type");
                }
            } else {
                [result setObject:[self _encodeWithBaseData:objectValue withObjectValue:value] forKey:value.propertyKey];
            }
        }
    }];
    
    return result;
}

#pragma mark - private functions

- (id)_parseWithBaseResponse:(id)response withObjectValue:(HIObjectValue*)value {
    // consider empty value first
    if ( nil == response ) {
        switch ( value.emptyValueHandleType ) {
            case HIObjectEmptyValueHandleTypeNull:
                return [NSNull null];
            case HIObjectEmptyValueHandleTypeRemove:
                return nil;
            case HIObjectEmptyValueHandleTypeBlankString:
                return @"";
            case HIObjectEmptyValueHandleTypeAssert:
                NSAssert(NO, @"This value should not be nil. %@", value.propertyKey);
            default:
                NSAssert(NO, @"Unknown empty value type");
        }
    }
    
    // parse
    switch ( value.valueType ) {
        case HIObjectValueTypeRaw:
        case HIObjectValueTypeString:
            return response;
        case HIObjectValueTypeBool:
            return [NSNumber numberWithBool:[response boolValue]];
        case HIObjectValueTypeInt:
            return [NSNumber numberWithInt:[response intValue]];
        case HIObjectValueTypeLongInt:
            return [NSNumber numberWithLong:[response unsignedLongValue]];
        case HIObjectValueTypeFloat:
            return [NSNumber numberWithFloat:[response floatValue]];
        case HIObjectValueTypeISODate:
        {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss";
            NSDate* date = [dateFormatter dateFromString:response];
            return [NSDate dateWithTimeInterval:[[NSTimeZone systemTimeZone] secondsFromGMT] sinceDate:date];
        }
            break;
        case HIObjectValueTypeClass:
        {
            if ( [response isKindOfClass:[NSString class]] ) {
                NSAssert(NO, @"Not supported yet.");
//                HIObject* object = [[KPApp sharedApp].objectManager getObjectFromCacheById:response];
//                if ( nil == object ) {
//                    object = [[value.baseClass alloc] initWithObjectID:response];
//                }
//                return object;
            } else {
                HIObject* obj = [value.baseClass objectWithServerResponse:response parser:self];
                return obj;
            }
        }
        default:
            NSAssert(NO, @"Unknown object value type");
    }
    
    return nil;
}

- (id)_encodeWithBaseData:(id)data withObjectValue:(HIObjectValue*)value {
    // parse
    switch ( value.valueType ) {
        case HIObjectValueTypeRaw:
        case HIObjectValueTypeString:
        case HIObjectValueTypeBool:
        case HIObjectValueTypeInt:
        case HIObjectValueTypeLongInt:
        case HIObjectValueTypeFloat:
            return data;
        case HIObjectValueTypeISODate:
        {
            NSAssert([data isKindOfClass:[NSDate class]], @"KPObjectValueTypeISODate should be NSDate*");
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss";
            
            NSTimeZone *gmt = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
            [dateFormatter setTimeZone:gmt];
            return [dateFormatter stringFromDate:data];
        }
            break;
        case HIObjectValueTypeClass:
        {
            NSAssert([data isKindOfClass:[HIObject class]], @"Invalid class!");
            HIObject* object = data;
            return object.snapshot;
        }
        default:
            NSAssert(NO, @"Unknown object value type");
    }
    
    return nil;
}


@end
