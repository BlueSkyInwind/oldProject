//
//  ExpressCreditRefuseView.m
//  fxdProduct
//
//  Created by sxp on 17/6/12.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "ExpressCreditRefuseView.h"

@implementation ExpressCreditRefuseView

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
    
    UILabel *refusedLabel = [[UILabel alloc]init];
    refusedLabel.text = @"为您匹配更合适平台，借款成功率提高80%";
    refusedLabel.textAlignment = NSTextAlignmentCenter;
    refusedLabel.font = [UIFont systemFontOfSize:13];
    if (UI_IS_IPHONE5) {
        refusedLabel.font = [UIFont systemFontOfSize:11];
    }
    refusedLabel.textColor = rgb(164, 164, 164);
    [self addSubview:refusedLabel];
    __weak typeof(self) wekSelf = self;
    [refusedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(wekSelf.mas_centerX);
        make.left.equalTo(wekSelf.mas_left).with.offset(20);
        make.top.equalTo(wekSelf.mas_top).with.offset(5);
        make.right.equalTo(wekSelf.mas_right).with.offset(-20);
        make.height.equalTo(@30);
    }];
    
    UIView *firstView = [[UIView alloc]init];
    [self addSubview:firstView];
    [firstView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wekSelf.mas_top).with.offset(30);
        make.left.equalTo(wekSelf.mas_left).with.offset(0);
        make.right.equalTo(wekSelf.mas_right).with.offset(0);
        make.height.equalTo(@100);
        make.width.equalTo(@375);
    }];
    
    UIImageView *firstImage = [[UIImageView alloc]init];
    firstImage.image = [UIImage imageNamed:@"gantan"];
    [firstView addSubview:firstImage];
    [firstImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(firstView.mas_top).with.offset(15);
        make.left.equalTo(firstView.mas_left).with.offset(15);
        make.width.equalTo(@15);
        make.height.equalTo(@15);
    }];
    
    self.nameFirstLabel = [[UILabel alloc]init];
    self.nameFirstLabel.textColor = [UIColor blackColor];
    self.nameFirstLabel.font = [UIFont systemFontOfSize:13];
    [firstView addSubview:_nameFirstLabel];
    [self.nameFirstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(firstView.mas_top).with.offset(8);
        make.left.equalTo(firstImage.mas_right).with.offset(15);
        make.height.equalTo(@14);
    }];
    
    self.quotaFirstLabel = [[UILabel alloc]init];
    self.quotaFirstLabel.textColor = [UIColor blackColor];
    self.quotaFirstLabel.font = [UIFont systemFontOfSize:11];
    [firstView addSubview:self.quotaFirstLabel];
    [self.quotaFirstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wekSelf.nameFirstLabel.mas_bottom).with.offset(5);
        make.left.equalTo(firstImage.mas_right).with.offset(15);
        make.height.equalTo(@12);
    }];
    
    self.termFirstLabel = [[UILabel alloc]init];
    self.termFirstLabel.textColor = [UIColor blackColor];
    self.termFirstLabel.font = [UIFont systemFontOfSize:11];
    [firstView addSubview:self.termFirstLabel];
    [self.termFirstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wekSelf.quotaFirstLabel.mas_bottom).with.offset(5);
        make.left.equalTo(firstImage.mas_right).with.offset(15);
        make.height.equalTo(@12);
    }];
    
    self.feeFirstLabel = [[UILabel alloc]init];
    self.feeFirstLabel.textColor = [UIColor blackColor];
    self.feeFirstLabel.font = [UIFont systemFontOfSize:11];
    [firstView addSubview:self.feeFirstLabel];
    [self.feeFirstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wekSelf.quotaFirstLabel.mas_bottom).with.offset(5);
        make.left.equalTo(wekSelf.termFirstLabel.mas_right).with.offset(15);
        make.height.equalTo(@12);
        make.right.equalTo(wekSelf.mas_right).with.offset(30);
    }];
    
    self.descFirstBtn = [[UIButton alloc]init];
    [self.descFirstBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.descFirstBtn.titleLabel.font = [UIFont systemFontOfSize:11];
    [self.descFirstBtn setTitle:@"新用户免息，下款快" forState:UIControlStateNormal];
    [firstView addSubview:self.descFirstBtn];
    [self.descFirstBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wekSelf.termFirstLabel.mas_bottom).with.offset(5);
        make.left.equalTo(firstImage.mas_right).with.offset(15);
        make.height.equalTo(@15);
        make.width.equalTo(@120);
    }];
    
    UIImageView *arrowFirstImage = [[UIImageView alloc]init];
    arrowFirstImage.image = [UIImage imageNamed:@"gantan"];
    [firstView addSubview:arrowFirstImage];
    [arrowFirstImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(firstView.mas_top).with.offset(40);
        make.right.equalTo(firstView.mas_right).with.offset(-15);
        make.width.equalTo(@15);
        make.height.equalTo(@10);
    }];
    
    UIView *secondView = [[UIView alloc]init];
    secondView.backgroundColor = [UIColor greenColor];
    [self addSubview:secondView];
    [secondView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(firstView.mas_bottom).with.offset(0);
        make.left.equalTo(wekSelf.mas_left).with.offset(0);
        make.height.equalTo(@100);
        
    }];

    UIImageView *secondImage = [[UIImageView alloc]init];
    secondImage.image = [UIImage imageNamed:@"gantan"];
    [secondView addSubview:secondImage];
    [secondImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(secondView.mas_top).with.offset(10);
        make.left.equalTo(secondView.mas_left).with.offset(10);
        make.height.equalTo(@15);
        make.width.equalTo(@15);
    }];

    self.nameSecondLabel = [[UILabel alloc]init];
    self.nameSecondLabel.textColor = [UIColor blackColor];
    self.nameSecondLabel.font = [UIFont systemFontOfSize:13];
    [secondView addSubview:self.nameSecondLabel];
    [self.nameSecondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(secondView.mas_top).with.offset(5);
        make.left.equalTo(secondImage.mas_right).with.offset(15);
        make.height.equalTo(@15);
    }];

    self.quotaSecondLabel = [[UILabel alloc]init];
    self.quotaSecondLabel.textColor = [UIColor blackColor];
    self.quotaSecondLabel.font = [UIFont systemFontOfSize:11];
    [secondView addSubview:self.quotaSecondLabel];
    [self.quotaSecondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wekSelf.nameSecondLabel.mas_bottom).with.offset(5);
        make.left.equalTo(secondImage.mas_right).with.offset(15);
        make.height.equalTo(@14);
    }];

    self.termSecondLabel = [[UILabel alloc]init];
    self.termSecondLabel.textColor = [UIColor blackColor];
    self.termSecondLabel.font = [UIFont systemFontOfSize:11];
    [secondView addSubview:self.termSecondLabel];
    [self.termSecondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wekSelf.quotaSecondLabel.mas_bottom).with.offset(5);
        make.left.equalTo(secondImage.mas_right).with.offset(15);
        make.height.equalTo(@12);
    }];

    self.feeSecondLabel = [[UILabel alloc]init];
    self.feeSecondLabel.textColor = [UIColor blackColor];
    self.feeSecondLabel.font = [UIFont systemFontOfSize:11];
    [secondView addSubview:self.feeSecondLabel];
    [self.feeSecondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wekSelf.quotaSecondLabel.mas_bottom).with.offset(5);
        make.left.equalTo(wekSelf.termSecondLabel.mas_right).with.offset(15);
        make.height.equalTo(@12);
    }];

    self.descSecondBtn = [[UIButton alloc]init];
    [self.descSecondBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.descSecondBtn.titleLabel.font = [UIFont systemFontOfSize:11];
    [self.descSecondBtn setTitle:@"30家借款机构，0抵押当天放款" forState:UIControlStateNormal];
    [secondView addSubview:self.descSecondBtn];
    [self.descSecondBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wekSelf.termSecondLabel.mas_bottom).with.offset(5);
        make.left.equalTo(secondImage.mas_right).with.offset(15);
        make.height.equalTo(@10);
        make.width.equalTo(@320);
    }];

    UIImageView *arrowSecondImage = [[UIImageView alloc]init];
    arrowSecondImage.image = [UIImage imageNamed:@"gantan"];
    [secondView addSubview:arrowSecondImage];
    [arrowSecondImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(secondView.mas_top).with.offset(30);
        make.right.equalTo(wekSelf.mas_right).with.offset(-15);
        make.height.equalTo(@10);
        make.width.equalTo(@15);
    }];
    
    self.jumpBtn = [[UIButton alloc]init];
    [self.jumpBtn setTitle:@"点击查看更多" forState:UIControlStateNormal];
    [self.jumpBtn setTitleColor:rgb(164, 164, 164) forState:UIControlStateNormal];
    self.jumpBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.jumpBtn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.jumpBtn];
    [self.jumpBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(secondView.mas_bottom).with.offset(20);
        make.centerX.equalTo(wekSelf.mas_centerX);
        make.height.equalTo(@20);
        make.width.equalTo(@100);
    }];
    
}


