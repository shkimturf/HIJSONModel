//
//  TestObject.m
//  HIJSONModel
//
//  Created by Sunhong Kim on 2016. 6. 23..
//  Copyright © 2016년 Sunhong Kim. All rights reserved.
//

#import "TestObject.h"
#import "Thumbnail.h"

#import "HIObjectScheme.h"
#import "HIObjectValue.h"

@implementation TestObject

+ (HIObjectScheme *)scheme {
    HIObjectScheme* scheme = [[HIObjectScheme alloc] init];
    
    [scheme addObjectValue:[[HIObjectValue alloc] initWithValueType:HIObjectValueTypeString emptyValueHandleType:HIObjectEmptyValueHandleTypeAssert propertyKey:@"id"]];
    [scheme addObjectValue:[[HIObjectValue alloc] initWithValueType:HIObjectValueTypeString emptyValueHandleType:HIObjectEmptyValueHandleTypeRemove propertyKey:@"title"]];
    [scheme addObjectValue:[[HIObjectValue alloc] initWithValueType:HIObjectValueTypeString emptyValueHandleType:HIObjectEmptyValueHandleTypeRemove propertyKey:@"description"]];
    [scheme addObjectValue:[[HIObjectValue alloc] initWithValueType:HIObjectValueTypeInt emptyValueHandleType:HIObjectEmptyValueHandleTypeRemove propertyKey:@"publishedAt"]];
    
    HIObjectValue* value = [[HIObjectValue alloc] initWithValueType:HIObjectValueTypeInt emptyValueHandleType:HIObjectEmptyValueHandleTypeRemove propertyKey:@"thumbnails"];
    value.isList = YES;
    value.baseClass = [Thumbnail class];
    
    return scheme;
}

- (NSString *)iid {
    return [self.data objectForKey:@"id"];
}

- (NSDate *)publishedAt {
    return [self.data objectForKey:@"publishedAt"];
}

@end
