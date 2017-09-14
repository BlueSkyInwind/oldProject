//
//  UnbundlingBankCardViewModel.h
//  fxdProduct
//
//  Created by sxp on 17/6/1.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "ViewModelClass.h"

@interface UnbundlingBankCardViewModel : ViewModelClass
/**
 合规发送验证码
 */

-(void)sendSmsSHServiceBankNo:(NSString *)bankNo BusiType:(NSString *)busi_type SmsType:(NSString *)sms_type Mobile:(NSString *)mobile;

/**合规更换银行卡*/

-(void)bankCardsSHServiceParamArray:(NSMutableArray *)paramArray;

/**
 发薪贷添加银行卡更换银行卡
 */
-(void)saveAccountBankCard:(NSMutableArray *)paramArray;

/**
 发薪贷添加银行卡获取银行卡列表
 */
//-(void)getBankList;
@end
