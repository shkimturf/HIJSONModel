//
//  HIObjectScheme.h
//  HIDevKit
//
//  Created by Sunhong Kim on 2014. 9. 16..
//  Copyright (c) 2014년 Sunhong Kim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HIObjectValue.h"

@interface HIObjectScheme : NSObject
{
    NSMutableArray* _values;
}

- (void)addObjectValue:(HIObjectValue*)value;
- (void)enumerateUsingBlock:(void(^)(HIObjectValue* value, BOOL* stop))block;

@end
