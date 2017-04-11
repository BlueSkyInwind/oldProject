//
//  LoginViewModel.m
//  fxdProduct
//
//  Created by dd on 16/1/7.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "LoginViewModel.h"
#import "LoginParse.h"
#import "DataBaseManager.h"

@implementation LoginViewModel

- (void)fatchLogin:(NSDictionary *)paramDic
{
    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_login_url] parameters:paramDic finished:^(EnumServerStatus status, id object) {
        LoginParse *loginParse = [LoginParse yy_modelWithJSON:object];
        if ([loginParse.flag isEqualToString:@"0000"]) {
            [Utility sharedUtility].userInfo.loginMsgModel = loginParse;
            [Utility sharedUtility].userInfo.account_id = [[object objectForKey:@"result"] objectForKey:@"user_id_"];
            if (loginParse.result.juid != nil && ![loginParse.result.juid isEqualToString:@""]) {
                [Tool saveUserDefaul:loginParse.result.juid Key:Fxd_JUID];
                [Tool saveUserDefaul:@"1" Key:kLoginFlag];
                [Tool saveUserDefaul:loginParse.result.invitation_code Key:kInvitationCode];
                [Tool saveUserDefaul:[paramDic objectForKey:@"mobile_phone_"] Key:UserName];
                [Utility sharedUtility].userInfo.juid = loginParse.result.juid;
                [Utility sharedUtility].loginFlage = 1;
                [Utility sharedUtility].userInfo.userName = [paramDic objectForKey:@"mobile_phone_"];
                if ([Tool dicContainsKey:[object objectForKey:@"result"] keyValue:[NSString stringWithFormat:@"%@token",loginParse.result.juid]]) {
                    [Tool saveUserDefaul:[[object objectForKey:@"result"] objectForKey:[NSString stringWithFormat:@"%@token",loginParse.result.juid]] Key:Fxd_Token];
                    [Utility sharedUtility].userInfo.tokenStr = [[object objectForKey:@"result"] objectForKey:[NSString stringWithFormat:@"%@token",loginParse.result.juid]];
                }
            }
            DLog(@"token -- %@  \n  juid -- %@",[Utility sharedUtility].userInfo.tokenStr,[Utility sharedUtility].userInfo.juid);
            
            //登录统计(账号)
            [MobClick profileSignInWithPUID:userTableName];
            //打开数据库
            [[DataBaseManager shareManager] dbOpen:userTableName];
        }
        self.returnBlock(loginParse);
    } failure:^(EnumServerStatus status, id object) {
        [self faileBlock];
    }];
}

@end
