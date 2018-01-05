//
//  FXD_UserInfoConfiguration.m
//  fxdProduct
//
//  Created by dd on 15/9/25.
//  Copyright © 2015年 dd. All rights reserved.
//

#import "FXD_UserInfoConfiguration.h"
#import "DataWriteAndRead.h"
#import "AppDelegate.h"

@implementation FXD_UserInfoConfiguration


+ (void)EmptyData
{
    [FXD_Tool saveUserDefaul:nil Key:Fxd_JUID];
    [FXD_Tool saveUserDefaul:nil Key:kLoginFlag];
    [FXD_Tool saveUserDefaul:nil Key:Fxd_Token];
    [FXD_Tool saveUserDefaul:nil Key:UserName];
    [FXD_Tool saveUserDefaul:nil Key:kInvitationCode];
    [FXD_Utility sharedUtility].loginFlage = 0;
    [FXD_Utility sharedUtility].userInfo.juid = @"";
    [FXD_Utility sharedUtility].userInfo.tokenStr = @"";
    [FXD_Utility sharedUtility].userInfo.userMobilePhone = @"";
    [FXD_Utility sharedUtility].userInfo.account_id = @"";
    [FXD_Utility sharedUtility].userInfo.realName = @"";
    [FXD_Utility sharedUtility].userInfo.pruductId = @"";
    [DataWriteAndRead writeDataWithkey:UserInfomation value:nil];
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    appDelegate.isShow = true;
    appDelegate.isHomeChooseShow = true;
    
}


@end
