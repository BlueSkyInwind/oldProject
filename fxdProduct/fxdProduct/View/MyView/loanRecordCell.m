//
//  loanRecordCell.m
//  fxdProduct
//
//  Created by zy on 16/1/21.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "loanRecordCell.h"

@implementation loanRecordCell

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
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(15, 0, _k_w-30, 245)];
    [Tool setCorner:view borderColor:RGBColor(214, 214, 214, 1)];
    [self.contentView addSubview:view];
    
    NSArray *ary=[[NSArray alloc]initWithObjects:@"产品名称",@"借款金额",@"借款周期",@"每周还款",@"总还款额",@"申请状态",@"申请时间",nil];
    for(int i=0;i<ary.count;i++)
    {
        UIView *contentView=[[UIView alloc]initWithFrame:CGRectMake(0, 0+i*35, view.frame.size.width, 35)];
        
        UILabel *lbltitle=[[UILabel alloc]initWithFrame:CGRectMake(25, 0, 100, 35)];
        lbltitle.text = ary[i];
        if(i % 2 == 0)
        {
            contentView.backgroundColor=RGBColor(240, 240, 240, 1);
        }
        else
        {
            contentView.backgroundColor=[UIColor whiteColor];
        }
        [contentView addSubview:lbltitle];
        
        UILabel *lblResult=[[UILabel alloc]initWithFrame:CGRectMake(view.frame.size.width-175, 0, 150, 35)];
        lblResult.textAlignment=NSTextAlignmentRight;
        lblResult.tag=i+100;
        [contentView addSubview:lblResult];
        
        [view addSubview:contentView];
    }
    self.selectionStyle=UITableViewCellSelectionStyleNone;
}

-(void)setCellValue:(RepayRecord*)result
{
    for(int i=0;i<7;i++)
    {
        UILabel *lbl=[self.contentView viewWithTag:i+100];
        if (i == 0) {
            if ([result.product_id_ isEqualToString:@"P001004"]) {
                lbl.text = @"急速贷";
            }
            if ([result.product_id_ isEqualToString:@"P001002"]) {
                lbl.text = @"工薪贷";
            }
            if ([result.product_id_ isEqualToString:@"P001005"]) {
                lbl.text = @"白领贷";
            }
        }else if(i==1)
        {
            lbl.text=[NSString stringWithFormat:@"%.2f元",result.principal_amount_];
        }else if(i==2)
        {
            lbl.text=[NSString stringWithFormat:@"%.0f周",result.loan_staging_amount_];
        }else if(i==3)
        {
            lbl.text=[NSString stringWithFormat:@"%.2f元",result.staging_repayment_amount_];
        }
        else if(i==4)
        {
            lbl.text=[NSString stringWithFormat:@"%.2f元",result.repayment_amount_];
        }
        else if (i==5)
        {
            if(result.application_status_)
            {
            lbl.text=result.application_status_;
            }
            else
            {
             lbl.text=@"状态获取失败";
            }
        }else
        {
            if(result.create_date_)
            {
            lbl.text=[NSString stringWithFormat:@"%@",[result.create_date_ substringToIndex:10]];
            }
            else
            {
            lbl.text=@"0000-00-00";
            }
        }
        
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
