//
//  CustomerBaseInfoBaseClass.m
//
//  Created by dd  on 16/4/11
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "CustomerBaseInfoBaseClass.h"
#import "CustomerBaseInfoExt.h"
#import "CustomerBaseInfoResult.h"


NSString *const kCustomerBaseInfoBaseClassFlag = @"flag";
NSString *const kCustomerBaseInfoBaseClassExt = @"ext";
NSString *const kCustomerBaseInfoBaseClassResult = @"result";
NSString *const kCustomerBaseInfoBaseClassMsg = @"msg";


@interface CustomerBaseInfoBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CustomerBaseInfoBaseClass

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
            self.flag = [self objectOrNilForKey:kCustomerBaseInfoBaseClassFlag fromDictionary:dict];
            self.ext = [CustomerBaseInfoExt modelObjectWithDictionary:[dict objectForKey:kCustomerBaseInfoBaseClassExt]];
            self.result = [CustomerBaseInfoResult modelObjectWithDictionary:[dict objectForKey:kCustomerBaseInfoBaseClassResult]];
            self.msg = [self objectOrNilForKey:kCustomerBaseInfoBaseClassMsg fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.flag forKey:kCustomerBaseInfoBaseClassFlag];
    [mutableDict setValue:[self.ext dictionaryRepresentation] forKey:kCustomerBaseInfoBaseClassExt];
    [mutableDict setValue:[self.result dictionaryRepresentation] forKey:kCustomerBaseInfoBaseClassResult];
    [mutableDict setValue:self.msg forKey:kCustomerBaseInfoBaseClassMsg];

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

    self.flag = [aDecoder decodeObjectForKey:kCustomerBaseInfoBaseClassFlag];
    self.ext = [aDecoder decodeObjectForKey:kCustomerBaseInfoBaseClassExt];
    self.result = [aDecoder decodeObjectForKey:kCustomerBaseInfoBaseClassResult];
    self.msg = [aDecoder decodeObjectForKey:kCustomerBaseInfoBaseClassMsg];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_flag forKey:kCustomerBaseInfoBaseClassFlag];
    [aCoder encodeObject:_ext forKey:kCustomerBaseInfoBaseClassExt];
    [aCoder encodeObject:_result forKey:kCustomerBaseInfoBaseClassResult];
    [aCoder encodeObject:_msg forKey:kCustomerBaseInfoBaseClassMsg];
}

- (id)copyWithZone:(NSZone *)zone
{
    CustomerBaseInfoBaseClass *copy = [[CustomerBaseInfoBaseClass alloc] init];
    
    if (copy) {

        copy.flag = [self.flag copyWithZone:zone];
        copy.ext = [self.ext copyWithZone:zone];
        copy.result = [self.result copyWithZone:zone];
        copy.msg = [self.msg copyWithZone:zone];
    }
    
    return copy;
}


@end
