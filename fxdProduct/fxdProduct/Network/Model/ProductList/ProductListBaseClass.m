//
//  ProductListBaseClass.m
//
//  Created by dd  on 16/3/30
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "ProductListBaseClass.h"
#import "ProductListExt.h"
#import "ProductListResult.h"


NSString *const kProductListBaseClassFlag = @"flag";
NSString *const kProductListBaseClassExt = @"ext";
NSString *const kProductListBaseClassResult = @"result";
NSString *const kProductListBaseClassMsg = @"msg";


@interface ProductListBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ProductListBaseClass

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
            self.flag = [self objectOrNilForKey:kProductListBaseClassFlag fromDictionary:dict];
            self.ext = [ProductListExt modelObjectWithDictionary:[dict objectForKey:kProductListBaseClassExt]];
    NSObject *receivedProductListResult = [dict objectForKey:kProductListBaseClassResult];
    NSMutableArray *parsedProductListResult = [NSMutableArray array];
    if ([receivedProductListResult isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedProductListResult) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedProductListResult addObject:[ProductListResult modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedProductListResult isKindOfClass:[NSDictionary class]]) {
       [parsedProductListResult addObject:[ProductListResult modelObjectWithDictionary:(NSDictionary *)receivedProductListResult]];
    }

    self.result = [NSArray arrayWithArray:parsedProductListResult];
            self.msg = [self objectOrNilForKey:kProductListBaseClassMsg fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.flag forKey:kProductListBaseClassFlag];
    [mutableDict setValue:[self.ext dictionaryRepresentation] forKey:kProductListBaseClassExt];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForResult] forKey:kProductListBaseClassResult];
    [mutableDict setValue:self.msg forKey:kProductListBaseClassMsg];

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

    self.flag = [aDecoder decodeObjectForKey:kProductListBaseClassFlag];
    self.ext = [aDecoder decodeObjectForKey:kProductListBaseClassExt];
    self.result = [aDecoder decodeObjectForKey:kProductListBaseClassResult];
    self.msg = [aDecoder decodeObjectForKey:kProductListBaseClassMsg];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_flag forKey:kProductListBaseClassFlag];
    [aCoder encodeObject:_ext forKey:kProductListBaseClassExt];
    [aCoder encodeObject:_result forKey:kProductListBaseClassResult];
    [aCoder encodeObject:_msg forKey:kProductListBaseClassMsg];
}

- (id)copyWithZone:(NSZone *)zone
{
    ProductListBaseClass *copy = [[ProductListBaseClass alloc] init];
    
    if (copy) {

        copy.flag = [self.flag copyWithZone:zone];
        copy.ext = [self.ext copyWithZone:zone];
        copy.result = [self.result copyWithZone:zone];
        copy.msg = [self.msg copyWithZone:zone];
    }
    
    return copy;
}


@end
