//
//  RepayWeeklyRecordViewModel.h
//  fxdProduct
//
//  Created by sxp on 17/6/9.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "FXD_ViewModelBaseClass.h"

@interface RepayWeeklyRecordViewModel : FXD_ViewModelBaseClass

/**
 还款记录列表
 */
-(void)getRepayHistoryList;

/**
 借款记录列表
 */
-(void)getMoneyHistoryList;


/**
 我的银行卡列表
 */
-(void)bankCardList;
@end
