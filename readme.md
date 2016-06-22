# HIJSONModel

Basic model to use objective-c project to encode or decode from JSON server response.
It supports to create objective-c class from server response.

## Environments

over iOS 7.0

## Usage

### Setup

Just import **HIJSONModel** source files to your project.

### HIObject

* Save the **decoded** data from server.
* **snapshot** means **encoded** object to send server.
* **id** is used to identify each object. 


### HIObjectValue

* Define each values type.
* How to operate when the value missed.
* Define is list type or not.
* Support to handle other class type

``` objc
    enum {
        HIObjectValueTypeRaw = 0,
        HIObjectValueTypeBool,
        HIObjectValueTypeInt,
        HIObjectValueTypeLongInt,
        HIObjectValueTypeFloat,
        HIObjectValueTypeString,
        HIObjectValueTypeISODate,       // ISO 8601
        HIObjectValueTypeClass,
    };
    typedef NSInteger HIObjectValueType;

    enum {
        HIObjectEmptyValueHandleTypeNull = 0,
        HIObjectEmptyValueHandleTypeRemove,
        HIObjectEmptyValueHandleTypeBlankString,
        HIObjectEmptyValueHandleTypeAssert,
    };
    typedef NSInteger HIObjectEmptyValueHandleType;

    HIObjectValueType valueType;
    HIObjectEmptyValueHandleType emptyValueHandleType;
    BOOL isList;
    NSString* propertyKey;
    Class baseClass;
```

### Object Example

Suppose server response has below scheme.

```
    {
      "id": String,
      "publishedAt": ISO-8601formatString//"2016-05-16T23:47:02.000Z",
      "title": String,
      "description": String,
      "thumbnails": [
        {
          "url": String,
          "width": Int,
          "height": Int
        },
      ],
    },
```

First, create json string to NSDictionary to use JSONKit,..
Then, you can create objective-c class like below.

``` objc
    // TestObject
    + (HIObjectScheme *)scheme {
        HIObjectScheme* scheme = [[HIObjectScheme alloc] init];
    
        [scheme addObjectValue:[[HIObjectValue alloc] initWithValueType:HIObjectValueTypeString emptyValueHandleType:HIObjectEmptyValueHandleTypeAssert propertyKey:@"id"]];
        [scheme addObjectValue:[[HIObjectValue alloc] initWithValueType:HIObjectValueTypeString emptyValueHandleType:HIObjectEmptyValueHandleTypeRemove propertyKey:@"title"]];
        [scheme addObjectValue:[[HIObjectValue alloc] initWithValueType:HIObjectValueTypeString emptyValueHandleType:HIObjectEmptyValueHandleTypeRemove propertyKey:@"description"]];
        [scheme addObjectValue:[[HIObjectValue alloc] initWithValueType:HIObjectValueTypeInt emptyValueHandleType:HIObjectEmptyValueHandleTypeRemove propertyKey:@"publishedAt"]];
    
        HIObjectValue* value = [[HIObjectValue alloc] initWithValueType:HIObjectValueTypeInt emptyValueHandleType:HIObjectEmptyValueHandleTypeRemove propertyKey:@"thumbnails"];
        value.isList = YES;
        value.baseClass = [Thumbnail class];
    
        return scheme;
    }

    - (NSString *)iid {
        return [self.data objectForKey:@"id"];
    }

    - (NSDate *)publishedAt {
        return [self.data objectForKey:@"publishedAt"];
    }

    // Thumbnail
    + (HIObjectScheme *)scheme {
        HIObjectScheme* scheme = [[HIObjectScheme alloc] init];
        
        [scheme addObjectValue:[[HIObjectValue alloc] initWithValueType:HIObjectValueTypeString emptyValueHandleType:HIObjectEmptyValueHandleTypeAssert propertyKey:@"url"]];
        [scheme addObjectValue:[[HIObjectValue alloc] initWithValueType:HIObjectValueTypeInt emptyValueHandleType:HIObjectEmptyValueHandleTypeRemove propertyKey:@"width"]];
        [scheme addObjectValue:[[HIObjectValue alloc] initWithValueType:HIObjectValueTypeInt emptyValueHandleType:HIObjectEmptyValueHandleTypeRemove propertyKey:@"height"]];
        
        return scheme;
    }

    - (NSString *)iid {
        return [self.data objectForKey:@"url"];
    }
```

It will create TestObject which has some properties(id, title, description, publishedAt, thumbnails).
**thumbnails** will create NSArray contains Thumbnail class instances when create TestObject.
**publishedAt** will create NSDate instance.

### Object Manager

Object caching tool class. Some instance conforms **HIObjectObserver** can observing specific object if it change.

``` objc
- (void)addObserver:(id<HIObjectObserver>)observer forObjectID:(NSString*)objectID;
- (void)removeObserver:(id<HIObjectObserver>)observer forObjectID:(NSString*)objectID;
- (void)removeObserver:(id<HIObjectObserver>)observer;
```

### Object Observer

If the instance regists as an observer on HIObjectManager, it can receive change callback.

``` objc
- (void)objectManager:(HIObjectManager*)objectManager onObjectUpdated:(HIObject*)object;
```

## Author

[shkimturf](https://github.com/shkimturf)

## License

HIJSONModel is under MIT License.