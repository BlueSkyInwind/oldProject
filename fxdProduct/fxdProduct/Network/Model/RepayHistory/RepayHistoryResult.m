//
//  RepayHistoryResult.m
//
//  Created by dd  on 15/10/22
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "RepayHistoryResult.h"
#import "RepayHistoryCapitalFlowList.h"


NSString *const kRepayHistoryResultCapitalFlowCount = @"capitalFlowCount";
NSString *const kRepayHistoryResultCapitalFlowList = @"CapitalFlowList";


@interface RepayHistoryResult ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation RepayHistoryResult

@synthesize capitalFlowCount = _capitalFlowCount;
@synthesize capitalFlowList = _capitalFlowList;


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
            self.capitalFlowCount = [[self objectOrNilForKey:kRepayHistoryResultCapitalFlowCount fromDictionary:dict] doubleValue];
    NSObject *receivedRepayHistoryCapitalFlowList = [dict objectForKey:kRepayHistoryResultCapitalFlowList];
    NSMutableArray *parsedRepayHistoryCapitalFlowList = [NSMutableArray array];
    if ([receivedRepayHistoryCapitalFlowList isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedRepayHistoryCapitalFlowList) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedRepayHistoryCapitalFlowList addObject:[RepayHistoryCapitalFlowList modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedRepayHistoryCapitalFlowList isKindOfClass:[NSDictionary class]]) {
       [parsedRepayHistoryCapitalFlowList addObject:[RepayHistoryCapitalFlowList modelObjectWithDictionary:(NSDictionary *)receivedRepayHistoryCapitalFlowList]];
    }

    self.capitalFlowList = [NSArray arrayWithArray:parsedRepayHistoryCapitalFlowList];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.capitalFlowCount] forKey:kRepayHistoryResultCapitalFlowCount];
    NSMutableArray *tempArrayForCapitalFlowList = [NSMutableArray array];
    for (NSObject *subArrayObject in self.capitalFlowList) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForCapitalFlowList addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForCapitalFlowList addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForCapitalFlowList] forKey:kRepayHistoryResultCapitalFlowList];

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

    self.capitalFlowCount = [aDecoder decodeDoubleForKey:kRepayHistoryResultCapitalFlowCount];
    self.capitalFlowList = [aDecoder decodeObjectForKey:kRepayHistoryResultCapitalFlowList];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_capitalFlowCount forKey:kRepayHistoryResultCapitalFlowCount];
    [aCoder encodeObject:_capitalFlowList forKey:kRepayHistoryResultCapitalFlowList];
}

- (id)copyWithZone:(NSZone *)zone
{
    RepayHistoryResult *copy = [[RepayHistoryResult alloc] init];
    
    if (copy) {

        copy.capitalFlowCount = self.capitalFlowCount;
        copy.capitalFlowList = [self.capitalFlowList copyWithZone:zone];
    }
    
    return copy;
}


@end
