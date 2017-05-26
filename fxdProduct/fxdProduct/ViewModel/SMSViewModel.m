//
//  SMSViewModel.m
//  fxdProduct
//
//  Created by dd on 15/12/28.
//  Copyright © 2015年 dd. All rights reserved.
//

#import "SMSViewModel.h"

@implementation SMSViewModel

/**
 发送验证码请求
 
 @param number 手机号
 @param flag 验证码类型
 */
- (void)fatchRequestSMSParamPhoneNumber:(NSString *)number flag:(NSString *)flag
{
    SMSModel * model  = [[SMSModel alloc]init];
    model.mobile_phone_  = number;
    model.flag = flag;
    NSDictionary *paramDic = [model toDictionary];
    
    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_getCode_url] parameters:paramDic finished:^(EnumServerStatus status, id object) {
        ReturnMsgBaseClass *returnModel = [ReturnMsgBaseClass modelObjectWithDictionary:object];
        self.returnBlock(returnModel);
    } failure:^(EnumServerStatus status, id object) {
        [self faileBlock];
    }];
    
}

@end
