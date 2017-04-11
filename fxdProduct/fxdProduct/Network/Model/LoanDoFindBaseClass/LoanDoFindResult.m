//
//  LoanDoFindResult.m
//
//  Created by   on 15/10/29
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "LoanDoFindResult.h"


NSString *const kLoanDoFindResultCreateDat = @"createDat";
NSString *const kLoanDoFindResultId = @"id";
NSString *const kLoanDoFindResultStatus = @"status";


@interface LoanDoFindResult ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LoanDoFindResult

@synthesize createDat = _createDat;
@synthesize resultIdentifier = _resultIdentifier;
@synthesize status = _status;


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
            self.createDat = [self objectOrNilForKey:kLoanDoFindResultCreateDat fromDictionary:dict];
            self.resultIdentifier = [[self objectOrNilForKey:kLoanDoFindResultId fromDictionary:dict] doubleValue];
            self.status = [self objectOrNilForKey:kLoanDoFindResultStatus fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.createDat forKey:kLoanDoFindResultCreateDat];
    [mutableDict setValue:[NSNumber numberWithDouble:self.resultIdentifier] forKey:kLoanDoFindResultId];
    [mutableDict setValue:self.status forKey:kLoanDoFindResultStatus];

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

    self.createDat = [aDecoder decodeObjectForKey:kLoanDoFindResultCreateDat];
    self.resultIdentifier = [aDecoder decodeDoubleForKey:kLoanDoFindResultId];
    self.status = [aDecoder decodeObjectForKey:kLoanDoFindResultStatus];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_createDat forKey:kLoanDoFindResultCreateDat];
    [aCoder encodeDouble:_resultIdentifier forKey:kLoanDoFindResultId];
    [aCoder encodeObject:_status forKey:kLoanDoFindResultStatus];
}

- (id)copyWithZone:(NSZone *)zone
{
    LoanDoFindResult *copy = [[LoanDoFindResult alloc] init];
    
    if (copy) {

        copy.createDat = [self.createDat copyWithZone:zone];
        copy.resultIdentifier = self.resultIdentifier;
        copy.status = [self.status copyWithZone:zone];
    }
    
    return copy;
}


@end
