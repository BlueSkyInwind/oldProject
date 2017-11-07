//
//  LivenessBaseClass.m
//
//  Created by dd  on 16/3/31
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "LivenessBaseClass.h"
#import "LivenessIdentity.h"
#import "LivenessSelfie.h"


NSString *const kLivenessBaseClassStatus = @"status";
NSString *const kLivenessBaseClassIdentity = @"identity";
NSString *const kLivenessBaseClassSelfie = @"selfie";
NSString *const kLivenessBaseClassRequestId = @"request_id";
NSString *const kLivenessBaseClassConfidence = @"confidence";


@interface LivenessBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LivenessBaseClass

@synthesize status = _status;
@synthesize identity = _identity;
@synthesize selfie = _selfie;
@synthesize requestId = _requestId;
@synthesize confidence = _confidence;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.status = [self objectOrNilForKey:kLivenessBaseClassStatus fromDictionary:dict];
            self.identity = [LivenessIdentity modelObjectWithDictionary:[dict objectForKey:kLivenessBaseClassIdentity]];
            self.selfie = [LivenessSelfie modelObjectWithDictionary:[dict objectForKey:kLivenessBaseClassSelfie]];
            self.requestId = [self objectOrNilForKey:kLivenessBaseClassRequestId fromDictionary:dict];
            self.confidence = [[self objectOrNilForKey:kLivenessBaseClassConfidence fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.status forKey:kLivenessBaseClassStatus];
    [mutableDict setValue:[self.identity dictionaryRepresentation] forKey:kLivenessBaseClassIdentity];
    [mutableDict setValue:[self.selfie dictionaryRepresentation] forKey:kLivenessBaseClassSelfie];
    [mutableDict setValue:self.requestId forKey:kLivenessBaseClassRequestId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.confidence] forKey:kLivenessBaseClassConfidence];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.status = [aDecoder decodeObjectForKey:kLivenessBaseClassStatus];
    self.identity = [aDecoder decodeObjectForKey:kLivenessBaseClassIdentity];
    self.selfie = [aDecoder decodeObjectForKey:kLivenessBaseClassSelfie];
    self.requestId = [aDecoder decodeObjectForKey:kLivenessBaseClassRequestId];
    self.confidence = [aDecoder decodeDoubleForKey:kLivenessBaseClassConfidence];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_status forKey:kLivenessBaseClassStatus];
    [aCoder encodeObject:_identity forKey:kLivenessBaseClassIdentity];
    [aCoder encodeObject:_selfie forKey:kLivenessBaseClassSelfie];
    [aCoder encodeObject:_requestId forKey:kLivenessBaseClassRequestId];
    [aCoder encodeDouble:_confidence forKey:kLivenessBaseClassConfidence];
}

- (id)copyWithZone:(NSZone *)zone
{
    LivenessBaseClass *copy = [[LivenessBaseClass alloc] init];
    
    if (copy) {

        copy.status = [self.status copyWithZone:zone];
        copy.identity = [self.identity copyWithZone:zone];
        copy.selfie = [self.selfie copyWithZone:zone];
        copy.requestId = [self.requestId copyWithZone:zone];
        copy.confidence = self.confidence;
    }
    
    return copy;
}


@end
