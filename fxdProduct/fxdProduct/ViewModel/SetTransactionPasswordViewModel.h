//
//  SetTransactionPasswordViewModel.h
//  fxdProduct
//
//  Created by admin on 2017/11/24.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "FXD_ViewModelBaseClass.h"

@interface SetTransactionPasswordViewModel : FXD_ViewModelBaseClass
/**
 验证身份证
 @param IDnum 身份证号
 */
-(void)VerifyIdentityCardNumber:(NSString *)IDnum;


@end
