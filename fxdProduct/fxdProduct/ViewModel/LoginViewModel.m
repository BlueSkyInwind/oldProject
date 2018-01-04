//
//  LoginViewModel.m
//  fxdProduct
//
//  Created by dd on 16/1/7.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "LoginViewModel.h"
#import "LoginParse.h"
#import "DES3Util.h"
#import "GetCustomerBaseViewModel.h"
#import "DataWriteAndRead.h"
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
        loginParamModel.last_login_ip_ = [[FXD_Tool share] getIPAddress];
        loginParamModel.platform_type_ = PLATFORM;
        loginParamModel.BSFIT_DEVICEID = fingerPrint;
        
    } else {
        
        loginParamModel.mobile_phone_ = number;
//        loginParamModel.password_ = @"znjFMmtJoj4=";
        loginParamModel.password_ = [DES3Util encrypt:password];
        loginParamModel.last_login_device_ = [FXD_Utility sharedUtility].userInfo.uuidStr;
        loginParamModel.app_version_ = app_Version;
        loginParamModel.last_login_from_ = PLATFORM;
        loginParamModel.last_login_ip_ = [[FXD_Tool share] getIPAddress];;
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
    
    [[FXD_NetWorkRequestManager sharedNetWorkManager] DataRequestWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_login_url] isNeedNetStatus:true isNeedWait:true parameters:paramDic finished:^(EnumServerStatus status, id object) {
        BaseResultModel * baseResultM = [[BaseResultModel alloc]initWithDictionary:(NSDictionary *)object error:nil];
        if ([baseResultM.errCode isEqualToString:@"0"]) {
            LoginParse *loginParse = [[LoginParse alloc]initWithDictionary:(NSDictionary *)baseResultM.data error:nil];
            [FXD_Utility sharedUtility].userInfo.loginMsgModel = loginParse;
            [FXD_Utility sharedUtility].userInfo.account_id = loginParse.user_id_;
            if (loginParse.juid != nil && ![loginParse.juid isEqualToString:@""]) {
                //储存用户标识juid
                [FXD_Tool saveUserDefaul:loginParse.juid Key:Fxd_JUID];
                [FXD_Utility sharedUtility].userInfo.juid = loginParse.juid;
                [FXD_Tool saveUserDefaul:loginParse.invitation_code Key:kInvitationCode];
                //保存登录状态
                [FXD_Utility sharedUtility].loginFlage = 1;
                [FXD_Tool saveUserDefaul:@"1" Key:kLoginFlag];
                //储存用户手机号
                NSString * phoneNum = [paramDic objectForKey:@"mobile_phone_"];
                [FXD_Tool saveUserDefaul:phoneNum Key:UserName];
                [FXD_Utility sharedUtility].userInfo.userMobilePhone = phoneNum;
                //获取登录token
                NSDictionary * tempDic = (NSDictionary *)baseResultM.data;
                NSString * keyToken = [NSString stringWithFormat:@"%@token",loginParse.juid];
                if ([FXD_Tool dicContainsKey:tempDic keyValue:keyToken]) {
                    [FXD_Tool saveUserDefaul:[tempDic objectForKey:keyToken] Key:Fxd_Token];
                    [FXD_Utility sharedUtility].userInfo.tokenStr = [tempDic objectForKey:keyToken];
                }
            }
            DLog(@"token -- %@  \n  juid -- %@",[FXD_Utility sharedUtility].userInfo.tokenStr,[FXD_Utility sharedUtility].userInfo.juid);
            [self PostPersonInfoMessage];
            //上传推送id
            [self uploadUserRegisterID:[JPUSHService registrationID]];


        }
        self.returnBlock(baseResultM);
    } failure:^(EnumServerStatus status, id object) {
        self.faileBlock();
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

    [[FXD_NetWorkRequestManager sharedNetWorkManager] GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_updateLoginLatitude_url] isNeedNetStatus:true isNeedWait:true parameters:paramDic finished:^(EnumServerStatus status, id object) {
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
      BaseResultModel  * baseResultM = returnValue;
        if ([baseResultM.errCode isEqualToString:@"0"]) {
            UserDataInformationModel * userDataInfoM = [[UserDataInformationModel alloc]initWithDictionary:(NSDictionary *)baseResultM.data error:nil];
            [DataWriteAndRead writeDataWithkey:UserInfomation value:userDataInfoM];
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
    [[FXD_NetWorkRequestManager sharedNetWorkManager]GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_loginOutDeleteRegisterId_url] isNeedNetStatus:false isNeedWait:true parameters:nil finished:^(EnumServerStatus status, id object) {
        DLog(@"%@",object);
    } failure:^(EnumServerStatus status, id object) {
        DLog(@"%@",object);
    }];
}

/**
 更新设备

 @param mobliePhone 手机号
 @param verify_code_ 验证码
 */
-(void)updateDeviceID:(NSString *)mobliePhone verify_code:(NSString *)verify_code_{
    
    LoginUpdateDeviceParamModel *  loginUpdateDeviceParam = [[LoginUpdateDeviceParamModel alloc]init];
    loginUpdateDeviceParam.mobile_phone_ = mobliePhone;
    loginUpdateDeviceParam.verify_code_ = verify_code_;
    loginUpdateDeviceParam.service_platform_type_ = SERVICE_PLATFORM;
    loginUpdateDeviceParam.last_login_device_ = [FXD_Utility sharedUtility].userInfo.uuidStr;
    NSDictionary * paramDic = [loginUpdateDeviceParam toDictionary];
    
    [[FXD_NetWorkRequestManager sharedNetWorkManager] DataRequestWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_updateDevID_url] isNeedNetStatus:true isNeedWait:true parameters:paramDic finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            BaseResultModel * baseResultM = [[BaseResultModel alloc]initWithDictionary:(NSDictionary *)object error:nil];
            self.returnBlock(baseResultM);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            self.faileBlock();
        }
    }];
}

-(void)userLoginOut{
    
    [[FXD_NetWorkRequestManager sharedNetWorkManager] GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_loginOut_url] isNeedNetStatus:true isNeedWait:true parameters:nil finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            BaseResultModel * baseResultM = [[BaseResultModel alloc]initWithDictionary:(NSDictionary *)object error:nil];
            self.returnBlock(baseResultM);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            self.faileBlock();
        }
    }];
}



@end
