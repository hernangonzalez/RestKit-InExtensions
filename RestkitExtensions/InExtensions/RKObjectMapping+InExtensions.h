//
//  RKObjectMapping+INExtensions.h
//
//  Created by Hernan Gonzalez on 01/11/14.
//  Copyright (c) 2013 Indeba.com. All rights reserved.
//

#import <RestKit/ObjectMapping.h>

@interface RKObjectMapping (Mapping)

/**
 */
+ (RKObjectMapping*)responseMappingForClass:(Class)responseClass
                               mappingInfo:(NSDictionary *)dict;
/**
 otherwise return nil
 */
+ (RKObjectMapping *)requestMappingForClass:(Class)requestClass
                                mappingInfo:(NSDictionary *)dict;
@end
