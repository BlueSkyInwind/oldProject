//
//  weeklyRecordCell.h
//  fxdProduct
//
//  Created by zy on 16/1/20.
//  Copyright © 2016年 dd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RepayWeeklyRecord.h"
@interface weeklyRecordCell : UITableViewCell
@property (nonatomic,strong) UILabel *lblPeriod;
@property (nonatomic,strong) UILabel *lblMoney;
@property (nonatomic,strong) UILabel *lblInterest;
@property (nonatomic,strong) UILabel *lblDefautInterest;
@property (nonatomic,strong) UILabel *lblDefaultMoney;
@property (nonatomic,strong) UILabel *lblDate;
-(void)setCellValues:(RepayWeeklyRecord*)weekymodel;
@end
