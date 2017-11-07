//
//  SquareRepaymentBaseClass.m
//
//  Created by dd  on 16/5/25
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "SquareRepaymentBaseClass.h"
#import "SquareRepaymentExt.h"
#import "SquareRepaymentResult.h"


NSString *const kSquareRepaymentBaseClassFlag = @"flag";
NSString *const kSquareRepaymentBaseClassExt = @"ext";
NSString *const kSquareRepaymentBaseClassResult = @"result";
NSString *const kSquareRepaymentBaseClassMsg = @"msg";


@interface SquareRepaymentBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SquareRepaymentBaseClass

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
            self.flag = [self objectOrNilForKey:kSquareRepaymentBaseClassFlag fromDictionary:dict];
            self.ext = [SquareRepaymentExt modelObjectWithDictionary:[dict objectForKey:kSquareRepaymentBaseClassExt]];
            self.result = [SquareRepaymentResult modelObjectWithDictionary:[dict objectForKey:kSquareRepaymentBaseClassResult]];
            self.msg = [self objectOrNilForKey:kSquareRepaymentBaseClassMsg fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.flag forKey:kSquareRepaymentBaseClassFlag];
    [mutableDict setValue:[self.ext dictionaryRepresentation] forKey:kSquareRepaymentBaseClassExt];
    [mutableDict setValue:[self.result dictionaryRepresentation] forKey:kSquareRepaymentBaseClassResult];
    [mutableDict setValue:self.msg forKey:kSquareRepaymentBaseClassMsg];

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

    self.flag = [aDecoder decodeObjectForKey:kSquareRepaymentBaseClassFlag];
    self.ext = [aDecoder decodeObjectForKey:kSquareRepaymentBaseClassExt];
    self.result = [aDecoder decodeObjectForKey:kSquareRepaymentBaseClassResult];
    self.msg = [aDecoder decodeObjectForKey:kSquareRepaymentBaseClassMsg];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_flag forKey:kSquareRepaymentBaseClassFlag];
    [aCoder encodeObject:_ext forKey:kSquareRepaymentBaseClassExt];
    [aCoder encodeObject:_result forKey:kSquareRepaymentBaseClassResult];
    [aCoder encodeObject:_msg forKey:kSquareRepaymentBaseClassMsg];
}

- (id)copyWithZone:(NSZone *)zone
{
    SquareRepaymentBaseClass *copy = [[SquareRepaymentBaseClass alloc] init];
    
    if (copy) {

        copy.flag = [self.flag copyWithZone:zone];
        copy.ext = [self.ext copyWithZone:zone];
        copy.result = [self.result copyWithZone:zone];
        copy.msg = [self.msg copyWithZone:zone];
    }
    
    return copy;
}


@end
