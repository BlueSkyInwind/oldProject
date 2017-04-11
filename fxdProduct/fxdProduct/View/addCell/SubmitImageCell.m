//
//  SubmitImageCell.m
//  fxdProduct
//
//  Created by zhangbaochuan on 15/12/15.
//  Copyright © 2015年 dd. All rights reserved.
//

#import "SubmitImageCell.h"

@implementation SubmitImageCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
    
}

- (void)setupUI {
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    self.bgView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    
//    self.alertView.layer.borderWidth = 1;
//    self.alertView.layer.borderColor = [[UIColor blackColor]CGColor];
    self.alertView.layer.cornerRadius = 24;
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
    
}


-(void)showfist
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.alertView.alpha=0;
    self.alertView.hidden=YES;
    [window addSubview:self];
}

-(void)show
{
    //显示
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    [self donghua];
}

- (void)hide {
    
    [UIView animateWithDuration:0.35 animations:^{
        self.alertView.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
