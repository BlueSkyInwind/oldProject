//
//  ExpressCreditRefuseView.m
//  fxdProduct
//
//  Created by sxp on 17/6/12.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "ExpressCreditRefuseView.h"
#define tipColor rgb(0,170,238)
#define nameColor rgb(26,26,26)
#define quotaColor rgb(77,77,77)
#define termColor rgb(102,102,102)
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
    
    __weak typeof(self) wekSelf = self;
    UILabel *refusedLabel = [[UILabel alloc]init];
    refusedLabel.text = @"为您匹配更合适平台，借款成功率提高80%";
    refusedLabel.textAlignment = NSTextAlignmentCenter;
    refusedLabel.textColor = tipColor;
    refusedLabel.font = [UIFont systemFontOfSize:15];
    if (UI_IS_IPHONE5) {
        refusedLabel.font = [UIFont systemFontOfSize:13];
    }
    [self addSubview:refusedLabel];
    
    [refusedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(wekSelf.mas_centerX);
        make.left.equalTo(wekSelf.mas_left).with.offset(20);
        make.top.equalTo(wekSelf.mas_top).with.offset(5);
        make.right.equalTo(wekSelf.mas_right).with.offset(-20);
        make.height.equalTo(@30);
    }];
    
    UIView *firstView = [[UIView alloc]init];
    firstView.userInteractionEnabled = YES;
    firstView.tag = 101;
    UITapGestureRecognizer *firstTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickFirstView:)];
    [firstView addGestureRecognizer:firstTap];
    [self addSubview:firstView];
    [firstView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wekSelf.mas_top).with.offset(30);
        make.left.equalTo(wekSelf.mas_left).with.offset(20);
        make.right.equalTo(wekSelf.mas_right).with.offset(-20);
        make.height.equalTo(@100);
    }];
    
    self.firstImage = [[UIImageView alloc]init];
    [firstView addSubview:self.firstImage];
    [self.firstImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(firstView.mas_top).with.offset(15);
        make.left.equalTo(firstView.mas_left).with.offset(15);

    }];
    
    self.nameFirstLabel = [[UILabel alloc]init];
    self.nameFirstLabel.textColor = nameColor;
    self.nameFirstLabel.font = [UIFont systemFontOfSize:15];
    [firstView addSubview:_nameFirstLabel];
    [self.nameFirstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(firstView.mas_top).with.offset(8);
        make.left.equalTo(wekSelf.firstImage.mas_right).with.offset(15);
        make.height.equalTo(@20);
    }];
    
    self.quotaFirstLabel = [[UILabel alloc]init];
    self.quotaFirstLabel.textColor = quotaColor;
    self.quotaFirstLabel.font = [UIFont systemFontOfSize:12];
    [firstView addSubview:self.quotaFirstLabel];
    [self.quotaFirstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wekSelf.nameFirstLabel.mas_bottom).with.offset(5);
        make.left.equalTo(wekSelf.firstImage.mas_right).with.offset(15);
        make.height.equalTo(@15);
    }];
    
    self.termFirstLabel = [[UILabel alloc]init];
    self.termFirstLabel.textColor = termColor;
    self.termFirstLabel.font = [UIFont systemFontOfSize:10];
    [firstView addSubview:self.termFirstLabel];
    [self.termFirstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wekSelf.quotaFirstLabel.mas_bottom).with.offset(5);
        make.left.equalTo(wekSelf.firstImage.mas_right).with.offset(15);
        make.height.equalTo(@12);
    }];
    
    self.feeFirstLabel = [[UILabel alloc]init];
    self.feeFirstLabel.textColor = termColor;
    self.feeFirstLabel.font = [UIFont systemFontOfSize:10];
    [firstView addSubview:self.feeFirstLabel];
    [self.feeFirstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wekSelf.quotaFirstLabel.mas_bottom).with.offset(5);
        make.left.equalTo(wekSelf.termFirstLabel.mas_right).with.offset(15);
        make.height.equalTo(@12);
        
    }];
    
    self.descFirstImage = [[UIImageView alloc]init];
    [firstView addSubview:self.descFirstImage];
    [self.descFirstImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wekSelf.termFirstLabel.mas_bottom).with.offset(5);
        make.left.equalTo(wekSelf.firstImage.mas_right).with.offset(15);
    }];
    
    UIImageView *arrowFirstImage = [[UIImageView alloc]init];
    arrowFirstImage.image = [UIImage imageNamed:@"icon_jiantou"];
    [firstView addSubview:arrowFirstImage];
    [arrowFirstImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(firstView.mas_top).with.offset(40);
        make.right.equalTo(firstView.mas_right).with.offset(-15);

    }];
    
    UIView *secondView = [[UIView alloc]init];
    secondView.tag = 102;
    secondView.userInteractionEnabled = YES;
    UITapGestureRecognizer *secondGest = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickFirstView:)];
    [secondView addGestureRecognizer:secondGest];
    [self addSubview:secondView];
    [secondView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(firstView.mas_bottom).with.offset(0);
        make.left.equalTo(wekSelf.mas_left).with.offset(20);
        make.right.equalTo(wekSelf.mas_right).with.offset(-20);
        make.height.equalTo(@100);
        
    }];

    self.secondImage = [[UIImageView alloc]init];
    [secondView addSubview:self.secondImage];
    [self.secondImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(secondView.mas_top).with.offset(10);
        make.left.equalTo(secondView.mas_left).with.offset(10);

    }];

    self.nameSecondLabel = [[UILabel alloc]init];
    self.nameSecondLabel.textColor = nameColor;
    self.nameSecondLabel.font = [UIFont systemFontOfSize:15];
    [secondView addSubview:self.nameSecondLabel];
    [self.nameSecondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(secondView.mas_top).with.offset(5);
        make.left.equalTo(wekSelf.secondImage.mas_right).with.offset(15);
        make.height.equalTo(@20);
    }];

    self.quotaSecondLabel = [[UILabel alloc]init];
    self.quotaSecondLabel.textColor = quotaColor;
    self.quotaSecondLabel.font = [UIFont systemFontOfSize:12];
    [secondView addSubview:self.quotaSecondLabel];
    [self.quotaSecondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wekSelf.nameSecondLabel.mas_bottom).with.offset(5);
        make.left.equalTo(wekSelf.secondImage.mas_right).with.offset(15);
        make.height.equalTo(@14);
    }];

    self.termSecondLabel = [[UILabel alloc]init];
    self.termSecondLabel.textColor = termColor;
    self.termSecondLabel.font = [UIFont systemFontOfSize:10];
    [secondView addSubview:self.termSecondLabel];
    [self.termSecondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wekSelf.quotaSecondLabel.mas_bottom).with.offset(5);
        make.left.equalTo(wekSelf.secondImage.mas_right).with.offset(15);
        make.height.equalTo(@12);
    }];

    self.feeSecondLabel = [[UILabel alloc]init];
    self.feeSecondLabel.textColor = termColor;
    self.feeSecondLabel.font = [UIFont systemFontOfSize:10];
    [secondView addSubview:self.feeSecondLabel];
    [self.feeSecondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wekSelf.quotaSecondLabel.mas_bottom).with.offset(5);
        make.left.equalTo(wekSelf.termSecondLabel.mas_right).with.offset(15);
        make.height.equalTo(@12);
    }];

    self.descSecondImage = [[UIImageView alloc]init];
    [secondView addSubview:self.descSecondImage];
    [self.descSecondImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wekSelf.termSecondLabel.mas_bottom).with.offset(5);
        make.left.equalTo(wekSelf.secondImage.mas_right).with.offset(15);

    }];

    UIImageView *arrowSecondImage = [[UIImageView alloc]init];
    arrowSecondImage.image = [UIImage imageNamed:@"icon_jiantou"];
    [secondView addSubview:arrowSecondImage];
    [arrowSecondImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(secondView.mas_top).with.offset(40);
        make.right.equalTo(secondView.mas_right).with.offset(-15);

    }];
    
    self.jumpBtn = [[UIButton alloc]init];
    [self.jumpBtn setTitle:@"点击查看更多" forState:UIControlStateNormal];
    [self.jumpBtn setTitleColor:tipColor forState:UIControlStateNormal];
    self.jumpBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.jumpBtn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.jumpBtn];
    [self.jumpBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(secondView.mas_bottom).with.offset(20);
        make.centerX.equalTo(wekSelf.mas_centerX);
        make.height.equalTo(@20);
        make.width.equalTo(@100);
    }];
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = tipColor;
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wekSelf.jumpBtn.mas_bottom).with.offset(2);
        make.centerX.equalTo(wekSelf.mas_centerX);
        make.height.equalTo(@2);
        make.width.equalTo(@100);
    }];
    
}

