//
//  TicketCell.m
//  fxdProduct
//
//  Created by zy on 16/5/23.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "TicketCell.h"

@implementation TicketCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self createLbl];
    DLog(@"%f",self.TicketImgView.frame.size.width);
}
-(void)createLbl
{
    self.lblTitle=[[UILabel alloc]initWithFrame:CGRectMake((_k_w-34)*0.19, 15, 280*_k_WSwitch, 30)];
    self.lblTitle.font=[UIFont systemFontOfSize:23];
    self.lblTitle.textColor=[UIColor whiteColor];
    self.lblTitle.textAlignment = NSTextAlignmentCenter;
    self.lblTitle.text=@"恭喜您获得红包";
    [self.TicketImgView addSubview:self.lblTitle];
    
    self.lblPrice=[[UILabel alloc]initWithFrame:CGRectMake((_k_w-34)*0.19, self.TicketImgView.frame.size.height/2-25, 280*_k_WSwitch, 50)];
    self.lblPrice.textColor=[UIColor whiteColor];
    self.lblPrice.textAlignment = NSTextAlignmentCenter;
    [self.TicketImgView addSubview:self.lblPrice];
    
    self.lblTip=[[UILabel alloc]initWithFrame:CGRectMake((_k_w-34)*0.19, self.TicketImgView.frame.size.height-10-30, 280*_k_WSwitch, 30)];
    self.lblTip.font=[UIFont systemFontOfSize:14];
    self.lblTip.textAlignment = NSTextAlignmentCenter;
    self.lblTip.textColor=[UIColor whiteColor];
    //    self.lblTip.text=@"有效期:2016-02-07至2016-06-07";
    [self.TicketImgView addSubview:self.lblTip];
    
    self.lblName = [[UILabel alloc]initWithFrame:CGRectMake(self.TicketImgView.frame.size.width *0.05, 0, self.TicketImgView.frame.size.width *0.09, self.TicketImgView.frame.size.height)];
    self.lblName.textColor=[UIColor whiteColor];
    self.lblName.numberOfLines = 0;
    self.lblName.textAlignment = NSTextAlignmentCenter;
    [self.TicketImgView addSubview:self.lblName];

    //已过期提示框
    self.lblOverTime=[[UILabel alloc]initWithFrame:CGRectMake(_k_w-34-80-15, 15, 80, 40)];
    self.lblOverTime.textAlignment=NSTextAlignmentCenter;
    self.lblOverTime.font=[UIFont systemFontOfSize:23];
    [Tool  setCorner:self.lblOverTime borderColor:rgba(92, 93, 94, 1)];
    self.lblOverTime.text=@"已过期";
    self.lblOverTime.textColor=[UIColor whiteColor];
    self.lblOverTime.backgroundColor=rgba(92, 93, 94, 1);
    [self.TicketImgView addSubview:self.lblOverTime];
    self.lblOverTime.hidden=YES;
    
    self.lblOverTimeImageView = [[UIImageView alloc]init];
    self.lblOverTimeImageView.hidden = YES;
    [self.TicketImgView addSubview:self.lblOverTimeImageView];
    [self.lblOverTimeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(@0);
    }];
}

- (void)setValues:(RedpacketResult *)redPacketModel
{
    NSMutableAttributedString *str;
    if(redPacketModel.totalAmount==redPacketModel.residualAmount)
    {
        str=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%.0f元",redPacketModel.residualAmount]];
        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:50 weight:0] range:NSMakeRange(0, str.length-1)];
        [str addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:35] range:NSMakeRange(str.length-1, 1)];
    }
    else
    {
        NSString *totStr=[NSString stringWithFormat:@"%.0f",redPacketModel.totalAmount];
        NSString *residStr=[NSString stringWithFormat:@"%.2f",redPacketModel.residualAmount];
        str=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@元/剩余%@元",totStr,residStr]];
        
        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:50 weight:0] range:NSMakeRange(0, totStr.length)];
        [str addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:35] range:NSMakeRange(totStr.length, 2)];
        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:25] range:NSMakeRange(totStr.length+2, residStr.length+3)];
    }
    self.lblPrice.attributedText=str;
    self.lblTitle.text = @"红包";
    self.lblTip.text = [NSString stringWithFormat:@"有效期:%@至%@",redPacketModel.validityPeriodFrom,redPacketModel.validityPeriodTo];
    if (redPacketModel.valid) {
        self.TicketImgView.image=[UIImage imageNamed:@"6_my_icon_08"];
        self.userInteractionEnabled = YES;
    } else {
        self.TicketImgView.image=[UIImage imageNamed:@"6_my_icon_09"];
        self.userInteractionEnabled = NO;
    }
}

- (void)setInvailsValues:(DiscountTicketDetailModel *)discountTicketDetailM
{
    
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:15];//行间距
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:@"抵\n扣\n券" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSParagraphStyleAttributeName:paragraphStyle}];
    self.lblName.attributedText = attributedString;
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%.0f元",discountTicketDetailM.amount_payment_]];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:50 weight:0] range:NSMakeRange(0, str.length-1)];
    [str addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:35] range:NSMakeRange(str.length-1, 1)];

    self.lblPrice.attributedText=str;
    self.lblTitle.text = discountTicketDetailM.name_;
    self.lblTip.text = [NSString stringWithFormat:@"有效期:%@至%@",discountTicketDetailM.start_time_,discountTicketDetailM.end_time_];
     self.lblOverTimeImageView.image=[UIImage imageNamed:@"expired_Coupon_Icon"];
    self.lblOverTimeImageView.hidden = NO;
    self.userInteractionEnabled = YES;
    if ([discountTicketDetailM.is_used_ isEqualToString:@"1"]) {
//        self.TicketImgView.image=[UIImage imageNamed:@"used_Coupon_Icon"];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
