//
//  Thumbnail.m
//  HIJSONModel
//
//  Created by Sunhong Kim on 2016. 6. 23..
//  Copyright © 2016년 Sunhong Kim. All rights reserved.
//

#import "Thumbnail.h"

#import "HIObjectScheme.h"
#import "HIObjectValue.h"

@implementation Thumbnail

+ (HIObjectScheme *)scheme {
    HIObjectScheme* scheme = [[HIObjectScheme alloc] init];
    
    [scheme addObjectValue:[[HIObjectValue alloc] initWithValueType:HIObjectValueTypeString emptyValueHandleType:HIObjectEmptyValueHandleTypeAssert propertyKey:@"url"]];
    [scheme addObjectValue:[[HIObjectValue alloc] initWithValueType:HIObjectValueTypeInt emptyValueHandleType:HIObjectEmptyValueHandleTypeRemove propertyKey:@"width"]];
    [scheme addObjectValue:[[HIObjectValue alloc] initWithValueType:HIObjectValueTypeInt emptyValueHandleType:HIObjectEmptyValueHandleTypeRemove propertyKey:@"height"]];
    
    return scheme;
}


@end
