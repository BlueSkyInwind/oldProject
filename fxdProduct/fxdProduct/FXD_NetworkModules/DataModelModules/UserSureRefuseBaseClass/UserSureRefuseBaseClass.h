//
//  UserSureRefuseBaseClass.h
//
//  Created by   on 15/10/29
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserSureRefuseResult.h"
#import "UserSureRefuseBaseClass.h"

@class UserSureRefuseResult;

@interface UserSureRefuseBaseClass : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) UserSureRefuseResult *result;
@property (nonatomic, strong) NSString *flag;
@property (nonatomic, strong) NSString *msg;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