-(void)clickFirstView:(UITapGestureRecognizer *)gest{

    NSString *url;
    NSInteger tag = [gest view].tag;
    if (tag == 101) {
        url = self.firstUrl;
    }else if (tag == 102){
    
        url = self.secondUrl;
    }
    if (self.viewClick) {
        self.viewClick(url);
    }
}

-(void)clickBtn{
    
    if (self.jumpBtnClick) {
        self.jumpBtnClick();
    }
    
}

-(void)setContent:(NSArray *)content{

    self.firstImage.image = [UIImage imageNamed:@"logo_yongqianbao"];
    self.nameFirstLabel.text = content[0];
    self.quotaFirstLabel.text = content[1];
    self.termFirstLabel.text = content[2];
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:self.termFirstLabel.text];
    [attributedStr addAttribute:NSForegroundColorAttributeName value:tipColor range:NSMakeRange(3, self.termFirstLabel.text.length-4)];
    self.termFirstLabel.attributedText = attributedStr;
    
    self.feeFirstLabel.text = content[3];
    NSMutableAttributedString *feeAttribute = [[NSMutableAttributedString alloc]initWithString:self.feeFirstLabel.text];
    [feeAttribute addAttribute:NSForegroundColorAttributeName value:tipColor range:NSMakeRange(3, self.feeFirstLabel.text.length-5)];
    self.feeFirstLabel.attributedText = feeAttribute;
    self.descFirstImage.image = [UIImage imageNamed:@"tuoyuan_1"];
    
    
    self.secondImage.image = [UIImage imageNamed:@"logo_daima"];
    self.nameSecondLabel.text = content[4];
    self.quotaSecondLabel.text = content[5];
    self.termSecondLabel.text = content[6];
    NSMutableAttributedString *termAttribute = [[NSMutableAttributedString alloc]initWithString:self.termSecondLabel.text];
    [termAttribute addAttribute:NSForegroundColorAttributeName value:tipColor range:NSMakeRange(3, self.termSecondLabel.text.length-4)];
    self.termSecondLabel.attributedText = termAttribute;
    self.feeSecondLabel.text = content[7];
    NSMutableAttributedString *feeSecondAttribute = [[NSMutableAttributedString alloc]initWithString:self.feeSecondLabel.text];
    [feeSecondAttribute addAttribute:NSForegroundColorAttributeName value:tipColor range:NSMakeRange(3, self.feeSecondLabel.text.length-4)];
    self.feeSecondLabel.attributedText = feeSecondAttribute;
    self.descSecondImage.image = [UIImage imageNamed:@"tuoyuan_2"];
    self.firstUrl = @"http:www.baidu.com";
    self.secondUrl = @"http:www.taobao.com";
    
}
@end
