# RestKit Extensions

These categories are a set of extensions designed to help you get your networking code a bit more OOP.

Hope it helps ;)



##Sample Plist
![Screenshot](http://cl.ly/image/0a252A3V3w0V/Screen%20Shot%202014-02-06%20at%2011.05.42%20AM.png "Example of model plist")


##Sample Usage

// Create your description file <br>
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

## License

This project is licensed under the terms of the MIT License. Please see the [LICENSE](LICENSE) file for full details.

## Credits

RestKit-InExtensions is brought to you by the [Indeba Team] (http://www.indeba.com).

