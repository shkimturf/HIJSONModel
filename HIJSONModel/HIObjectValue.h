//
//  HIObjectValue.h
//  HIDevKit
//
//  Created by Sunhong Kim on 2014. 9. 16..
//  Copyright (c) 2014년 Sunhong Kim. All rights reserved.
//

#import <Foundation/Foundation.h>

enum {
    HIObjectValueTypeRaw = 0,
    HIObjectValueTypeBool,
    HIObjectValueTypeInt,
    HIObjectValueTypeLongInt,
    HIObjectValueTypeFloat,
    HIObjectValueTypeString,
    HIObjectValueTypeISODate,
    HIObjectValueTypeClass,
};
typedef NSInteger HIObjectValueType;

enum {
    HIObjectEmptyValueHandleTypeNull = 0,
    HIObjectEmptyValueHandleTypeRemove,
    HIObjectEmptyValueHandleTypeBlankString,
    HIObjectEmptyValueHandleTypeAssert,
};
typedef NSInteger HIObjectEmptyValueHandleType;

@interface HIObjectValue : NSObject

@property (nonatomic, assign) HIObjectValueType valueType;
@property (nonatomic, assign) HIObjectEmptyValueHandleType emptyValueHandleType;
@property (nonatomic, assign) BOOL isList;
@property (nonatomic, strong) NSString* propertyKey;
@property (nonatomic, strong) Class baseClass;

- (id)initWithValueType:(HIObjectValueType)valueType emptyValueHandleType:(HIObjectEmptyValueHandleType)emptyValueHandleType propertyKey:(NSString*)propertyKey;

@end
