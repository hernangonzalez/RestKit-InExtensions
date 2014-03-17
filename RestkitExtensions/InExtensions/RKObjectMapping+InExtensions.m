//
//  RKObjectMapping+Mapping.m
//
//  Created by Hernan Gonzalez on 01/11/14.
//  Copyright (c) 2013 Indeba.com. All rights reserved.
//

#import "RKObjectMapping+InExtensions.h"
#import <RKRelationshipMapping.h>

NSString *const FCMappingAttributeFromDictionary = @"attributeFromDictionary";
NSString *const FCMappingAttributeFromArray = @"attributeFromArray";
NSString *const FCMappingRelationship = @"relationship";
NSString *const FCMappingClassMapping = @"classMapping";
NSString *const FCMappingFromKeyPath = @"fromKeyPath";
NSString *const FCMappingToKeyPath = @"toKeyPath";

@implementation RKObjectMapping (MappingPrivate)

- (void)mapAttributesForClass:(Class)targetClass usingInfo:(NSDictionary *)mappingInfo isRequest:(BOOL)isRequest
{
    NSString* targetName = NSStringFromClass(targetClass);
    NSDictionary* dictionary = [mappingInfo objectForKey:targetName];
    
	NSDictionary *mappingsFromDictionary =  [dictionary valueForKey:FCMappingAttributeFromDictionary];
	if (mappingsFromDictionary != nil)
	{
		[self addAttributeMappingsFromDictionary:mappingsFromDictionary];
	}
    
	NSArray *mappingsFromArray =  [dictionary valueForKey:FCMappingAttributeFromArray];
	if (mappingsFromArray != nil)
	{
		[self addAttributeMappingsFromArray:mappingsFromArray];
	}
    
	for (NSDictionary *relationship in [dictionary valueForKey:FCMappingRelationship])
	{
		Class relationshipClass = NSClassFromString([relationship valueForKey:FCMappingClassMapping]);

        // Prevent a loop by checking the target class.
		RKObjectMapping *relationshipObjMapping = nil;
        if (relationshipClass == targetClass)
        {
            relationshipObjMapping = self;
        }
        else  if (isRequest)
        {
            relationshipObjMapping = [RKObjectMapping requestMappingForClass:relationshipClass
                                                                 requestInfo:mappingInfo];;
        }
        else
        {
            relationshipObjMapping = [RKObjectMapping responseMappingForClass:relationshipClass
                                                                 responseInfo:mappingInfo];
        }
        
		RKRelationshipMapping *relationshipMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:[relationship valueForKey:FCMappingFromKeyPath]
		                                                                                         toKeyPath:[relationship valueForKey:FCMappingToKeyPath]
		                                                                                       withMapping:relationshipObjMapping];
		[self addPropertyMapping:relationshipMapping];
	}
}

+ (RKObjectMapping *)objectMapping:(Class)remoteClass fromClassMappingDictionaries:(NSDictionary *)classMappingDictionaries
{
	RKObjectMapping *objectMapping = nil;
	NSString *className = NSStringFromClass(remoteClass);
	NSDictionary *classMappingDictionary = [classMappingDictionaries valueForKey:className];
	if (classMappingDictionary != nil)
	{
		objectMapping = [RKObjectMapping mappingForClass:remoteClass];
		[objectMapping addAttributeMappingsFromDictionary:classMappingDictionary];
	}
	return objectMapping;
}

@end

@implementation RKObjectMapping (Mapping)

+ (RKObjectMapping*)responseMappingForClass:(Class)class responseInfo:(NSDictionary *)dict
{
    NSParameterAssert(dict);
    NSParameterAssert(class);
    RKObjectMapping *objectMapping = [RKObjectMapping mappingForClass:class];
    [objectMapping mapAttributesForClass:class usingInfo:dict isRequest:NO];
	return objectMapping;

}

+ (RKObjectMapping *)requestMappingForClass:(Class)class requestInfo:(NSDictionary *)dict
{
	NSParameterAssert(dict);
	RKObjectMapping *objectMapping = [RKObjectMapping requestMapping];
	[objectMapping mapAttributesForClass:class usingInfo:dict isRequest:YES];
	return objectMapping;
}

@end
