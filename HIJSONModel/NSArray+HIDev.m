//
//  NSArray+HIDev.m
//  HIDevKit
//
//  Created by Sunhong Kim on 2014. 9. 12..
//  Copyright (c) 2014년 Sunhong Kim. All rights reserved.
//

#import "NSArray+HIDev.h"

#import "NSDictionary+HIDev.h"

@implementation NSArray (HIDev)

- (NSArray *)mapObjectsUsingBlock:(id (^)(id obj, NSUInteger idx))block {
    __block NSMutableArray *result = [NSMutableArray arrayWithCapacity:[self count]];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [result addObject:block(obj, idx)];
    }];
    return result;
}

- (NSMutableArray *)deepMutableArray {
    NSMutableArray* mutableArray = [[NSMutableArray alloc] init];
    
    for ( id value in self.objectEnumerator ) {
        BOOL added = NO;
        if ( [value isKindOfClass:[NSDictionary class]] ) {
            if ( NO == [value isKindOfClass:[NSMutableDictionary class]] ) {
                [mutableArray addObject:[value deepMutableDictionary]];
                added = YES;
            }
        } else if ( [value isKindOfClass:[NSArray class]] ) {
            if ( NO == [value isKindOfClass:[NSArray class]] ) {
                [mutableArray addObject:[value deepMutableArray]];
                added = YES;
            }
        }
        
        if ( NO == added ) {
            [mutableArray addObject:value];
        }
    }
    
    return mutableArray;
}


@end
