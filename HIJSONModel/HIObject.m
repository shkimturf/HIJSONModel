//
//  HIObject.m
//  HIDevKit
//
//  Created by Sunhong Kim on 2014. 9. 16..
//  Copyright (c) 2014년 Sunhong Kim. All rights reserved.
//

#import "HIObject.h"

#import "HIObjectParser.h"

@implementation HIObject
@synthesize data=_data;

+ (HIObject *)objectWithServerResponse:(NSDictionary *)response parser:(HIObjectParser *)parser {
    return [[self alloc] initWithServerResponse:response parser:parser];
}

- (id)initWithServerResponse:(NSDictionary *)response {
    self = [self initWithServerResponse:response parser:[[HIObjectParser alloc] init]];
    return self;
}

- (id)initWithServerResponse:(NSDictionary *)response parser:(HIObjectParser *)parser {
    self = [self initWithServerResponse:response parser:parser scheme:[[self class] scheme]];
    return self;
}

- (id)initWithServerResponse:(NSDictionary *)response parser:(HIObjectParser *)parser scheme:(HIObjectScheme *)scheme {
    self = [super init];
    if (self) {
        _data = [parser decodeServerResponse:response objectScheme:scheme];
    }
    return self;
}

+ (HIObjectScheme *)scheme {
    NSAssert(NO, @"Should override this.");
    return nil;
}

- (NSString *)iid {
    NSAssert(NO, @"Should override this.");
    return nil;
}

#pragma mark - properties

- (NSDictionary *)snapshot {
    HIObjectParser* parser = [[HIObjectParser alloc] init];
    return [parser encodeLocalData:self.data objectScheme:[[self class] scheme]];
}

@end
