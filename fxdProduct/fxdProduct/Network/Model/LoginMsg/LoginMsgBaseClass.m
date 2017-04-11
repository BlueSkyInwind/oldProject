//
//  LoginMsgBaseClass.m
//
//  Created by dd  on 16/3/23
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "LoginMsgBaseClass.h"
#import "LoginMsgExt.h"
#import "LoginMsgResult.h"


NSString *const kLoginMsgBaseClassFlag = @"flag";
NSString *const kLoginMsgBaseClassExt = @"ext";
NSString *const kLoginMsgBaseClassResult = @"result";
NSString *const kLoginMsgBaseClassMsg = @"msg";


@interface LoginMsgBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LoginMsgBaseClass

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
            self.flag = [self objectOrNilForKey:kLoginMsgBaseClassFlag fromDictionary:dict];
            self.ext = [LoginMsgExt modelObjectWithDictionary:[dict objectForKey:kLoginMsgBaseClassExt]];
            self.result = [LoginMsgResult modelObjectWithDictionary:[dict objectForKey:kLoginMsgBaseClassResult]];
            self.msg = [self objectOrNilForKey:kLoginMsgBaseClassMsg fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.flag forKey:kLoginMsgBaseClassFlag];
    [mutableDict setValue:[self.ext dictionaryRepresentation] forKey:kLoginMsgBaseClassExt];
    [mutableDict setValue:[self.result dictionaryRepresentation] forKey:kLoginMsgBaseClassResult];
    [mutableDict setValue:self.msg forKey:kLoginMsgBaseClassMsg];

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

    self.flag = [aDecoder decodeObjectForKey:kLoginMsgBaseClassFlag];
    self.ext = [aDecoder decodeObjectForKey:kLoginMsgBaseClassExt];
    self.result = [aDecoder decodeObjectForKey:kLoginMsgBaseClassResult];
    self.msg = [aDecoder decodeObjectForKey:kLoginMsgBaseClassMsg];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_flag forKey:kLoginMsgBaseClassFlag];
    [aCoder encodeObject:_ext forKey:kLoginMsgBaseClassExt];
    [aCoder encodeObject:_result forKey:kLoginMsgBaseClassResult];
    [aCoder encodeObject:_msg forKey:kLoginMsgBaseClassMsg];
}

- (id)copyWithZone:(NSZone *)zone
{
    LoginMsgBaseClass *copy = [[LoginMsgBaseClass alloc] init];
    
    if (copy) {

        copy.flag = [self.flag copyWithZone:zone];
        copy.ext = [self.ext copyWithZone:zone];
        copy.result = [self.result copyWithZone:zone];
        copy.msg = [self.msg copyWithZone:zone];
    }
    
    return copy;
}


@end
