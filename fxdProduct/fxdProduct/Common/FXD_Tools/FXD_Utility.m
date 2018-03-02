//
//  FXD_Utility.m
//  fxdProduct
//
//  Created by dd on 15/9/25.
//  Copyright © 2015年 dd. All rights reserved.
//

#import "FXD_Utility.h"
#import "DataWriteAndRead.h"
#import "AppDelegate.h"


@implementation FXD_Utility

@synthesize userInfo;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.userInfo = [[FXD_UserInfoConfiguration alloc] init];
        self.popArray = [NSMutableArray array];
        self.isActivityShow = true;
        self.isHomeChooseShow = true;
    }
    return self;
}

+ (FXD_Utility *)sharedUtility
{
    static FXD_Utility *sharedUtilityInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedUtilityInstance = [[self alloc] init];
    });
    return sharedUtilityInstance;
}

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
    [FXD_Utility sharedUtility].isActivityShow = true;
    [FXD_Utility sharedUtility].isHomeChooseShow = true;
    
}

@end
