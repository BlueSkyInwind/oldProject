//
//  SetTransactionPasswordViewModel.m
//  fxdProduct
//
//  Created by admin on 2017/11/24.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "SetTransactionPasswordViewModel.h"

@implementation SetTransactionPasswordViewModel

/**
 验证身份证

 @param IDnum <#IDnum description#>
 */
-(void)VerifyIdentityCardNumber:(NSString *)IDnum{
    
    NSDictionary *paramDic = @{@"identityNo":IDnum};
    
    [[FXD_NetWorkRequestManager sharedNetWorkManager]DataRequestWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_verifyIdentityCard_url] isNeedNetStatus:YES isNeedWait:YES parameters:paramDic finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            self.returnBlock(object);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            [self faileBlock];
        }
    }];
    
    
}



@end
