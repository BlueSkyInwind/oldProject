//
//  sumitView.m
//  fxdProduct
//
//  Created by zhangbaochuan on 15/10/28.
//  Copyright © 2015年 dd. All rights reserved.
//

#import "sumitView.h"

@implementation sumitView


-(void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
    
}

- (void)setupUI {
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    self.bigBgView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    
    self.smallBgView.layer.borderWidth = 1;
    self.smallBgView.layer.borderColor = [[UIColor blackColor]CGColor];
    self.smallBgView.layer.cornerRadius = 10;
    self.smallBgView.layer.masksToBounds = YES;
    self.smallBgView.backgroundColor = RGBColor(239, 239, 239, 1);
    
}

-(void)showww
{
    //显示
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    
    NSMutableAttributedString *att=[[NSMutableAttributedString alloc] initWithString:self.loanNumLabel.text];
    [att addAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} range:NSMakeRange(0, 5)];
    [att addAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} range:NSMakeRange([self.loanNumLabel.text length]-1, 1)];
    self.loanNumLabel.attributedText=att;
    
    NSMutableAttributedString *att1=[[NSMutableAttributedString alloc] initWithString:self.loanDataLabel.text];
    [att1 addAttributes:@{NSForegroundColorAttributeName:RGBColor(20, 152, 234, 1)} range:NSMakeRange(5, 2)];
    self.loanDataLabel.attributedText=att1;
    
    //    self.loanCostMoneylabel.text=;
    NSMutableAttributedString *att12=[[NSMutableAttributedString alloc] initWithString:self.loanCostMoneylabel.text];
    [att12 addAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} range:NSMakeRange(0, 5)];
    [att12 addAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} range:NSMakeRange([self.loanCostMoneylabel.text length]-1, 1)];
    self.loanCostMoneylabel.attributedText=att12;
    
    NSMutableAttributedString *att2=[[NSMutableAttributedString alloc] initWithString:self.loanNameLabel.text];
    [att2 addAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} range:NSMakeRange(0, 3)];
    self.loanNameLabel.attributedText=att2;
    
    NSMutableAttributedString *att3=[[NSMutableAttributedString alloc] initWithString:self.loanIDcardLabel.text];
    [att3 addAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} range:NSMakeRange(0, 5)];
    self.loanIDcardLabel.attributedText=att3;
    
    NSMutableAttributedString *att4=[[NSMutableAttributedString alloc] initWithString:self.loanbankCardLabel.text];
    [att4 addAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} range:NSMakeRange(0, 5)];
    self.loanbankCardLabel.attributedText=att4;
    
    NSMutableAttributedString *att41=[[NSMutableAttributedString alloc] initWithString:self.loanbankCardNumLable.text];
    [att41 addAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} range:NSMakeRange(0, 5)];
    self.loanbankCardNumLable.attributedText=att41;
    
    
    NSMutableAttributedString *att411=[[NSMutableAttributedString alloc] initWithString:self.loanselfbankLabel.text];
    [att411 addAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} range:NSMakeRange(0, 5)];
    self.loanselfbankLabel.attributedText=att411;
    
    NSMutableAttributedString *att42=[[NSMutableAttributedString alloc] initWithString:self.loanselfbankNumLabel.text];
    [att42 addAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} range:NSMakeRange(0, 5)];
    self.loanselfbankNumLabel.attributedText=att42;
    
    NSMutableAttributedString *att5=[[NSMutableAttributedString alloc] initWithString:self.loantelSecoryLabel.text];
    [att5 addAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} range:NSMakeRange(0, 7)];
    self.loantelSecoryLabel.attributedText=att5;
    
    [self donghua];
}

-(void)donghua
{
    self.smallBgView.alpha = 0;
    self.smallBgView.hidden = YES;
    [UIView animateWithDuration:1 animations:^{
        self.smallBgView.alpha = 1;
        self.smallBgView.hidden = NO;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hide {
    
    [UIView animateWithDuration:0.35 animations:^{
        self.smallBgView.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


- (IBAction)DissureBtn:(id)sender {
    [self hide];
}
- (IBAction)SureBtn:(id)sender {
    if ([self.delegate respondsToSelector:@selector(SubmitMakeSureDelegatebutton)]) {
        [self.delegate SubmitMakeSureDelegatebutton];
    }
}

@end
