//
//  RepayWeeklyRecordViewModel.h
//  fxdProduct
//
//  Created by sxp on 17/6/9.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "ViewModelClass.h"

@interface RepayWeeklyRecordViewModel : ViewModelClass

/**
 还款记录列表
 */
-(void)getRepayHistoryList;

/**
 借款记录列表
 */
-(void)getMoneyHistoryList;

/**
 我的红包列表
 */
-(void)getUserRedpacketList;

/**
 我的银行卡列表
 */
-(void)bankCardList;
@end
