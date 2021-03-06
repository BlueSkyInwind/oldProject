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
#import "DES3Util.h"
#import "GetCustomerBaseViewModel.h"
#import "DataWriteAndRead.h"
#import "CustomerBaseInfoBaseClass.h"
#import "JPUSHService.h"
@implementation LoginViewModel
/**
 登录请求

 @param number 手机号
 @param password 密码
 @param fingerPrint 设备指纹
 @param verifycode 验证码
 */
- (void)fatchLoginMoblieNumber:(NSString *)number password:(NSString *)password  fingerPrint:(NSString*)fingerPrint  verifyCode:(NSString *)verifycode
{
    
    NSString *app_Version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    DLog(@"uuid ----- %@",[FXD_Utility sharedUtility].userInfo.uuidStr);
    LoginParamModel * loginParamModel = [[LoginParamModel alloc]init];
    
    if ([FXD_Utility sharedUtility].userInfo.clientId && ![[FXD_Utility sharedUtility].userInfo.clientId isEqualToString:@""]) {
        
        loginParamModel.mobile_phone_ = number;
//        loginParamModel.password_ = @"znjFMmtJoj4=";
        loginParamModel.password_ = [DES3Util encrypt:password];
        loginParamModel.last_login_device_ = [FXD_Utility sharedUtility].userInfo.uuidStr;
        loginParamModel.app_version_ = app_Version;
        loginParamModel.last_login_from_ = PLATFORM;
        loginParamModel.last_login_ip_ = [[GetUserIP sharedUserIP] getIPAddress];
        loginParamModel.platform_type_ = PLATFORM;
        loginParamModel.BSFIT_DEVICEID = fingerPrint;
        
    } else {
        
        loginParamModel.mobile_phone_ = number;
//        loginParamModel.password_ = @"znjFMmtJoj4=";
        loginParamModel.password_ = [DES3Util encrypt:password];
        loginParamModel.last_login_device_ = [FXD_Utility sharedUtility].userInfo.uuidStr;
        loginParamModel.app_version_ = app_Version;
        loginParamModel.last_login_from_ = PLATFORM;
        loginParamModel.last_login_ip_ = [[GetUserIP sharedUserIP] getIPAddress];
        loginParamModel.platform_type_ = PLATFORM;
        loginParamModel.BSFIT_DEVICEID =fingerPrint;
    }
    if (verifycode) {
        loginParamModel.verify_code_  = verifycode;
    }
   NSDictionary  * paramDic =[loginParamModel toDictionary];
    [self fatchLogin:paramDic];
}
- (void)fatchLogin:(NSDictionary *)paramDic{
    
    [[FXD_NetWorkRequestManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_login_url] parameters:paramDic finished:^(EnumServerStatus status, id object) {
        LoginParse *loginParse = [LoginParse yy_modelWithJSON:object];
        if ([loginParse.flag isEqualToString:@"0000"]) {
            [FXD_Utility sharedUtility].userInfo.loginMsgModel = loginParse;
            [FXD_Utility sharedUtility].userInfo.account_id = [[object objectForKey:@"result"] objectForKey:@"user_id_"];
            if (loginParse.result.juid != nil && ![loginParse.result.juid isEqualToString:@""]) {
                [FXD_Tool saveUserDefaul:loginParse.result.juid Key:Fxd_JUID];
                [FXD_Tool saveUserDefaul:@"1" Key:kLoginFlag];
                [FXD_Tool saveUserDefaul:loginParse.result.invitation_code Key:kInvitationCode];
                [FXD_Tool saveUserDefaul:[paramDic objectForKey:@"mobile_phone_"] Key:UserName];
                [FXD_Utility sharedUtility].userInfo.juid = loginParse.result.juid;
                [FXD_Utility sharedUtility].loginFlage = 1;
                [FXD_Utility sharedUtility].userInfo.userName = [paramDic objectForKey:@"mobile_phone_"];
                [FXD_Utility sharedUtility].userInfo.userMobilePhone = [paramDic objectForKey:@"mobile_phone_"];
                if ([FXD_Tool dicContainsKey:[object objectForKey:@"result"] keyValue:[NSString stringWithFormat:@"%@token",loginParse.result.juid]]) {
                    [FXD_Tool saveUserDefaul:[[object objectForKey:@"result"] objectForKey:[NSString stringWithFormat:@"%@token",loginParse.result.juid]] Key:Fxd_Token];
                    [FXD_Utility sharedUtility].userInfo.tokenStr = [[object objectForKey:@"result"] objectForKey:[NSString stringWithFormat:@"%@token",loginParse.result.juid]];
                }
            }
            DLog(@"token -- %@  \n  juid -- %@",[FXD_Utility sharedUtility].userInfo.tokenStr,[FXD_Utility sharedUtility].userInfo.juid);
            
            [self PostPersonInfoMessage];
            //上传推送id
            [self uploadUserRegisterID:[JPUSHService registrationID]];
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

-(void)uploadLocationInfoLongitude:(NSString *)longitude Latitude:(NSString *)latitude{
    
    LoginLocationParamModel * loginLocationParamModel = [[LoginLocationParamModel alloc]init];
    loginLocationParamModel.last_longitude_  = longitude;
    loginLocationParamModel.last_latitude_  = latitude;
    
    NSDictionary  * paramDic =[loginLocationParamModel toDictionary];
    [self postUserLoginLocationInfo:paramDic];
    
}

-(void)postUserLoginLocationInfo:(NSDictionary *)paramDic{

    [[FXD_NetWorkRequestManager sharedNetWorkManager] POSTHideHUD:[NSString stringWithFormat:@"%@%@",_main_url,_updateLoginLatitude_url] parameters:paramDic finished:^(EnumServerStatus status, id object) {
        DLog(@"%@",object);
    } failure:^(EnumServerStatus status, id object) {
        DLog(@"%@",object);
    }];
}

#pragma mark->获取个人信息
-(void)PostPersonInfoMessage
{
    GetCustomerBaseViewModel *customBaseViewModel = [[GetCustomerBaseViewModel alloc] init];
    [customBaseViewModel setBlockWithReturnBlock:^(id returnValue) {
      CustomerBaseInfoBaseClass  * customerBase = returnValue;
        if ([customerBase.flag isEqualToString:@"0000"]) {
            [DataWriteAndRead writeDataWithkey:UserInfomation value:customerBase];
        }
    } WithFaileBlock:^{
        
    }];
    [customBaseViewModel fatchCustomBaseInfo:nil];
}

-(void)uploadUserRegisterID:(NSString *)registerID{
    //@"http://192.168.12.252:8012/excenter/jiguang/register"
    NSDictionary * paramDic  = @{@"registerId":registerID};
    [[FXD_NetWorkRequestManager sharedNetWorkManager] DataRequestWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_registerID_url] isNeedNetStatus:false isNeedWait:false parameters:paramDic finished:^(EnumServerStatus status, id object) {
        DLog(@"%@",object);
    } failure:^(EnumServerStatus status, id object) {
        DLog(@"%@",object);
    }];
}

-(void)deleteUserRegisterID{
    [[FXD_NetWorkRequestManager sharedNetWorkManager]GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_loginOutDeleteRegisterId_url] isNeedNetStatus:false parameters:nil finished:^(EnumServerStatus status, id object) {
        DLog(@"%@",object);
    } failure:^(EnumServerStatus status, id object) {
        DLog(@"%@",object);
    }];
}


@end
