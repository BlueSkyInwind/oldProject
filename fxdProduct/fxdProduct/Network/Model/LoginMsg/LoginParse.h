//
//  LoginParse.h
//  fxdProduct
//
//  Created by dd on 2017/2/9.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LoginParseResult;


@interface LoginParse : NSObject

@property (nonatomic, copy) NSString *flag;
@property (nonatomic, strong) LoginParseResult *result;
@property (nonatomic ,copy) NSString *msg;

@end

@interface LoginParseResult : NSObject

@property (nonatomic ,copy) NSString *juid;
@property (nonatomic ,copy) NSString *user_id_;
@property (nonatomic, copy) NSString *invitation_code;

@end
