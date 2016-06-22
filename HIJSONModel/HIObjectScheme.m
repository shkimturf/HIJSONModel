//
//  HIObjectScheme.m
//  HIDevKit
//
//  Created by Sunhong Kim on 2014. 9. 16..
//  Copyright (c) 2014년 Sunhong Kim. All rights reserved.
//

#import "HIObjectScheme.h"

@implementation HIObjectScheme

- (id)init {
    self = [super init];
    if (self) {
        _values = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)addObjectValue:(HIObjectValue*)value {
    [_values addObject:value];
}

- (void)enumerateUsingBlock:(void(^)(HIObjectValue* value, BOOL* stop))block {
    [_values enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        block(obj, stop);
    }];
}

@end
