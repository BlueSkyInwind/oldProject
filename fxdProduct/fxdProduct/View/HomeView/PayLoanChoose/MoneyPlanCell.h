//
//  MoneyPlanCell.h
//  fxdProduct
//
//  Created by dd on 2017/2/7.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoneyPlanCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *operatorFeeLabel;

@property (weak, nonatomic) IBOutlet UILabel *sercerFee;
@property (weak, nonatomic) IBOutlet UILabel *finalAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *repayAmountLabel;

@end
