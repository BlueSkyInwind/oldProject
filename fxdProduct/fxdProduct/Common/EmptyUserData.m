//
//  EmptyUserData.m
//  fxdProduct
//
//  Created by dd on 2016/11/28.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "EmptyUserData.h"
#import "DataWriteAndRead.h"
#import "AppDelegate.h"

@implementation EmptyUserData

+ (void)EmptyData
{
    [Tool saveUserDefaul:nil Key:Fxd_JUID];
    [Tool saveUserDefaul:nil Key:kLoginFlag];
    [Tool saveUserDefaul:nil Key:Fxd_Token];
    [Tool saveUserDefaul:nil Key:UserName];
    [Tool saveUserDefaul:nil Key:kInvitationCode];
    [Utility sharedUtility].loginFlage = 0;
    [Utility sharedUtility].userInfo.juid = @"";
    [Utility sharedUtility].userInfo.tokenStr = @"";
    [Utility sharedUtility].userInfo.userName = @"";
    [Utility sharedUtility].userInfo.account_id = @"";
    [Utility sharedUtility].userInfo.userMobilePhone = @"";
    [Utility sharedUtility].userInfo.realName = @"";
    [Utility sharedUtility].userInfo.pruductId = @"";
    [DataWriteAndRead writeDataWithkey:UserInfomation value:nil];
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    appDelegate.isShow = true;
    appDelegate.isHomeChooseShow = true;

}

@end