-(void)clickBtn{
    
    if (self.jumpBtnClick) {
        self.jumpBtnClick();
    }
    
}

-(void)setContent:(NSArray *)content{

    self.nameFirstLabel.text = content[0];
    self.quotaFirstLabel.text = content[1];
    self.termFirstLabel.text = content[2];
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:self.termFirstLabel.text];
    [attributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor]range:NSMakeRange(3, self.termFirstLabel.text.length-4)];
    self.termFirstLabel.attributedText = attributedStr;
    
    self.feeFirstLabel.text = content[3];
    NSMutableAttributedString *feeAttribute = [[NSMutableAttributedString alloc]initWithString:self.feeFirstLabel.text];
    [feeAttribute addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(3, self.feeFirstLabel.text.length-5)];
    self.feeFirstLabel.attributedText = feeAttribute;
    
    self.nameSecondLabel.text = content[4];
    self.quotaSecondLabel.text = content[5];
    self.termSecondLabel.text = content[6];
    NSMutableAttributedString *termAttribute = [[NSMutableAttributedString alloc]initWithString:self.termSecondLabel.text];
    [termAttribute addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(3, self.termSecondLabel.text.length-4)];
    self.termSecondLabel.attributedText = termAttribute;
    self.feeSecondLabel.text = content[7];
    NSMutableAttributedString *feeSecondAttribute = [[NSMutableAttributedString alloc]initWithString:self.feeSecondLabel.text];
    [feeSecondAttribute addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(3, self.feeSecondLabel.text.length-4)];
    self.feeSecondLabel.attributedText = feeSecondAttribute;
    
}
@end
