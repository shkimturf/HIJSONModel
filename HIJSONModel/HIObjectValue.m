//
//  HIObjectValue.m
//  HIDevKit
//
//  Created by Sunhong Kim on 2014. 9. 16..
//  Copyright (c) 2014년 Sunhong Kim. All rights reserved.
//

#import "HIObjectValue.h"

@implementation HIObjectValue

- (id)initWithValueType:(HIObjectValueType)valueType emptyValueHandleType:(HIObjectEmptyValueHandleType)emptyValueHandleType propertyKey:(NSString*)propertyKey {
    self = [super init];
    if (self) {
        self.valueType = valueType;
        self.emptyValueHandleType = emptyValueHandleType;
        self.propertyKey = propertyKey;
    }
    return self;
}

@end
