//
//  NSDictionary+HIDev.m
//  HIDevKit
//
//  Created by Sunhong Kim on 2014. 9. 12..
//  Copyright (c) 2014년 Sunhong Kim. All rights reserved.
//

#import "NSDictionary+HIDev.h"

#import "NSArray+HIDev.h"

@implementation NSDictionary (HIDev)

- (NSMutableDictionary *)deepMutableDictionary {
    NSMutableDictionary* mutableDict = [[NSMutableDictionary alloc] init];
    
    for ( id key in self.keyEnumerator ) {
        BOOL added = NO;
        id value = [self objectForKey:key];
        if ( [value isKindOfClass:[NSDictionary class]] ) {
            if ( NO == [value isKindOfClass:[NSMutableDictionary class]] ) {
                [mutableDict setObject:[value deepMutableDictionary] forKey:key];
                added = YES;
            }
        } else if ( [value isKindOfClass:[NSArray class]] ) {
            if ( NO == [value isKindOfClass:[NSArray class]] ) {
                [mutableDict setObject:[value deepMutableArray] forKey:key];
                added = YES;
            }
        }
        
        if ( NO == added ) {
            [mutableDict setObject:value forKey:key];
        }
    }
    
    return mutableDict;
}

@end
