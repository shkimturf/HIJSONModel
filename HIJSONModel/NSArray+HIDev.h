//
//  NSArray+HIDev.h
//  HIDevKit
//
//  Created by Sunhong Kim on 2014. 9. 12..
//  Copyright (c) 2014년 Sunhong Kim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (HIDev)

- (NSArray *)mapObjectsUsingBlock:(id (^)(id obj, NSUInteger idx))block;
- (NSMutableArray*)deepMutableArray; // Create a copy of array which replaces all the NSDictioanry* to NSMutableDictionary, and NSArray* to NSMutableArray*

@end
