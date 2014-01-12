//
//  RKObjectManager+InExtensions.m
//
//  Created by Hernan Gabriel Gonzalez on 1/11/14.
//  Copyright (c) 2014 Indeba.com. All rights reserved.
//

#import "RKObjectManager+InExtensions.h"
#import "RKObjectMapping+InExtensions.h"
#import <RKErrorMessage.h>
#import <RestKit/Network.h>

#define kRequestMapping @"requests"
#define kResponseMapping @"response"
#define kStatusCode @"statusCode"
#define kMappingClass @"class"
#define kPathPattern @"pathPattern"
#define kKeyPath @"keyPath"
#define kMappingRoutes @"routes"
#define kMappingRoute @"route"
#define kHTTPMethod @"method"

// TODO: Error descriptor should be part of definitions.

@implementation RKObjectManager (InExtensions)

- (void)loadMappingsFromDictionary:(NSDictionary *)mappingInfo
{
    NSParameterAssert(mappingInfo);
    
    // Request Descriptors
	NSDictionary *requestMappings = [mappingInfo valueForKey:kRequestMapping];
	[requestMappings enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSDictionary *info, BOOL *stop)
     {
         Class mapClass = NSClassFromString(key);
         RKObjectMapping *requestMapping = [RKObjectMapping requestMappingFromDictionary:info];
         NSString* httpMethod = [info objectForKey:kHTTPMethod];
         RKRequestMethod method = (httpMethod)? RKRequestMethodFromString(httpMethod) : RKRequestMethodAny;
         RKRequestDescriptor *requestDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:requestMapping
                                                                                        objectClass:mapClass
                                                                                        rootKeyPath:nil
                                                                                             method:method];
         [self addRequestDescriptor:requestDescriptor];
     }];
    
	// Error Descriptor
//	RKObjectMapping *errorMapping = [RKObjectMapping objectMappingForClass:[RKErrorMessage class]];
//	RKResponseDescriptor *errorDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:errorMapping
//	                                                                                     method:RKRequestMethodAny
//	                                                                                pathPattern:nil
//	                                                                                    keyPath:nil
//	                                                                                statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassClientError)];
//    
//	[self addResponseDescriptor:errorDescriptor];

    
    // Response Descriptors
    NSDictionary* responseDescriptors = [mappingInfo valueForKey:kResponseMapping];
	[responseDescriptors enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSDictionary *info, BOOL *stop)
     {
         // Class
         Class mapClass = NSClassFromString(key);
         RKObjectMapping* objMapping = [RKObjectMapping responseMappingForClass:mapClass responseInfo:responseDescriptors];
         NSAssert(objMapping, @"Missing object mapping");
         
         // Status code range
         NSNumber* statusCodeClass = [info objectForKey:kStatusCode];
         NSIndexSet* statusCodes = (statusCodeClass)? RKStatusCodeIndexSetForClass([statusCodeClass integerValue])
                                                    : RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful);
         
         // Descriptor
         NSString* pathPattern = [info objectForKey:kPathPattern];
         NSString* keyPath = [info objectForKey:kKeyPath];
         NSString* httpMethod = [info objectForKey:kHTTPMethod];
         RKRequestMethod method = (httpMethod)? RKRequestMethodFromString(httpMethod) : RKRequestMethodAny;
         RKResponseDescriptor* descriptor = [RKResponseDescriptor responseDescriptorWithMapping:objMapping
                                                                                         method:method
                                                                                    pathPattern:pathPattern
                                                                                        keyPath:keyPath
                                                                                    statusCodes:statusCodes];
         [self addResponseDescriptor:descriptor];
     }];
    
    
    // Mapping routes
    RKRouter* router = [self router];
    NSDictionary* routes = [mappingInfo valueForKey:kMappingRoutes];
	[routes enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSDictionary *info, BOOL *stop)
     {
         Class mapClass = NSClassFromString(key);
         NSString* mapRoute = [info objectForKey:kMappingRoute];
         NSString* httpMethod = [info objectForKey:kHTTPMethod];
         RKRequestMethod requestMethod = (httpMethod)? RKRequestMethodFromString(httpMethod) : RKRequestMethodAny;
         
         RKRoute* route = [RKRoute routeWithClass:mapClass
                                      pathPattern:mapRoute
                                           method:requestMethod];
         
         [[router routeSet] addRoute:route];
     }];

    
}

@end
