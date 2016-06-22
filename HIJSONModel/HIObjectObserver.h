//
//  HIObjectObserver.h
//  HIDevKit
//
//  Created by Sunhong Kim on 2014. 9. 16..
//  Copyright (c) 2014년 Sunhong Kim. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HIObject;
@class HIObjectManager;
@protocol HIObjectObserver <NSObject>

- (void)objectManager:(HIObjectManager*)objectManager onObjectUpdated:(HIObject*)object;

@end
