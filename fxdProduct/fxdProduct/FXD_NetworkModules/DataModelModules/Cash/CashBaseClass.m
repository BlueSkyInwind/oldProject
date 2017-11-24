//
//  CashBaseClass.m
//
//  Created by dd  on 15/10/20
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "CashBaseClass.h"
#import "CashResult.h"


NSString *const kCashBaseClassResult = @"result";
NSString *const kCashBaseClassFlag = @"flag";
NSString *const kCashBaseClassMsg = @"msg";


@interface CashBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CashBaseClass

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
    NSObject *receivedCashResult = [dict objectForKey:kCashBaseClassResult];
    NSMutableArray *parsedCashResult = [NSMutableArray array];
    if ([receivedCashResult isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedCashResult) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedCashResult addObject:[CashResult modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedCashResult isKindOfClass:[NSDictionary class]]) {
       [parsedCashResult addObject:[CashResult modelObjectWithDictionary:(NSDictionary *)receivedCashResult]];
    }

    self.result = [NSArray arrayWithArray:parsedCashResult];
            self.flag = [self objectOrNilForKey:kCashBaseClassFlag fromDictionary:dict];
            self.msg = [self objectOrNilForKey:kCashBaseClassMsg fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForResult] forKey:kCashBaseClassResult];
    [mutableDict setValue:self.flag forKey:kCashBaseClassFlag];
    [mutableDict setValue:self.msg forKey:kCashBaseClassMsg];

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

    self.result = [aDecoder decodeObjectForKey:kCashBaseClassResult];
    self.flag = [aDecoder decodeObjectForKey:kCashBaseClassFlag];
    self.msg = [aDecoder decodeObjectForKey:kCashBaseClassMsg];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_result forKey:kCashBaseClassResult];
    [aCoder encodeObject:_flag forKey:kCashBaseClassFlag];
    [aCoder encodeObject:_msg forKey:kCashBaseClassMsg];
}

- (id)copyWithZone:(NSZone *)zone
{
    CashBaseClass *copy = [[CashBaseClass alloc] init];
    
    if (copy) {

        copy.result = [self.result copyWithZone:zone];
        copy.flag = [self.flag copyWithZone:zone];
        copy.msg = [self.msg copyWithZone:zone];
    }
    
    return copy;
}


@end
