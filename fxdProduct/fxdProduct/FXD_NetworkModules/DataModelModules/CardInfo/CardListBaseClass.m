//
//  CardListBaseClass.m
//
//  Created by dd  on 15/10/12
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "CardListBaseClass.h"
#import "CardListResult.h"


NSString *const kCardListBaseClassResult = @"result";
NSString *const kCardListBaseClassFlag = @"flag";
NSString *const kCardListBaseClassMsg = @"msg";


@interface CardListBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CardListBaseClass

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
    NSObject *receivedCardListResult = [dict objectForKey:kCardListBaseClassResult];
    NSMutableArray *parsedCardListResult = [NSMutableArray array];
    if ([receivedCardListResult isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedCardListResult) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedCardListResult addObject:[CardListResult modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedCardListResult isKindOfClass:[NSDictionary class]]) {
       [parsedCardListResult addObject:[CardListResult modelObjectWithDictionary:(NSDictionary *)receivedCardListResult]];
    }

    self.result = [NSArray arrayWithArray:parsedCardListResult];
            self.flag = [self objectOrNilForKey:kCardListBaseClassFlag fromDictionary:dict];
            self.msg = [self objectOrNilForKey:kCardListBaseClassMsg fromDictionary:dict];

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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForResult] forKey:kCardListBaseClassResult];
    [mutableDict setValue:self.flag forKey:kCardListBaseClassFlag];
    [mutableDict setValue:self.msg forKey:kCardListBaseClassMsg];

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

    self.result = [aDecoder decodeObjectForKey:kCardListBaseClassResult];
    self.flag = [aDecoder decodeObjectForKey:kCardListBaseClassFlag];
    self.msg = [aDecoder decodeObjectForKey:kCardListBaseClassMsg];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_result forKey:kCardListBaseClassResult];
    [aCoder encodeObject:_flag forKey:kCardListBaseClassFlag];
    [aCoder encodeObject:_msg forKey:kCardListBaseClassMsg];
}

- (id)copyWithZone:(NSZone *)zone
{
    CardListBaseClass *copy = [[CardListBaseClass alloc] init];
    
    if (copy) {

        copy.result = [self.result copyWithZone:zone];
        copy.flag = [self.flag copyWithZone:zone];
        copy.msg = [self.msg copyWithZone:zone];
    }
    
    return copy;
}


@end
