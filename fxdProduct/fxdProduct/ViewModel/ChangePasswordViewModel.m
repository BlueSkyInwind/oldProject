//
//  ChangePasswordViewModel.m
//  fxdProduct
//
//  Created by admin on 2017/6/2.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "ChangePasswordViewModel.h"
#import "DES3Util.h"
@implementation ChangePasswordViewModel

-(void)fetchChangePassowrdCurrent:(NSString *)CurrentPassword new:(NSString *)newPassword{
    
    changePasswordParam *  changePassword = [[changePasswordParam alloc]init];
    changePassword.mobile_phone_ = [FXD_Utility sharedUtility].userInfo.userMobilePhone;
    changePassword.old_password_ = [DES3Util encrypt:CurrentPassword];
    changePassword.update_password_ = [DES3Util encrypt:newPassword];

    NSDictionary * dic = [changePassword toDictionary];
    [self requestChangePassword:dic];
    
}

-(void)requestChangePassword:(NSDictionary *)paramDic{
    
    [[HF_NetWorkRequestManager sharedNetWorkManager] DataRequestWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_changePassword_url] isNeedNetStatus:true isNeedWait:true parameters:paramDic finished:^(EnumServerStatus status, id object) {
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
