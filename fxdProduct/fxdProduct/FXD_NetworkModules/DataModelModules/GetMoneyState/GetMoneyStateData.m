//
//  GetMoneyStateData.m
//
//  Created by dd  on 15/10/10
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "GetMoneyStateData.h"
#import "GetMoneyStateUserBean.h"


NSString *const kGetMoneyStateDataCreateDate = @"createDate";
NSString *const kGetMoneyStateDataUserBean = @"userBean";
NSString *const kGetMoneyStateDataLoanAmount = @"loanAmount";


@interface GetMoneyStateData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation GetMoneyStateData

@synthesize createDate = _createDate;
@synthesize userBean = _userBean;
@synthesize loanAmount = _loanAmount;


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
            self.createDate = [self objectOrNilForKey:kGetMoneyStateDataCreateDate fromDictionary:dict];
            self.userBean = [GetMoneyStateUserBean modelObjectWithDictionary:[dict objectForKey:kGetMoneyStateDataUserBean]];
            self.loanAmount = [[self objectOrNilForKey:kGetMoneyStateDataLoanAmount fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.createDate forKey:kGetMoneyStateDataCreateDate];
    [mutableDict setValue:[self.userBean dictionaryRepresentation] forKey:kGetMoneyStateDataUserBean];
    [mutableDict setValue:[NSNumber numberWithDouble:self.loanAmount] forKey:kGetMoneyStateDataLoanAmount];

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

    self.createDate = [aDecoder decodeObjectForKey:kGetMoneyStateDataCreateDate];
    self.userBean = [aDecoder decodeObjectForKey:kGetMoneyStateDataUserBean];
    self.loanAmount = [aDecoder decodeDoubleForKey:kGetMoneyStateDataLoanAmount];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_createDate forKey:kGetMoneyStateDataCreateDate];
    [aCoder encodeObject:_userBean forKey:kGetMoneyStateDataUserBean];
    [aCoder encodeDouble:_loanAmount forKey:kGetMoneyStateDataLoanAmount];
}

- (id)copyWithZone:(NSZone *)zone
{
    GetMoneyStateData *copy = [[GetMoneyStateData alloc] init];
    
    if (copy) {

        copy.createDate = [self.createDate copyWithZone:zone];
        copy.userBean = [self.userBean copyWithZone:zone];
        copy.loanAmount = self.loanAmount;
    }
    
    return copy;
}


@end
