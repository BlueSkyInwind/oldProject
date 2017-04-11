//
//  weeklyRecordCell.m
//  fxdProduct
//
//  Created by zy on 16/1/20.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "weeklyRecordCell.h"

@implementation weeklyRecordCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self createUI];
    }
    return self;
}
-(void)createUI
{
 
    self.lblPeriod=[[UILabel alloc]initWithFrame:CGRectMake(15*_k_WSwitch, 0, 40*_k_WSwitch, 44)];
    self.lblPeriod.font=[UIFont systemFontOfSize:14];
//    self.lblPeriod.textAlignment=NSTextAlignmentRight;
    
    self.lblMoney=[[UILabel alloc]initWithFrame:CGRectMake(55*_k_WSwitch+(_k_w-70*_k_WSwitch)/5*0, 0, (_k_w-70*_k_WSwitch)/5, 44)];
    self.lblMoney.font=[UIFont systemFontOfSize:14];
    self.lblMoney.textAlignment=NSTextAlignmentCenter;
    
    self.lblInterest=[[UILabel alloc]initWithFrame:CGRectMake(55*_k_WSwitch+(_k_w-70*_k_WSwitch)/5*1, 0, (_k_w-70*_k_WSwitch)/5, 44)];
    self.lblInterest.font=[UIFont systemFontOfSize:14];
    self.lblInterest.textAlignment=NSTextAlignmentCenter;
    
    self.lblDefautInterest=[[UILabel alloc]initWithFrame:CGRectMake(55*_k_WSwitch+(_k_w-70*_k_WSwitch)/5*2, 0, (_k_w-70)/5, 44)];
    self.lblDefautInterest.font=[UIFont systemFontOfSize:14];
    self.lblDefautInterest.textAlignment=NSTextAlignmentCenter;
    
    self.lblDefaultMoney=[[UILabel alloc]initWithFrame:CGRectMake(55*_k_WSwitch+(_k_w-70*_k_WSwitch)/5*3, 0, (_k_w-70*_k_WSwitch)/5, 44)];
    self.lblDefaultMoney.font=[UIFont systemFontOfSize:14];
    self.lblDefaultMoney.textAlignment=NSTextAlignmentCenter;
    
    self.lblDate=[[UILabel alloc]initWithFrame:CGRectMake(55*_k_WSwitch+(_k_w-70*_k_WSwitch)/5*4, 0, (_k_w-70*_k_WSwitch)/5, 44)];
    self.lblDate.textAlignment=NSTextAlignmentRight;
    self.lblDate.font=[UIFont systemFontOfSize:10];
    
    [self.contentView addSubview:self.lblPeriod];
    [self.contentView addSubview:self.lblMoney];
    [self.contentView addSubview:self.lblInterest];
    [self.contentView addSubview:self.lblDefautInterest];
    [self.contentView addSubview:self.lblDefaultMoney];
    [self.contentView addSubview:self.lblDate];
    
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(15*_k_WSwitch, 43, _k_w-30*_k_WSwitch, 1)];
    lineView.backgroundColor=RGBColor(245, 245, 245, 1);
    [self.contentView addSubview:lineView];
}
//赋值
-(void)setCellValues:(RepayWeeklyRecord *)weekymodel
{
    self.lblPeriod.text=[NSString stringWithFormat:@"%@",weekymodel.no_];
    self.lblMoney.text=[NSString stringWithFormat:@"￥%.1f",weekymodel.principal.doubleValue];
    self.lblInterest.text=[NSString stringWithFormat:@"￥%.1f",weekymodel.service_fee_.doubleValue];
    self.lblDefautInterest.text=[NSString stringWithFormat:@"￥%.1f",weekymodel.penalty_interest_.doubleValue];
    if([weekymodel.liquidatetimed_damages_ intValue]==0)
    {
        self.lblDefaultMoney.text=[NSString stringWithFormat:@"￥%.1f",weekymodel.liquidatetimed_damages_.doubleValue];
    }
    else
    {
        self.lblDefaultMoney.text=[NSString stringWithFormat:@"￥%@",weekymodel.liquidatetimed_damages_];
    }
    NSString *dateString =
    [weekymodel.billing_time_ substringToIndex:10];
    self.lblDate.text=dateString;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
