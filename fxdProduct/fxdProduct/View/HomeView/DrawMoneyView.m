//
//  DrawMoneyView.m
//  fxdProduct
//
//  Created by zy on 15/12/9.
//  Copyright © 2015年 dd. All rights reserved.
//

#import "DrawMoneyView.h"

@implementation DrawMoneyView
-(void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
    
}
- (void)setupUI {
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    self.bgView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    self.homeImageView.image=[UIImage imageNamed:@"homeindex"];
    self.alertView.layer.borderWidth = 1;
    self.alertView.layer.borderColor = [[UIColor blackColor]CGColor];
    self.alertView.layer.cornerRadius = 10;
    self.alertView.layer.masksToBounds = YES;
    self.alertView.backgroundColor = RGBColor(239, 239, 239, 1);
}
-(void)showfist
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.alertView.alpha=0;
    self.alertView.hidden=YES;
    self.homeImageView.hidden=NO;
    [window addSubview:self];
}
-(void)show
{
    //显示
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    
    NSMutableAttributedString *att=[[NSMutableAttributedString alloc] initWithString:self.lblMoney .text];
    [att addAttributes:@{NSForegroundColorAttributeName:RGBColor(74, 74,74, 1)} range:NSMakeRange(0, 5)];
    self.lblMoney.attributedText=att;
    
    NSMutableAttributedString *att1=[[NSMutableAttributedString alloc] initWithString:self.lblTimes.text];
    [att1 addAttributes:@{NSForegroundColorAttributeName:RGBColor(74, 74,74, 1)} range:NSMakeRange(0, 5)];
    self.lblRepayWeekly.attributedText=att1;
    
    NSMutableAttributedString *att2=[[NSMutableAttributedString alloc] initWithString:self.lblTimes.text];
    [att2 addAttributes:@{NSForegroundColorAttributeName:RGBColor(74, 74,74, 1)} range:NSMakeRange(0, 5)];
    self.lblTimes.attributedText=att2;
    
    NSMutableAttributedString *att3=[[NSMutableAttributedString alloc] initWithString:self.lblTotalMeney.text];
    [att3 addAttributes:@{NSForegroundColorAttributeName:RGBColor(74, 74,74, 1)} range:NSMakeRange(0, 5)];
    self.lblTotalMeney.attributedText=att3;
    
    NSMutableAttributedString *att4=[[NSMutableAttributedString alloc] initWithString:self.lblCardNum.text];
    [att4 addAttributes:@{NSForegroundColorAttributeName:RGBColor(74, 74,74, 1)} range:NSMakeRange(0, 5)];
    self.lblCardNum.attributedText=att4;
    self.homeImageView.hidden=YES;
    [self donghua];
}

-(void)donghua
{
    self.alertView.alpha = 0;
    self.alertView.hidden = YES;
    [UIView animateWithDuration:1 animations:^{
        self.alertView.alpha = 1;
        self.alertView.hidden = NO;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hide {
    
    [UIView animateWithDuration:0.35 animations:^{
        self.alertView.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


- (IBAction)DissureBtn:(id)sender {
    [self hide];
}
- (IBAction)SureBtn:(id)sender {
    if ([self.delegate respondsToSelector:@selector(DrawMoneyDelegatebutton)]) {
        [self.delegate DrawMoneyDelegatebutton];
    }
}


@end
