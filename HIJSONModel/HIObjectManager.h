//
//  HIObjectManager.h
//  HIDevKit
//
//  Created by Sunhong Kim on 2014. 9. 16..
//  Copyright (c) 2014년 Sunhong Kim. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HIObject.h"
#import "HIObjectObserver.h"

@interface HIObjectManager : NSObject
{
    NSMutableDictionary* _objectCache;
    NSMutableDictionary* _objectObservers;
}

@property (atomic, strong, readonly) NSDictionary* objectCache;
@property (atomic, strong, readonly) NSDictionary* objectObservers;

- (HIObject*)getObjectFromCacheByID:(NSString*)iid;

/*
 *  Supporting functions to observe object updating
 *      - Don't forget call removeObserver: in dealloc function
 */
- (void)addObserver:(id<HIObjectObserver>)observer forObjectID:(NSString*)objectID;
- (void)removeObserver:(id<HIObjectObserver>)observer forObjectID:(NSString*)objectID;
- (void)removeObserver:(id<HIObjectObserver>)observer;

/*
 *  Notice a object updated by other request.
 */
- (void)onObjectUpdated:(HIObject*)object;


@end
