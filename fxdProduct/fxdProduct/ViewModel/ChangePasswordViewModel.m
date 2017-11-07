//
//  ChangePasswordViewModel.m
//  fxdProduct
//
//  Created by admin on 2017/6/2.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "ChangePasswordViewModel.h"
#import "ReturnMsgBaseClass.h"
#import "ChangePasswordParamModel.h"
#import "SendSmsParam.h"
#import "DES3Util.h"
@implementation ChangePasswordViewModel

-(void)fetchChangePassowrdCurrent:(NSString *)CurrentPassword new:(NSString *)newPassword{
    
    changePasswordParam *  changePassword = [[changePasswordParam alloc]init];
    changePassword.mobile_phone_ = [FXD_Utility sharedUtility].userInfo.userName;
    changePassword.old_password_ = [DES3Util encrypt:CurrentPassword];
    changePassword.update_password_ = [DES3Util encrypt:newPassword];
    
    NSDictionary * dic = [changePassword toDictionary];
    [self requestChangePassword:dic];
    
}


-(void)requestChangePassword:(NSDictionary *)paramDic{
    
    [[FXD_NetWorkRequestManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_changePassword_url] parameters:paramDic finished:^(EnumServerStatus status, id object) {
        ReturnMsgBaseClass *findParse = [ReturnMsgBaseClass modelObjectWithDictionary:object];
        self.returnBlock(findParse);
    } failure:^(EnumServerStatus status, id object) {
        [self faileBlock];
    }];
    
}

-(void)updatePasswordSmscode:(NSString *)smscode Password:(NSString *)password{

    NSDictionary *paramDic;
    if (![password isEqualToString:@""] && ![smscode isEqualToString:@""]) {
        ChangePasswordParamModel *changePasswordParamModel = [[ChangePasswordParamModel alloc]init];
        changePasswordParamModel.token = [FXD_Utility sharedUtility].userInfo.tokenStr;
        changePasswordParamModel.smscode = smscode;
        changePasswordParamModel.password = password;
        paramDic = [changePasswordParamModel toDictionary];
    }else{
    
        paramDic = nil;
    }
    
    [[FXD_NetWorkRequestManager sharedNetWorkManager]POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_CHANGEPASS_URL] parameters:paramDic finished:^(EnumServerStatus status, id object) {
        
        if (self.returnBlock) {
            self.returnBlock(object);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            [self faileBlock];
        }
    }];
}

-(void)changePasswordSendSMS{

    SendSmsParam *sendSmsParam = [[SendSmsParam alloc]init];
    sendSmsParam.token = [FXD_Utility sharedUtility].userInfo.tokenStr;
    sendSmsParam.phone = [FXD_Utility sharedUtility].userInfo.userName;
    sendSmsParam.type = CODE_CHANGEPASS;
    NSDictionary *paramDic = [sendSmsParam toDictionary];
    
    [[FXD_NetWorkRequestManager sharedNetWorkManager]POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_getCode_url] parameters:paramDic finished:^(EnumServerStatus status, id object) {
        
        if (self.returnBlock) {
            self.returnBlock(object);
        }
    } failure:^(EnumServerStatus status, id object) {
        
        if (self.faileBlock) {
            [self faileBlock];
        }
    }];
}


@end
