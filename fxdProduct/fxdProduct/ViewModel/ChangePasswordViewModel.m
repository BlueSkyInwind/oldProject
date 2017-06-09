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
    changePassword.mobile_phone_ = [Utility sharedUtility].userInfo.userName;
    changePassword.old_password_ = [DES3Util encrypt:CurrentPassword];
    changePassword.update_password_ = [DES3Util encrypt:newPassword];
    
    NSDictionary * dic = [changePassword toDictionary];
    [self requestChangePassword:dic];
    
}


-(void)requestChangePassword:(NSDictionary *)paramDic{
    
    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_changePassword_url] parameters:paramDic finished:^(EnumServerStatus status, id object) {
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
        changePasswordParamModel.token = [Utility sharedUtility].userInfo.tokenStr;
        changePasswordParamModel.smscode = smscode;
        changePasswordParamModel.password = password;
        paramDic = [changePasswordParamModel toDictionary];
    }else{
    
        paramDic = nil;
    }
    
    
    [[FXDNetWorkManager sharedNetWorkManager]P2POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_CHANGEPASS_URL] parameters:paramDic finished:^(EnumServerStatus status, id object) {
        
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
    sendSmsParam.token = [Utility sharedUtility].userInfo.tokenStr;
    sendSmsParam.phone = [Utility sharedUtility].userInfo.userName;
    sendSmsParam.type = CODE_CHANGEPASS;
    NSDictionary *paramDic = [sendSmsParam toDictionary];
    
    [[FXDNetWorkManager sharedNetWorkManager]P2POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_getCode_url] parameters:paramDic finished:^(EnumServerStatus status, id object) {
        
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
