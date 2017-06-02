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

-(void)sendSmsSHService:(NSString *)bankNo BusiType:(NSString *)busi_type SmsType:(NSString *)sms_type;

@end
