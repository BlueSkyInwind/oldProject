//
//  LoginMsgBaseClass.h
//
//  Created by dd  on 16/3/23
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginMsgExt.h"
#import "LoginMsgResult.h"
#import "LoginMsgBaseClass.h"

@class LoginMsgExt, LoginMsgResult;

@interface LoginMsgBaseClass : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *flag;
@property (nonatomic, strong) LoginMsgExt *ext;
@property (nonatomic, strong) LoginMsgResult *result;
@property (nonatomic, strong) NSString *msg;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
