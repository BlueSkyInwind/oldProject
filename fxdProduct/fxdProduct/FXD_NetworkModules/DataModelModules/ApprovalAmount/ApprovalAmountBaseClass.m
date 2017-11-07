//
//  ApprovalAmountBaseClass.m
//
//  Created by dd  on 16/3/30
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "ApprovalAmountBaseClass.h"
#import "ApprovalAmountExt.h"
#import "ApprovalAmountResult.h"


NSString *const kApprovalAmountBaseClassFlag = @"flag";
NSString *const kApprovalAmountBaseClassExt = @"ext";
NSString *const kApprovalAmountBaseClassResult = @"result";
NSString *const kApprovalAmountBaseClassMsg = @"msg";


@interface ApprovalAmountBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ApprovalAmountBaseClass

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
            self.flag = [self objectOrNilForKey:kApprovalAmountBaseClassFlag fromDictionary:dict];
            self.ext = [ApprovalAmountExt modelObjectWithDictionary:[dict objectForKey:kApprovalAmountBaseClassExt]];
            self.result = [ApprovalAmountResult modelObjectWithDictionary:[dict objectForKey:kApprovalAmountBaseClassResult]];
            self.msg = [self objectOrNilForKey:kApprovalAmountBaseClassMsg fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.flag forKey:kApprovalAmountBaseClassFlag];
    [mutableDict setValue:[self.ext dictionaryRepresentation] forKey:kApprovalAmountBaseClassExt];
    [mutableDict setValue:[self.result dictionaryRepresentation] forKey:kApprovalAmountBaseClassResult];
    [mutableDict setValue:self.msg forKey:kApprovalAmountBaseClassMsg];

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

    self.flag = [aDecoder decodeObjectForKey:kApprovalAmountBaseClassFlag];
    self.ext = [aDecoder decodeObjectForKey:kApprovalAmountBaseClassExt];
    self.result = [aDecoder decodeObjectForKey:kApprovalAmountBaseClassResult];
    self.msg = [aDecoder decodeObjectForKey:kApprovalAmountBaseClassMsg];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_flag forKey:kApprovalAmountBaseClassFlag];
    [aCoder encodeObject:_ext forKey:kApprovalAmountBaseClassExt];
    [aCoder encodeObject:_result forKey:kApprovalAmountBaseClassResult];
    [aCoder encodeObject:_msg forKey:kApprovalAmountBaseClassMsg];
}

- (id)copyWithZone:(NSZone *)zone
{
    ApprovalAmountBaseClass *copy = [[ApprovalAmountBaseClass alloc] init];
    
    if (copy) {

        copy.flag = [self.flag copyWithZone:zone];
        copy.ext = [self.ext copyWithZone:zone];
        copy.result = [self.result copyWithZone:zone];
        copy.msg = [self.msg copyWithZone:zone];
    }
    
    return copy;
}


@end
