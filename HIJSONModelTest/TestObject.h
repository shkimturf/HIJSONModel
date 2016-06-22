//
//  TestObject.h
//  HIJSONModel
//
//  Created by Sunhong Kim on 2016. 6. 23..
//  Copyright © 2016년 Sunhong Kim. All rights reserved.
//

#import "HIObject.h"

/*
{
     "id": String,
     "publishedAt": ISO-8601 format String // "2016-05-16T23:47:02.000Z",
     "title": String,
     "description": String,
     "thumbnails": [
         {
             "url": String,
             "width": Int,
             "height": Int,
         },
     ],
},
 */

@interface TestObject : HIObject

@property (nonatomic, strong, readonly) NSDate* publishedAt;

@end
