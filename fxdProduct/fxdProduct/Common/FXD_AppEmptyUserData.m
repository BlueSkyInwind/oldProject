//
//  FXD_AppEmptyUserData.m
//  fxdProduct
//
//  Created by dd on 2016/11/28.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "FXD_AppEmptyUserData.h"
#import "DataWriteAndRead.h"
#import "AppDelegate.h"

@implementation FXD_AppEmptyUserData

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
