//
//  testView.m
//  myAlertView
//
//  Created by lzj on 15/10/28.
//  Copyright (c) 2015年 wxd. All rights reserved.
//

#import "testView.h"

@implementation testView

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
    [self.sureBtn addTarget:self action:@selector(surebtnClick) forControlEvents:UIControlEventTouchUpInside];
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
    self.homeImageView.hidden=NO;
    [window addSubview:self];
}

-(void)show
{
    //显示
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    self.homeImageView.hidden=YES;
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
