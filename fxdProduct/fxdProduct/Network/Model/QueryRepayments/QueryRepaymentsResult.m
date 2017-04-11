//
//  QueryRepaymentsResult.m
//
//  Created by dd  on 15/10/10
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "QueryRepaymentsResult.h"
#import "QueryRepaymentsData.h"


NSString *const kQueryRepaymentsResultData = @"data";
NSString *const kQueryRepaymentsResultVoucherNumber = @"voucherNumber";
NSString *const kQueryRepaymentsResultManagerExpense = @"managerExpense";
NSString *const kQueryRepaymentsResultTotalAmount = @"totalAmount";
NSString *const kQueryRepaymentsResultDay = @"day";
NSString *const kQueryRepaymentsResultRepaymentAmount = @"repaymentAmount";


@interface QueryRepaymentsResult ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation QueryRepaymentsResult

@synthesize data = _data;
@synthesize voucherNumber = _voucherNumber;
@synthesize managerExpense = _managerExpense;
@synthesize totalAmount = _totalAmount;
@synthesize day = _day;
@synthesize repaymentAmount = _repaymentAmount;


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
    NSObject *receivedQueryRepaymentsData = [dict objectForKey:kQueryRepaymentsResultData];
    NSMutableArray *parsedQueryRepaymentsData = [NSMutableArray array];
    if ([receivedQueryRepaymentsData isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedQueryRepaymentsData) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedQueryRepaymentsData addObject:[QueryRepaymentsData modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedQueryRepaymentsData isKindOfClass:[NSDictionary class]]) {
       [parsedQueryRepaymentsData addObject:[QueryRepaymentsData modelObjectWithDictionary:(NSDictionary *)receivedQueryRepaymentsData]];
    }

    self.data = [NSArray arrayWithArray:parsedQueryRepaymentsData];
            self.voucherNumber = [[self objectOrNilForKey:kQueryRepaymentsResultVoucherNumber fromDictionary:dict] doubleValue];
            self.managerExpense = [[self objectOrNilForKey:kQueryRepaymentsResultManagerExpense fromDictionary:dict] doubleValue];
            self.totalAmount = [[self objectOrNilForKey:kQueryRepaymentsResultTotalAmount fromDictionary:dict] doubleValue];
            self.day = [[self objectOrNilForKey:kQueryRepaymentsResultDay fromDictionary:dict] doubleValue];
            self.repaymentAmount = [[self objectOrNilForKey:kQueryRepaymentsResultRepaymentAmount fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForData = [NSMutableArray array];
    for (NSObject *subArrayObject in self.data) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForData addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForData addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForData] forKey:kQueryRepaymentsResultData];
    [mutableDict setValue:[NSNumber numberWithDouble:self.voucherNumber] forKey:kQueryRepaymentsResultVoucherNumber];
    [mutableDict setValue:[NSNumber numberWithDouble:self.managerExpense] forKey:kQueryRepaymentsResultManagerExpense];
    [mutableDict setValue:[NSNumber numberWithDouble:self.totalAmount] forKey:kQueryRepaymentsResultTotalAmount];
    [mutableDict setValue:[NSNumber numberWithDouble:self.day] forKey:kQueryRepaymentsResultDay];
    [mutableDict setValue:[NSNumber numberWithDouble:self.repaymentAmount] forKey:kQueryRepaymentsResultRepaymentAmount];

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

    self.data = [aDecoder decodeObjectForKey:kQueryRepaymentsResultData];
    self.voucherNumber = [aDecoder decodeDoubleForKey:kQueryRepaymentsResultVoucherNumber];
    self.managerExpense = [aDecoder decodeDoubleForKey:kQueryRepaymentsResultManagerExpense];
    self.totalAmount = [aDecoder decodeDoubleForKey:kQueryRepaymentsResultTotalAmount];
    self.day = [aDecoder decodeDoubleForKey:kQueryRepaymentsResultDay];
    self.repaymentAmount = [aDecoder decodeDoubleForKey:kQueryRepaymentsResultRepaymentAmount];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_data forKey:kQueryRepaymentsResultData];
    [aCoder encodeDouble:_voucherNumber forKey:kQueryRepaymentsResultVoucherNumber];
    [aCoder encodeDouble:_managerExpense forKey:kQueryRepaymentsResultManagerExpense];
    [aCoder encodeDouble:_totalAmount forKey:kQueryRepaymentsResultTotalAmount];
    [aCoder encodeDouble:_day forKey:kQueryRepaymentsResultDay];
    [aCoder encodeDouble:_repaymentAmount forKey:kQueryRepaymentsResultRepaymentAmount];
}

- (id)copyWithZone:(NSZone *)zone
{
    QueryRepaymentsResult *copy = [[QueryRepaymentsResult alloc] init];
    
    if (copy) {

        copy.data = [self.data copyWithZone:zone];
        copy.voucherNumber = self.voucherNumber;
        copy.managerExpense = self.managerExpense;
        copy.totalAmount = self.totalAmount;
        copy.day = self.day;
        copy.repaymentAmount = self.repaymentAmount;
    }
    
    return copy;
}


@end
