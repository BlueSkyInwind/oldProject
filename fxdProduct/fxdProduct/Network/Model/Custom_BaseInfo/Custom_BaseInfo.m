//
//  Custom_BaseInfo.m
//
//  Created by dd  on 2017/3/1
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "Custom_BaseInfo.h"
#import "Custom_BaseInfoExt.h"
#import "Custom_BaseInfoResult.h"


NSString *const kCustom_BaseInfoFlag = @"flag";
NSString *const kCustom_BaseInfoExt = @"ext";
NSString *const kCustom_BaseInfoResult = @"result";
NSString *const kCustom_BaseInfoMsg = @"msg";


@interface Custom_BaseInfo ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Custom_BaseInfo

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
            self.flag = [self objectOrNilForKey:kCustom_BaseInfoFlag fromDictionary:dict];
            self.ext = [Custom_BaseInfoExt modelObjectWithDictionary:[dict objectForKey:kCustom_BaseInfoExt]];
            self.result = [Custom_BaseInfoResult modelObjectWithDictionary:[dict objectForKey:kCustom_BaseInfoResult]];
            self.msg = [self objectOrNilForKey:kCustom_BaseInfoMsg fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.flag forKey:kCustom_BaseInfoFlag];
    [mutableDict setValue:[self.ext dictionaryRepresentation] forKey:kCustom_BaseInfoExt];
    [mutableDict setValue:[self.result dictionaryRepresentation] forKey:kCustom_BaseInfoResult];
    [mutableDict setValue:self.msg forKey:kCustom_BaseInfoMsg];

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

    self.flag = [aDecoder decodeObjectForKey:kCustom_BaseInfoFlag];
    self.ext = [aDecoder decodeObjectForKey:kCustom_BaseInfoExt];
    self.result = [aDecoder decodeObjectForKey:kCustom_BaseInfoResult];
    self.msg = [aDecoder decodeObjectForKey:kCustom_BaseInfoMsg];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_flag forKey:kCustom_BaseInfoFlag];
    [aCoder encodeObject:_ext forKey:kCustom_BaseInfoExt];
    [aCoder encodeObject:_result forKey:kCustom_BaseInfoResult];
    [aCoder encodeObject:_msg forKey:kCustom_BaseInfoMsg];
}

- (id)copyWithZone:(NSZone *)zone
{
    Custom_BaseInfo *copy = [[Custom_BaseInfo alloc] init];
    
    if (copy) {

        copy.flag = [self.flag copyWithZone:zone];
        copy.ext = [self.ext copyWithZone:zone];
        copy.result = [self.result copyWithZone:zone];
        copy.msg = [self.msg copyWithZone:zone];
    }
    
    return copy;
}


@end
