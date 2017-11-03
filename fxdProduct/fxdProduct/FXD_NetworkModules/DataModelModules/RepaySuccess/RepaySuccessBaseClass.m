//
//  RepaySuccessBaseClass.m
//
//  Created by dd  on 15/10/22
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "RepaySuccessBaseClass.h"
#import "RepaySuccessResult.h"


NSString *const kRepaySuccessBaseClassResult = @"result";
NSString *const kRepaySuccessBaseClassFlag = @"flag";
NSString *const kRepaySuccessBaseClassMsg = @"msg";


@interface RepaySuccessBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation RepaySuccessBaseClass

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
            self.result = [RepaySuccessResult modelObjectWithDictionary:[dict objectForKey:kRepaySuccessBaseClassResult]];
            self.flag = [self objectOrNilForKey:kRepaySuccessBaseClassFlag fromDictionary:dict];
            self.msg = [self objectOrNilForKey:kRepaySuccessBaseClassMsg fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.result dictionaryRepresentation] forKey:kRepaySuccessBaseClassResult];
    [mutableDict setValue:self.flag forKey:kRepaySuccessBaseClassFlag];
    [mutableDict setValue:self.msg forKey:kRepaySuccessBaseClassMsg];

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

    self.result = [aDecoder decodeObjectForKey:kRepaySuccessBaseClassResult];
    self.flag = [aDecoder decodeObjectForKey:kRepaySuccessBaseClassFlag];
    self.msg = [aDecoder decodeObjectForKey:kRepaySuccessBaseClassMsg];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_result forKey:kRepaySuccessBaseClassResult];
    [aCoder encodeObject:_flag forKey:kRepaySuccessBaseClassFlag];
    [aCoder encodeObject:_msg forKey:kRepaySuccessBaseClassMsg];
}

- (id)copyWithZone:(NSZone *)zone
{
    RepaySuccessBaseClass *copy = [[RepaySuccessBaseClass alloc] init];
    
    if (copy) {

        copy.result = [self.result copyWithZone:zone];
        copy.flag = [self.flag copyWithZone:zone];
        copy.msg = [self.msg copyWithZone:zone];
    }
    
    return copy;
}


@end
