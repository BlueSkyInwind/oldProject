//
//  CustomerCareerBaseClass.m
//
//  Created by dd  on 16/4/11
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "CustomerCareerBaseClass.h"
#import "CustomerCareerExt.h"
#import "CustomerCareerResult.h"


NSString *const kCustomerCareerBaseClassFlag = @"flag";
NSString *const kCustomerCareerBaseClassExt = @"ext";
NSString *const kCustomerCareerBaseClassResult = @"result";
NSString *const kCustomerCareerBaseClassMsg = @"msg";


@interface CustomerCareerBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CustomerCareerBaseClass

@synthesize flag = _flag;
@synthesize ext = _ext;
@synthesize result = _result;
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
            self.flag = [self objectOrNilForKey:kCustomerCareerBaseClassFlag fromDictionary:dict];
            self.ext = [CustomerCareerExt modelObjectWithDictionary:[dict objectForKey:kCustomerCareerBaseClassExt]];
            self.result = [CustomerCareerResult modelObjectWithDictionary:[dict objectForKey:kCustomerCareerBaseClassResult]];
            self.msg = [self objectOrNilForKey:kCustomerCareerBaseClassMsg fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.flag forKey:kCustomerCareerBaseClassFlag];
    [mutableDict setValue:[self.ext dictionaryRepresentation] forKey:kCustomerCareerBaseClassExt];
    [mutableDict setValue:[self.result dictionaryRepresentation] forKey:kCustomerCareerBaseClassResult];
    [mutableDict setValue:self.msg forKey:kCustomerCareerBaseClassMsg];

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

    self.flag = [aDecoder decodeObjectForKey:kCustomerCareerBaseClassFlag];
    self.ext = [aDecoder decodeObjectForKey:kCustomerCareerBaseClassExt];
    self.result = [aDecoder decodeObjectForKey:kCustomerCareerBaseClassResult];
    self.msg = [aDecoder decodeObjectForKey:kCustomerCareerBaseClassMsg];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_flag forKey:kCustomerCareerBaseClassFlag];
    [aCoder encodeObject:_ext forKey:kCustomerCareerBaseClassExt];
    [aCoder encodeObject:_result forKey:kCustomerCareerBaseClassResult];
    [aCoder encodeObject:_msg forKey:kCustomerCareerBaseClassMsg];
}

- (id)copyWithZone:(NSZone *)zone
{
    CustomerCareerBaseClass *copy = [[CustomerCareerBaseClass alloc] init];
    
    if (copy) {

        copy.flag = [self.flag copyWithZone:zone];
        copy.ext = [self.ext copyWithZone:zone];
        copy.result = [self.result copyWithZone:zone];
        copy.msg = [self.msg copyWithZone:zone];
    }
    
    return copy;
}


@end
