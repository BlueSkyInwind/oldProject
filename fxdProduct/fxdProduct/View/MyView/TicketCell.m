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

    self.lblName = [[UILabel alloc]init];
    self.lblName.textColor=kUIColorFromRGB(0xffffff);
    self.lblName.numberOfLines = 0;
    self.lblName.font = [UIFont systemFontOfSize:19];
    self.lblName.textAlignment = NSTextAlignmentCenter;
    [self.TicketImgView addSubview:self.lblName];
    [self.lblName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.TicketImgView.mas_left).with.offset((_k_w-30)*0.32*0.19);
        make.centerY.equalTo(self.TicketImgView.mas_centerY).with.offset(-20);
    }];
    
    self.lblPrice=[[UILabel alloc]init];
    self.lblPrice.textColor=kUIColorFromRGB(0xfed100);
    self.lblPrice.font = [UIFont systemFontOfSize:25];
    self.lblPrice.textAlignment = NSTextAlignmentCenter;
    [self.TicketImgView addSubview:self.lblPrice];
    [self.lblPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lblName.mas_left).with.offset(0);
        make.centerY.equalTo(self.TicketImgView.mas_centerY).with.offset(20);
    }];
    
    self.lblTitle=[[UILabel alloc]init];
    self.lblTitle.font=[UIFont boldSystemFontOfSize:17];
    self.lblTitle.textColor=kUIColorFromRGB(0x4d4d4d);
    self.lblTitle.textAlignment = NSTextAlignmentLeft;
    self.lblTitle.text=@"恭喜您获得红包";
    [self.TicketImgView addSubview:self.lblTitle];
    [self.lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@((_k_w-30)*0.36));
        make.right.equalTo(self.TicketImgView.mas_right).with.offset(0);
        make.height.equalTo(@30);
        make.top.equalTo(@10);
    }];
    
    self.lblTip=[[UILabel alloc]init];
    self.lblTip.font=[UIFont systemFontOfSize:12];
    self.lblTip.textAlignment = NSTextAlignmentLeft;
    self.lblTip.textColor=kUIColorFromRGB(0x4d4d4d);
    //    self.lblTip.text=@"有效期:2016-02-07至2016-06-07";
    [self.TicketImgView addSubview:self.lblTip];
    [self.lblTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lblTitle.mas_left).with.offset(0);
        make.right.equalTo(self.lblTitle.mas_right).with.offset(0);
        make.height.equalTo(@15);
        make.bottom.equalTo(@(-10));
    }];

    self.limitProduct = [[UILabel alloc]init];
    self.limitProduct.textColor=kUIColorFromRGB(0x808080);
    self.limitProduct.font = [UIFont systemFontOfSize:12];
    self.limitProduct.text = @"见覅卫计局围殴及覅我";
    self.limitProduct.textAlignment = NSTextAlignmentLeft;
    [self.TicketImgView addSubview:self.limitProduct];
    [self.limitProduct mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lblTitle.mas_left).with.offset(0);
        make.right.equalTo(self.lblTitle.mas_right).with.offset(0);
        make.height.equalTo(@15);
        make.top.equalTo(self.lblTitle.mas_bottom).with.offset(5);
    }];
    
    self.limitconditions = [[UILabel alloc]init];
    self.limitconditions.textColor=kUIColorFromRGB(0x808080);
    self.limitconditions.font = [UIFont systemFontOfSize:12];
    self.limitconditions.text = @"见覅卫计局围殴及覅我";
    self.limitconditions.textAlignment = NSTextAlignmentLeft;
    [self.TicketImgView addSubview:self.limitconditions];
    [self.limitconditions mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lblTitle.mas_left).with.offset(0);
        make.right.equalTo(self.lblTitle.mas_right).with.offset(0);
        make.height.equalTo(@15);
        make.top.equalTo(self.limitProduct.mas_bottom).with.offset(5);
    }];

    //已过期提示框
    self.lblOverTime=[[UILabel alloc]initWithFrame:CGRectMake(_k_w-34-80-15, 15, 80, 40)];
    self.lblOverTime.textAlignment=NSTextAlignmentCenter;
    self.lblOverTime.font=[UIFont systemFontOfSize:23];
    [FXD_Tool  setCorner:self.lblOverTime borderColor:rgba(92, 93, 94, 1)];
    self.lblOverTime.text=@"已过期";
    self.lblOverTime.textColor=kUIColorFromRGB(0x4d4d4d);
    self.lblOverTime.backgroundColor=rgba(92, 93, 94, 1);
    [self.TicketImgView addSubview:self.lblOverTime];
    self.lblOverTime.hidden=YES;
    
    self.lblOverTimeImageView = [[UIImageView alloc]init];
    self.lblOverTimeImageView.hidden = YES;
    [self.TicketImgView addSubview:self.lblOverTimeImageView];
    [self.lblOverTimeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.TicketImgView.mas_right).with.offset(13);
        make.centerY.equalTo(self.TicketImgView.mas_centerY).with.offset(0);
    }];
    
    if (UI_IS_IPHONE6P) {
        
        self.lblTitle.font=[UIFont boldSystemFontOfSize:24];
        self.lblName.font =[UIFont systemFontOfSize:22];
        self.lblPrice.font = [UIFont systemFontOfSize:30];
        self.lblTip.font = [UIFont systemFontOfSize:14];
        self.limitProduct.font = [UIFont systemFontOfSize:14];
        self.limitconditions.font = [UIFont systemFontOfSize:14];
        
        [self.limitProduct mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.lblTitle.mas_bottom).with.offset(8);
        }];
        
        [self.limitconditions mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.limitProduct.mas_bottom).with.offset(8);
        }];
    }
}

