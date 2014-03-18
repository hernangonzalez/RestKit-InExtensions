# RestKit Extensions

These categories are a set of extensions designed to help you get your networking code a bit more OOP.

Hope it helps ;)



##Sample Plist
![Screenshot](http://cl.ly/image/2h1c1c2Y3g36/Screen%20Shot%202014-03-18%20at%205.27.18%20PM.png "Example of model plist")


##Sample Usage

####Create your description file <br>
Please look at the [sample file](RestkitExtensions/modelMapping.plist).

####Load the info
```  objective-c
    // Load our mapping info.
    NSString* plistPath = [[NSBundle mainBundle] pathForResource:@"modelMapping" ofType:@"plist"];
    NSDictionary* dict  = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    [objectManager loadMappingsFromDictionary:dict];
```


####Get our objects
```  objective-c
    // GET Objects
    RKTUserStatus* userStatus = [[RKTUserStatus alloc] init];
    [userStatus setUsername:@"RestKit"];
    [objectManager getObject:userStatus
                        path:nil
                  parameters:nil
                     success:successBlock
                     failure:errorBlock];
```

#### Post example
``` objective-c
    // POST a tweet
    RKTweet* tweet = [_tweets lastObject];
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    [objectManager postObject:tweet
                         path:nil
                   parameters:nil
                      success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                      } failure:^(RKObjectRequestOperation *operation, NSError *error) {
                          // This will fail, it is only here
                          // to demonstrate that we can easily post an object
                          // and the reverse mapping is resolved by the extension.
                      }];

```

## License

This project is licensed under the terms of the MIT License. Please see the [LICENSE](LICENSE) file for full details.

## Credits

RestKit-InExtensions is brought to you by the [Indeba Team] (http://www.indeba.com).

