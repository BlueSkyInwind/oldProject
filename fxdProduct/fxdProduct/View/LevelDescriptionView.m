//
//  LevelDescriptionView.m
//  fxdProduct
//
//  Created by sxp on 2017/7/13.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "LevelDescriptionView.h"
#define headViewColor rgb(0,170,238)
@implementation LevelDescriptionView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self configureView];
        
    }
    return self;
}


-(void)configureView{
    __weak typeof(self) weakSelf = self;
    UIView *headView = [[UIView alloc]init];
    headView.backgroundColor = headViewColor;
    [self addSubview:headView];
    [headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).with.offset(20);
        make.left.equalTo(weakSelf.mas_left).with.offset(10);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10);
        make.height.equalTo(@150);
    }];
    
    UILabel *headTitleLabel = [[UILabel alloc]init];
    headTitleLabel.text = @"=== 什么是用户等级 ===";
    headTitleLabel.textColor = [UIColor blackColor];
    headTitleLabel.textAlignment = NSTextAlignmentCenter;
    headTitleLabel.font = [UIFont systemFontOfSize:15];
    [headView addSubview:headTitleLabel];
    [headTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headView.mas_bottom).with.offset(10);
        make.left.equalTo(headView.mas_left).with.offset(0);
        make.right.equalTo(headView.mas_right).with.offset(0);
        make.height.equalTo(@15);
    }];
    
    UILabel *headContentLabel = [[UILabel alloc]init];
    headContentLabel.textColor = [UIColor grayColor];
    headContentLabel.font = [UIFont systemFontOfSize:13];
    headContentLabel.text = @"用户等级代表了用户在发薪贷平台借还款行为的综合评价，用户持续良好的行为会提升用户等级";
    [headView addSubview:headContentLabel];
    [headContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headTitleLabel.mas_bottom).with.offset(15);
        make.left.equalTo(headView.mas_left).with.offset(10);
        make.right.equalTo(headView.mas_right).with.offset(-10);
        make.height.equalTo(@30);
    }];
    
    UILabel *headContentLabel1 = [[UILabel alloc]init];
    headContentLabel1.text = @"不同的会员等级可享受不同的用户权益，越高的等级可以享受越高的借款额度及更优惠的费用";
    headContentLabel1.textColor = [UIColor grayColor];
    headContentLabel1.font = [UIFont systemFontOfSize:13];
    [headView addSubview:headContentLabel1];
    [headContentLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headContentLabel.mas_bottom).with.offset(10);
        make.left.equalTo(headView.mas_left).with.offset(10);
        make.right.equalTo(headView.mas_right).with.offset(-10);
        make.height.equalTo(@30);
    }];
    
    UILabel *label = [[UILabel alloc]init];
    label.text = @"会员等级对照表";
    label.textColor = [UIColor grayColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:15];
    [headView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headContentLabel1.mas_bottom).with.offset(15);
        make.left.equalTo(headView.mas_left).with.offset(0);
        make.right.equalTo(headView.mas_right).with.offset(0);
        make.height.equalTo(@15);
    }];
    
    UIView *middleView = [[UIView alloc]init];
    middleView.backgroundColor = headViewColor;
    [self addSubview:middleView];
    [middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headView.mas_bottom).with.offset(10);
        make.left.equalTo(weakSelf.mas_left).with.offset(10);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10);
        make.height.equalTo(@150);
    }];
    
    UILabel *middleHeadLabel = [[UILabel alloc]init];
    middleHeadLabel.textAlignment = NSTextAlignmentCenter;
    
}
@end
