//
//  NSDictionary+HIDev.h
//  HIDevKit
//
//  Created by Sunhong Kim on 2014. 9. 12..
//  Copyright (c) 2014년 Sunhong Kim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (HIDev)

- (NSMutableDictionary*)deepMutableDictionary; // Create a copy of dictionary which replaces all the NSDictionary* to NSMutableDictionary, and NSArray* to NSMutableArray*.

@end
