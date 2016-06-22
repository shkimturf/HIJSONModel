//
//  HIObject.h
//  HIDevKit
//
//  Created by Sunhong Kim on 2014. 9. 16..
//  Copyright (c) 2014년 Sunhong Kim. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HIObjectScheme.h"
#import "HIObjectParser.h"

@interface HIObject : NSObject
{
    NSDictionary* _data;
}

@property (nonatomic, strong, readonly) NSDictionary* data;
@property (nonatomic, strong, readonly) NSDictionary* snapshot;
@property (nonatomic, assign) NSInteger tag;

@property (nonatomic, strong, readonly) NSString* iid;

// parser helper function
+ (HIObject*)objectWithServerResponse:(NSDictionary*)response parser:(HIObjectParser*)parser;
+ (HIObjectScheme*)scheme;

// related initializer
- (id)initWithServerResponse:(NSDictionary*)response;
- (id)initWithServerResponse:(NSDictionary*)response parser:(HIObjectParser*)parser;
- (id)initWithServerResponse:(NSDictionary*)response parser:(HIObjectParser*)parser scheme:(HIObjectScheme*)scheme;

@end
