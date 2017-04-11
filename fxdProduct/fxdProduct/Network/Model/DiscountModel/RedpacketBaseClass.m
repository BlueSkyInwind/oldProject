//
//  RedpacketBaseClass.m
//
//  Created by dd  on 16/5/23
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "RedpacketBaseClass.h"
#import "RedpacketExt.h"
#import "RedpacketResult.h"


NSString *const kRedpacketBaseClassFlag = @"flag";
NSString *const kRedpacketBaseClassExt = @"ext";
NSString *const kRedpacketBaseClassResult = @"result";
NSString *const kRedpacketBaseClassMsg = @"msg";


@interface RedpacketBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation RedpacketBaseClass

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
            self.flag = [self objectOrNilForKey:kRedpacketBaseClassFlag fromDictionary:dict];
            self.ext = [RedpacketExt modelObjectWithDictionary:[dict objectForKey:kRedpacketBaseClassExt]];
    NSObject *receivedRedpacketResult = [dict objectForKey:kRedpacketBaseClassResult];
    NSMutableArray *parsedRedpacketResult = [NSMutableArray array];
    if ([receivedRedpacketResult isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedRedpacketResult) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedRedpacketResult addObject:[RedpacketResult modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedRedpacketResult isKindOfClass:[NSDictionary class]]) {
       [parsedRedpacketResult addObject:[RedpacketResult modelObjectWithDictionary:(NSDictionary *)receivedRedpacketResult]];
    }

    self.result = [NSArray arrayWithArray:parsedRedpacketResult];
            self.msg = [self objectOrNilForKey:kRedpacketBaseClassMsg fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.flag forKey:kRedpacketBaseClassFlag];
    [mutableDict setValue:[self.ext dictionaryRepresentation] forKey:kRedpacketBaseClassExt];
    NSMutableArray *tempArrayForResult = [NSMutableArray array];
    for (NSObject *subArrayObject in self.result) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForResult addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForResult addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForResult] forKey:kRedpacketBaseClassResult];
    [mutableDict setValue:self.msg forKey:kRedpacketBaseClassMsg];

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

    self.flag = [aDecoder decodeObjectForKey:kRedpacketBaseClassFlag];
    self.ext = [aDecoder decodeObjectForKey:kRedpacketBaseClassExt];
    self.result = [aDecoder decodeObjectForKey:kRedpacketBaseClassResult];
    self.msg = [aDecoder decodeObjectForKey:kRedpacketBaseClassMsg];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_flag forKey:kRedpacketBaseClassFlag];
    [aCoder encodeObject:_ext forKey:kRedpacketBaseClassExt];
    [aCoder encodeObject:_result forKey:kRedpacketBaseClassResult];
    [aCoder encodeObject:_msg forKey:kRedpacketBaseClassMsg];
}

- (id)copyWithZone:(NSZone *)zone
{
    RedpacketBaseClass *copy = [[RedpacketBaseClass alloc] init];
    
    if (copy) {

        copy.flag = [self.flag copyWithZone:zone];
        copy.ext = [self.ext copyWithZone:zone];
        copy.result = [self.result copyWithZone:zone];
        copy.msg = [self.msg copyWithZone:zone];
    }
    
    return copy;
}


@end
