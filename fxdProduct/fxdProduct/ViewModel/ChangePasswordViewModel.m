//
//  ChangePasswordViewModel.m
//  fxdProduct
//
//  Created by admin on 2017/6/2.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "ChangePasswordViewModel.h"
#import "ReturnMsgBaseClass.h"

@implementation ChangePasswordViewModel

-(void)fetchChangePassowrdCurrent:(NSString *)CurrentPassword new:(NSString *)newPassword{
    changePasswordParam *  changePassword = [[changePasswordParam alloc]init];
    changePassword.mobile_phone_ = [Utility sharedUtility].userInfo.userMobilePhone;
    changePassword.old_password_ = CurrentPassword;
    changePassword.update_password_ = newPassword;
    
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






@end
