//
//  repayClearView.m
//  fxdProduct
//
//  Created by zy on 16/5/23.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "repayClearView.h"

@implementation repayClearView

-(void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
    
}

- (void)setupUI {
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    self.BgView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    self.HomeImageView.image=[UIImage imageNamed:@"homeindex"];
    
    self.alertView.layer.borderWidth = 1;
    self.alertView.layer.borderColor = [[UIColor blackColor]CGColor];
    self.alertView.layer.cornerRadius = 10;
    self.alertView.layer.masksToBounds = YES;
    self.alertView.backgroundColor = RGBColor(239, 239, 239, 1);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    [self addGestureRecognizer:tap];
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
    [self.SureBtn addTarget:self action:@selector(surebtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.DisSureBtn addTarget:self action:@selector(dissurebtnClick) forControlEvents:UIControlEventTouchUpInside];
}

-(void)surebtnClick{
    DLog(@"queren");
    //协议方法
    if([self.delegat respondsToSelector:@selector(MakeSureBtn:)]){
        [self.delegat MakeSureBtn:self.num];
    }
}


-(void)dissurebtnClick{
    [UIView animateWithDuration:0.05 animations:^{
        self.alertView.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

-(void)showfist
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.alertView.alpha=0;
    self.alertView.hidden=YES;
    self.HomeImageView.hidden=NO;
    [window addSubview:self];
}

-(void)show
{
    //显示
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    self.HomeImageView.hidden=YES;
    [self donghua];
}

- (void)hide {
    
    [UIView animateWithDuration:0.05 animations:^{
        self.alertView.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
