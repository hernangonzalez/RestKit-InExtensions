//
//  RKObjectManager+InExtensions.h
//
//  Created by Hernan Gabriel Gonzalez on 1/11/14.
//  Copyright (c) 2014 Hernan Gabriel Gonzalez. All rights reserved.
//

#import "RKObjectManager.h"

/**
 Blocks
 */
typedef void (^RKObjectRequestSuccessBlock)(RKObjectRequestOperation *, RKMappingResult *);
typedef void (^RKObjectRequestFailureBlock)(RKObjectRequestOperation *, NSError *);
typedef void (^AFSuccessBlock)(AFHTTPRequestOperation *operation, id responseObject);
typedef void (^AFErrorBlock)(AFHTTPRequestOperation *operation, NSError *error);
typedef void (^AFProgressBlock)(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite);


@interface RKObjectManager (InExtensions)

- (void)loadMappingsFromDictionary:(NSDictionary*)mappingInfo;

@end
