//
//  HIObjectParser.h
//  HIDevKit
//
//  Created by Sunhong Kim on 2014. 9. 16..
//  Copyright (c) 2014년 Sunhong Kim. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HIObjectScheme;
@interface HIObjectParser : NSObject

- (NSDictionary*)decodeServerResponse:(NSDictionary*)response objectScheme:(HIObjectScheme*)scheme;
- (NSDictionary*)encodeLocalData:(NSDictionary*)data objectScheme:(HIObjectScheme*)scheme;

@end
