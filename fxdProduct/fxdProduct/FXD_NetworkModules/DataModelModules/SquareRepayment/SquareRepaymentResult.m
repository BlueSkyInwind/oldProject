//
//  SquareRepaymentResult.m
//
//  Created by dd  on 16/5/25
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "SquareRepaymentResult.h"
#import "SquareRepaymentAvailableRedpackets.h"


NSString *const kSquareRepaymentResultAvailableRedpackets = @"available_redpackets_";
NSString *const kSquareRepaymentResultTotalAmount = @"total_amount_";
NSString *const kSquareRepaymentResultReapyInterest = @"reapy_interest_";
NSString *const kSquareRepaymentResultSettleAmount = @"settle_amount_";
NSString *const kSquareRepaymentResultSocket = @"socket";


@interface SquareRepaymentResult ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SquareRepaymentResult

@synthesize availableRedpackets = _availableRedpackets;
@synthesize totalAmount = _totalAmount;
@synthesize reapyInterest = _reapyInterest;
@synthesize settleAmount = _settleAmount;
@synthesize socket = _socket;


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
    NSObject *receivedSquareRepaymentAvailableRedpackets = [dict objectForKey:kSquareRepaymentResultAvailableRedpackets];
    NSMutableArray *parsedSquareRepaymentAvailableRedpackets = [NSMutableArray array];
    if ([receivedSquareRepaymentAvailableRedpackets isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedSquareRepaymentAvailableRedpackets) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedSquareRepaymentAvailableRedpackets addObject:[SquareRepaymentAvailableRedpackets modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedSquareRepaymentAvailableRedpackets isKindOfClass:[NSDictionary class]]) {
       [parsedSquareRepaymentAvailableRedpackets addObject:[SquareRepaymentAvailableRedpackets modelObjectWithDictionary:(NSDictionary *)receivedSquareRepaymentAvailableRedpackets]];
    }

    self.availableRedpackets = [NSArray arrayWithArray:parsedSquareRepaymentAvailableRedpackets];
            self.totalAmount = [self objectOrNilForKey:kSquareRepaymentResultTotalAmount fromDictionary:dict];
            self.reapyInterest = [self objectOrNilForKey:kSquareRepaymentResultReapyInterest fromDictionary:dict];
            self.settleAmount = [self objectOrNilForKey:kSquareRepaymentResultSettleAmount fromDictionary:dict];
            self.socket = [self objectOrNilForKey:kSquareRepaymentResultSocket fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForAvailableRedpackets = [NSMutableArray array];
    for (NSObject *subArrayObject in self.availableRedpackets) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForAvailableRedpackets addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForAvailableRedpackets addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForAvailableRedpackets] forKey:kSquareRepaymentResultAvailableRedpackets];
    [mutableDict setValue:self.totalAmount forKey:kSquareRepaymentResultTotalAmount];
    [mutableDict setValue:self.reapyInterest forKey:kSquareRepaymentResultReapyInterest];
    [mutableDict setValue:self.settleAmount forKey:kSquareRepaymentResultSettleAmount];
    [mutableDict setValue:self.socket forKey:kSquareRepaymentResultSocket];

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

    self.availableRedpackets = [aDecoder decodeObjectForKey:kSquareRepaymentResultAvailableRedpackets];
    self.totalAmount = [aDecoder decodeObjectForKey:kSquareRepaymentResultTotalAmount];
    self.reapyInterest = [aDecoder decodeObjectForKey:kSquareRepaymentResultReapyInterest];
    self.settleAmount = [aDecoder decodeObjectForKey:kSquareRepaymentResultSettleAmount];
    self.socket = [aDecoder decodeObjectForKey:kSquareRepaymentResultSocket];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_availableRedpackets forKey:kSquareRepaymentResultAvailableRedpackets];
    [aCoder encodeObject:_totalAmount forKey:kSquareRepaymentResultTotalAmount];
    [aCoder encodeObject:_reapyInterest forKey:kSquareRepaymentResultReapyInterest];
    [aCoder encodeObject:_settleAmount forKey:kSquareRepaymentResultSettleAmount];
    [aCoder encodeObject:_socket forKey:kSquareRepaymentResultSocket];
}

- (id)copyWithZone:(NSZone *)zone
{
    SquareRepaymentResult *copy = [[SquareRepaymentResult alloc] init];
    
    if (copy) {

        copy.availableRedpackets = [self.availableRedpackets copyWithZone:zone];
        copy.totalAmount = [self.totalAmount copyWithZone:zone];
        copy.reapyInterest = [self.reapyInterest copyWithZone:zone];
        copy.settleAmount = [self.settleAmount copyWithZone:zone];
        copy.socket = [self.socket copyWithZone:zone];
    }
    
    return copy;
}


@end
