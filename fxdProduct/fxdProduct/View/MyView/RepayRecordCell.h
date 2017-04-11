//
//  RepayRecordCell.h
//  fxdProduct
//
//  Created by zy on 15/12/15.
//  Copyright © 2015年 dd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RepayRecordCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblMoney;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet UILabel *lblRepayWeekly;
@property (weak, nonatomic) IBOutlet UILabel *lblRepayTotal;
@property (weak, nonatomic) IBOutlet UILabel *lblApplyTime;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *lblState;
@end
