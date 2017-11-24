//
//  LoanDoFindBaseClass.m
//
//  Created by   on 15/10/29
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "LoanDoFindBaseClass.h"
#import "LoanDoFindResult.h"


NSString *const kLoanDoFindBaseClassResult = @"result";
NSString *const kLoanDoFindBaseClassFlag = @"flag";
NSString *const kLoanDoFindBaseClassMsg = @"msg";


@interface LoanDoFindBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LoanDoFindBaseClass

@synthesize result = _result;
@synthesize flag = _flag;
@synthesize msg = _msg;


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
            self.result = [LoanDoFindResult modelObjectWithDictionary:[dict objectForKey:kLoanDoFindBaseClassResult]];
            self.flag = [self objectOrNilForKey:kLoanDoFindBaseClassFlag fromDictionary:dict];
            self.msg = [self objectOrNilForKey:kLoanDoFindBaseClassMsg fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.result dictionaryRepresentation] forKey:kLoanDoFindBaseClassResult];
    [mutableDict setValue:self.flag forKey:kLoanDoFindBaseClassFlag];
    [mutableDict setValue:self.msg forKey:kLoanDoFindBaseClassMsg];

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

    self.result = [aDecoder decodeObjectForKey:kLoanDoFindBaseClassResult];
    self.flag = [aDecoder decodeObjectForKey:kLoanDoFindBaseClassFlag];
    self.msg = [aDecoder decodeObjectForKey:kLoanDoFindBaseClassMsg];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_result forKey:kLoanDoFindBaseClassResult];
    [aCoder encodeObject:_flag forKey:kLoanDoFindBaseClassFlag];
    [aCoder encodeObject:_msg forKey:kLoanDoFindBaseClassMsg];
}

- (id)copyWithZone:(NSZone *)zone
{
    LoanDoFindBaseClass *copy = [[LoanDoFindBaseClass alloc] init];
    
    if (copy) {

        copy.result = [self.result copyWithZone:zone];
        copy.flag = [self.flag copyWithZone:zone];
        copy.msg = [self.msg copyWithZone:zone];
    }
    
    return copy;
}


@end
