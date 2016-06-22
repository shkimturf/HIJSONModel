//
//  HIObjectManager.m
//  HIDevKit
//
//  Created by Sunhong Kim on 2014. 9. 16..
//  Copyright (c) 2014년 Sunhong Kim. All rights reserved.
//

#import "HIObjectManager.h"

#import "HIObject.h"

@implementation HIObjectManager
@synthesize objectCache=_objectCache, objectObservers=_objectObservers;

- (id)init {
    self = [super init];
    if (self) {
        _objectCache = [[NSMutableDictionary alloc] init];
        _objectObservers = [[NSMutableDictionary alloc] init];
    }
    return self;
}

#pragma mark - requests

- (HIObject*)getObjectFromCacheByID:(NSString*)iid {
    HIObject* object = nil;
    @synchronized(_objectCache) {
        object = [_objectCache objectForKey:iid];
    }
    
    return object;
}

#pragma mark - observers

- (void)addObserver:(id<HIObjectObserver>)observer forObjectID:(NSString*)objectID {
    @synchronized(self.objectObservers) {
        NSHashTable* observers = [self.objectObservers objectForKey:objectID];
        if ( nil == observers ) {
            observers = [NSHashTable weakObjectsHashTable];
            [_objectObservers setObject:observers forKey:objectID];
        }
    
        [observers addObject:observer];
    }
}

- (void)removeObserver:(id<HIObjectObserver>)observer forObjectID:(NSString*)objectID {
    if ( nil == objectID ) {
        return;
    }
    
    @synchronized(self.objectObservers) {
        NSHashTable* observers = [self.objectObservers objectForKey:objectID];
        [observers removeObject:observer];
    }
}

- (void)removeObserver:(id<HIObjectObserver>)observer {
    @synchronized(self.objectObservers) {
        [self.objectObservers enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            NSAssert([obj isKindOfClass:[NSHashTable class]], @"_observers has invalid value");
            NSHashTable* observers = obj;
            [observers removeObject:observer];
        }];
    }
}

#pragma mark - support functions

- (void)onObjectUpdated:(HIObject *)object {
    @synchronized(self.objectCache) {
        [_objectCache setObject:object forKey:object.iid];
    }
    
    // callback to requestors
    @synchronized(self.objectObservers) {
        NSHashTable* observers = [self.objectObservers objectForKey:object.iid];
        for ( id<HIObjectObserver> observer in observers.objectEnumerator ) {
            if ( [observer respondsToSelector:@selector(objectManager:onObjectUpdated:)] ) {
                [observer objectManager:self onObjectUpdated:object];
            }
        }
    }
}

@end
