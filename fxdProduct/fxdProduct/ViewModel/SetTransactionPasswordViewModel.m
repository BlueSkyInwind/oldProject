//
//  SetTransactionPasswordViewModel.m
//  fxdProduct
//
//  Created by admin on 2017/11/24.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "SetTransactionPasswordViewModel.h"

@implementation SetTransactionPasswordViewModel

/**
 验证身份证

 @param IDnum 身份证号
 */
-(void)VerifyIdentityCardNumber:(NSString *)IDnum{
    
    NSDictionary *paramDic = @{@"identityNo":IDnum};
    
    [[FXD_NetWorkRequestManager sharedNetWorkManager]DataRequestWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_verifyIdentityCard_url] isNeedNetStatus:YES isNeedWait:YES parameters:paramDic finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            self.returnBlock(object);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            self.faileBlock(object);
        }
    }];
}

/**
 验证就交易密码

 @param password 旧密码
 */
-(void)VerifyOldTradePassword:(NSString *)password{
    
    NSDictionary *paramDic = @{@"oldPassword": [[password DF_hashCode] AES256JAVA_Encrypt:Fxd_pw]};
    
    [[FXD_NetWorkRequestManager sharedNetWorkManager]GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_verifyOldPassword_url] isNeedNetStatus:true parameters:paramDic finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            self.returnBlock(object);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            self.faileBlock(object);
        }
    }];
}

/**
 保存新的交易密码

 @param firstPassword 首次密码
 @param secondpassword 二次密码
 @param operateType 操作类型   1设置、2重置
 */
-(void)saveNewTradePasswordFirst:(NSString *)firstPassword second:(NSString *)secondpassword operateType:(NSString *)operateType verify_code:(NSString *)verify_code{
    
    SetTradePasswordParam * tradePasswordP = [[SetTradePasswordParam  alloc]init];
    tradePasswordP.firstPassword = [[firstPassword DF_hashCode] AES256JAVA_Encrypt:Fxd_pw];
    tradePasswordP.secondPassword =  [[secondpassword DF_hashCode] AES256JAVA_Encrypt:Fxd_pw];
    tradePasswordP.type = operateType;
    tradePasswordP.verify_code = verify_code;
    NSDictionary *paramDic = [tradePasswordP toDictionary];
    
    [[FXD_NetWorkRequestManager sharedNetWorkManager]DataRequestWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_saveNewPassword_url] isNeedNetStatus:YES isNeedWait:YES parameters:paramDic finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            self.returnBlock(object);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            self.faileBlock(object);
        }
    }];
}

/**
 修改交易密码

 @param firstPassword 首次
 @param secondpassword 第二次
 @param oldPassword 旧 的
 */
-(void)modificationTradePasswordFirst:(NSString *)firstPassword second:(NSString *)secondpassword oldPassword:(NSString *)oldPassword{
    
    SetTradePasswordParam * tradePasswordP = [[SetTradePasswordParam  alloc]init];
    tradePasswordP.firstPassword = [[firstPassword DF_hashCode] AES256JAVA_Encrypt:Fxd_pw];
    tradePasswordP.secondPassword =  [[secondpassword DF_hashCode] AES256JAVA_Encrypt:Fxd_pw];
    tradePasswordP.oldPassword = oldPassword;
    NSDictionary *paramDic = [tradePasswordP toDictionary];
    
    [[FXD_NetWorkRequestManager sharedNetWorkManager]DataRequestWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_modificationPassword_url] isNeedNetStatus:YES isNeedWait:YES parameters:paramDic finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            self.returnBlock(object);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            self.faileBlock(object);
        }
    }];
    
}


/**
 效验交易验证码

 @param verify_code_ 验证码
 */
-(void)verifyTradeSMS:(NSString *)verify_code_{
    
    NSDictionary * paramDic =  @{@"flag":CODE_TRADEPASSWORD,
                            @"mobile_phone_": [FXD_Utility sharedUtility].userInfo.userMobilePhone,
                            @"verify_code_":verify_code_};

    [[FXD_NetWorkRequestManager sharedNetWorkManager]GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_verifyTradeSMS_url] isNeedNetStatus:true parameters:paramDic finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            self.returnBlock(object);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            self.faileBlock(object);
        }
    }];
}




@end
