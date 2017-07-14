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
    middleHeadLabel.text = @"=== 如何提升等级 ===";
    middleHeadLabel.textColor = [UIColor grayColor];
    middleHeadLabel.font = [UIFont systemFontOfSize:15];
    [middleView addSubview:middleHeadLabel];
    [middleHeadLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(middleView.mas_bottom).with.offset(10);
        make.left.equalTo(middleView.mas_left).with.offset(0);
        make.right.equalTo(middleView.mas_right).with.offset(0);
        make.height.equalTo(@15);
        
    }];
    
    UIImageView *contentImage = [[UIImageView alloc]init];
    contentImage.image = [UIImage imageNamed:@""];
    [middleView addSubview:contentImage];
    [contentImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(middleHeadLabel.mas_bottom).with.offset(20);
        make.left.equalTo(middleView.mas_left).with.offset(10);
        
    }];
    
    UILabel *middleTitleLabel = [[UILabel alloc]init];
    middleTitleLabel.textColor = [UIColor grayColor];
    middleTitleLabel.text = @"借款、还款";
    middleTitleLabel.font = [UIFont systemFontOfSize:13];
    [middleView addSubview:middleTitleLabel];
    [middleHeadLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(middleView.mas_bottom).with.offset(20);
        make.left.equalTo(contentImage.mas_right).with.offset(5);
        make.height.equalTo(@15);
    }];
    
    UILabel *middleContentLabel = [[UILabel alloc]init];
    middleContentLabel.text = @"每次成功借款、还款都会增加一定的成长值，记得不要逾期哦";
    middleContentLabel.font = [UIFont systemFontOfSize:13];
    middleContentLabel.textColor = [UIColor grayColor];
    [middleView addSubview:middleContentLabel];
    [middleContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(middleTitleLabel.mas_bottom).with.offset(20);
        make.left.equalTo(middleView.mas_left).with.offset(20);
        make.right.equalTo(middleView.mas_right).with.offset(0);
        make.height.equalTo(@30);
    }];
    
    UIImageView *middleImage1 = [[UIImageView alloc]init];
    middleImage1.image = [UIImage imageNamed:@""];
    [middleView addSubview:middleImage1];
    [middleImage1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(middleContentLabel.mas_bottom).with.offset(20);
        make.left.equalTo(middleView.mas_left).with.offset(10);
    }];
    
    UILabel *middleTitleLabel1 = [[UILabel alloc]init];
    middleTitleLabel1.textColor = [UIColor grayColor];
    middleTitleLabel1.text = @"邀请好友";
    middleTitleLabel1.font = [UIFont systemFontOfSize:13];
    [middleView addSubview:middleTitleLabel1];
    [middleTitleLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(middleContentLabel.mas_bottom).with.offset(20);
        make.left.equalTo(middleImage1.mas_right).with.offset(5);
        make.height.equalTo(@15);
    }];
    
    UILabel *middleContentLabel1 = [[UILabel alloc]init];
    middleContentLabel1.text = @"邀请好友注册、好友借款、还款都会增加您的成长值，邀请越多，升级越快！";
    middleContentLabel1.textColor = [UIColor grayColor];
    middleContentLabel1.font = [UIFont systemFontOfSize:13];
    [middleView addSubview:middleContentLabel1];
    [middleContentLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(middleTitleLabel1.mas_bottom).with.offset(20);
        make.left.equalTo(middleView.mas_left).with.offset(20);
        make.right.equalTo(middleView.mas_right).with.offset(0);
        make.height.equalTo(@30);
    }];
    
    UIView *bottomView = [[UIView alloc]init];
    bottomView.backgroundColor = [UIColor redColor];
    [self addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(middleView.mas_bottom).with.offset(20);
        make.left.equalTo(weakSelf.mas_left).with.offset(10);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10);
        make.height.equalTo(@50);
    }];
    
    UILabel *bottomLabel = [[UILabel alloc]init];
    bottomLabel.textColor = [UIColor grayColor];
    bottomLabel.text = @"=== 扣减条款 ===";
    bottomLabel.font = [UIFont systemFontOfSize:15];
    bottomLabel.textAlignment = NSTextAlignmentCenter;
    
}
@end
