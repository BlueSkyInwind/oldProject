//
//  UserStateBaseClass.h
//
//  Created by dd  on 15/12/21
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserStateResult.h"
#import "UserStateBaseClass.h"

@class UserStateResult;

@interface UserStateBaseClass : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *flag;
@property (nonatomic, strong) NSString *msg;
@property (nonatomic, strong) UserStateResult *result;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
