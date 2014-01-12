# RestKit Extensions

These are a set of extensions designed to help you get your networking code a bit more OOP.

Hope it helps ;)


TODO
====

 * Expand examples.


Sample Usage
============


// Create your description file
Please look at the sample file.

// Load the info
```  objective-c
    // Load our mapping info.
    NSString* plistPath = [[NSBundle mainBundle] pathForResource:@"modelMapping" ofType:@"plist"];
    NSDictionary* dict  = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    [objectManager loadMappingsFromDictionary:dict];
```


// Get our objects
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