- (void)setValues:(RedpacketDetailModel *)redPacketModel
{
    self.lblName.text = @"抵扣券";
    NSMutableAttributedString *str;
    if([redPacketModel.total_amount_ floatValue]==[redPacketModel.residual_amount_ floatValue])
    {
        str=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%.0f元",[redPacketModel.residual_amount_ floatValue]]];
        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:50 weight:0] range:NSMakeRange(0, str.length-1)];
        [str addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:35] range:NSMakeRange(str.length-1, 1)];
    }
    else
    {
        NSString *totStr=[NSString stringWithFormat:@"%.0f",[redPacketModel.total_amount_ floatValue]];
        NSString *residStr=[NSString stringWithFormat:@"%.2f",[redPacketModel.residual_amount_ floatValue]];
        str=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@元/剩余%@元",totStr,residStr]];
        
        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:25 weight:0] range:NSMakeRange(0, totStr.length)];
        [str addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:35] range:NSMakeRange(totStr.length, 2)];
        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:25] range:NSMakeRange(totStr.length+2, residStr.length+3)];
    }
    self.lblPrice.text = [NSString stringWithFormat:@"%@元",redPacketModel.residual_amount_];
    self.lblTitle.text = redPacketModel.redpacket_name_;
    self.lblTip.text = [NSString stringWithFormat:@"有效期:%@至%@",redPacketModel.validity_period_from_,redPacketModel.validity_period_to_];
    self.userInteractionEnabled = NO;
    if (![redPacketModel.is_valid_ boolValue]) {
        self.TicketImgView.image = [UIImage imageNamed:@"invail_BackIcon"];
        self.lblOverTimeImageView.hidden = NO;
        self.lblOverTimeImageView.image=[UIImage imageNamed:@"invail_Icon"];
        self.userInteractionEnabled = NO;
        if ([redPacketModel.is_used_ boolValue]) {
            self.lblOverTimeImageView.image=[UIImage imageNamed:@"Used_Icon"];
        }
    }
}

- (void)setVailValues:(DiscountTicketDetailModel *)discountTicketDetailM
{
    self.lblName.text = @"提额券";
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@元",discountTicketDetailM.amount_payment_]];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:25   weight:0] range:NSMakeRange(0, str.length-1)];
    [str addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:25] range:NSMakeRange(str.length-1, 1)];

    self.lblPrice.text=[NSString stringWithFormat:@"%@元",discountTicketDetailM.amount_payment_];
    self.lblTitle.text = discountTicketDetailM.name_;
    self.lblTip.text = [NSString stringWithFormat:@"有效期:%@至%@",discountTicketDetailM.start_time_,discountTicketDetailM.end_time_];
    self.userInteractionEnabled = NO;
}

- (void)setInvailsValues:(DiscountTicketDetailModel *)discountTicketDetailM
{
    
    self.lblName.text = @"提额券";
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@元",discountTicketDetailM.amount_payment_]];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:25 weight:0] range:NSMakeRange(0, str.length-1)];
    [str addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:25] range:NSMakeRange(str.length-1, 1)];
    
    self.TicketImgView.image = [UIImage imageNamed:@"invail_BackIcon"];
    self.lblPrice.text=[NSString stringWithFormat:@"%@元",discountTicketDetailM.amount_payment_];
    self.lblTitle.text = discountTicketDetailM.name_;
    self.lblTip.text = [NSString stringWithFormat:@"有效期:%@至%@",discountTicketDetailM.start_time_,discountTicketDetailM.end_time_];
     self.lblOverTimeImageView.image=[UIImage imageNamed:@"invail_Icon"];
    self.lblOverTimeImageView.hidden = NO;
    self.userInteractionEnabled = YES;
    if ([discountTicketDetailM.is_used_ isEqualToString:@"1"]) {
        self.lblOverTimeImageView.image=[UIImage imageNamed:@"Used_Icon"];
    }
}

-(NSMutableAttributedString *)getNameAttributeString:(NSString *)str{
    
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:10];//行间距
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:str attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSParagraphStyleAttributeName:paragraphStyle}];
    return attributedString ;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
