//
//  DetailRepayHeader.h
//  fxdProduct
//
//  Created by dd on 16/9/1.
//  Copyright © 2016年 dd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailRepayHeader : UIView

///借款时间
@property (weak, nonatomic) IBOutlet UILabel *sigingDayLabel;
///本金
@property (weak, nonatomic) IBOutlet UILabel *principalAmountLabel;
///服务费
@property (weak, nonatomic) IBOutlet UILabel *feeAmountLabel;
///合计金额
@property (weak, nonatomic) IBOutlet UILabel *repaymentAmountLabel;

@property (weak, nonatomic) IBOutlet UILabel *periodsLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *repaymentViewLeftCon;

@end
