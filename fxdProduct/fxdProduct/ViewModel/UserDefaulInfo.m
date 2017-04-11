//
//  UserDefaulInfo.m
//  fxdProduct
//
//  Created by dd on 2017/1/5.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "UserDefaulInfo.h"
#import "Custom_BaseInfo.h"
#import "DataWriteAndRead.h"
#import "GetCustomerBaseViewModel.h"

@implementation UserDefaulInfo


+ (void)getUserInfoData
{
    DLog(@"%@",[Utility sharedUtility].userInfo.account_id);
    //    if ([[Utility sharedUtility].userInfo.account_id isEqualToString:@""] || [Utility sharedUtility].userInfo.account_id == nil) {
    id data = [DataWriteAndRead readDataWithkey:UserInfomation];
    if (data) {
        DLog(@"%@",data);
        Custom_BaseInfo *userInfo = data;
        if ([[Utility sharedUtility].userInfo.account_id isEqualToString:@""] || [Utility sharedUtility].userInfo.account_id == nil) {
//            [Utility sharedUtility].userInfo.account_id = userInfo.result.createBy
        }
        [Utility sharedUtility].userInfo.userIDNumber = userInfo.result.idCode;
        [Utility sharedUtility].userInfo.userMobilePhone = userInfo.ext.mobilePhone;
        [Utility sharedUtility].userInfo.realName = userInfo.result.customerName;
    } else {
        if ([Utility sharedUtility].loginFlage) {
            GetCustomerBaseViewModel *customBaseViewModel = [[GetCustomerBaseViewModel alloc] init];
            [customBaseViewModel setBlockWithReturnBlock:^(id returnValue) {
                Custom_BaseInfo *customerBase = returnValue;
                if ([customerBase.flag isEqualToString:@"0000"]) {
                    if (![customerBase.result.idCode isEqualToString:@""] && customerBase.result.idCode != nil) {
                        [DataWriteAndRead writeDataWithkey:UserInfomation value:customerBase];
                        [Utility sharedUtility].userInfo.userIDNumber = customerBase.result.idCode;
                        [Utility sharedUtility].userInfo.userMobilePhone = customerBase.ext.mobilePhone;
                        [Utility sharedUtility].userInfo.realName = customerBase.result.customerName;
                        if ([[Utility sharedUtility].userInfo.account_id isEqualToString:@""] || [Utility sharedUtility].userInfo.account_id == nil) {
                            [Utility sharedUtility].userInfo.account_id = customerBase.result.createBy;
                        }
                    } else {
                        [DataWriteAndRead writeDataWithkey:UserInfomation value:nil];
                    }
                }
            } WithFaileBlock:^{
                
            }];
            [customBaseViewModel fatchCustomBaseInfoNoHud:nil];
        }
    }
}

@end
