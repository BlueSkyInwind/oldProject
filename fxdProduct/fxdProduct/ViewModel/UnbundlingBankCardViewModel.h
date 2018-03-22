//
//  UnbundlingBankCardViewModel.h
//  fxdProduct
//
//  Created by sxp on 17/6/1.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "FXD_ViewModelBaseClass.h"

@interface UnbundlingBankCardViewModel : FXD_ViewModelBaseClass

/**
 发薪贷添加银行卡更换银行卡
 */
-(void)saveAccountBankCard:(NSMutableArray *)paramArray;

@end
