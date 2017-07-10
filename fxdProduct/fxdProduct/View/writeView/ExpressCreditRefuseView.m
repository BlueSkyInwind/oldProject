//
//  ExpressCreditRefuseView.m
//  fxdProduct
//
//  Created by sxp on 17/6/12.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "ExpressCreditRefuseView.h"
#import "UIImageView+WebCache.h"

#define nameColor rgb(26,26,26)
#define quotaColor rgb(77,77,77)
#define termColor rgb(102,102,102)

@interface ExpressCreditRefuseView ()
@property (strong, nonatomic) UITableView *tableView;
@end

@implementation ExpressCreditRefuseView
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)cellWithTableView:(UITableView *)tableView {
         // NSLog(@"cellForRowAtIndexPath");
        static NSString *identifier = @"cell";
        // 1.缓存中取
        ExpressCreditRefuseView *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        // 2.创建
        if (cell == nil) {
                cell = [[ExpressCreditRefuseView alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            }
        return cell;
    }


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configureView];
    }
    return self;
}

-(void)configureView{
    
    __weak typeof(self) wekSelf = self;
    
    UIView *tipView = [[UIView alloc]init];
    tipView.backgroundColor = [UIColor clearColor];
    [self addSubview:tipView];
    [tipView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wekSelf.mas_top).with.offset(10);
        make.centerX.equalTo(wekSelf.mas_centerX);
        make.height.equalTo(@22);
        make.width.equalTo(@270);
    }];
    
    UIImageView *tipImage = [[UIImageView alloc]init];
    tipImage.image = [UIImage imageNamed:@"icon_shibai"];
    [tipView addSubview:tipImage];
    [tipImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tipView.mas_top).with.offset(0);
        make.left.equalTo(tipView.mas_left).with.offset(0);
    }];
    
    UILabel *tipLabel = [[UILabel alloc]init];
    tipLabel.text = @"很抱歉，您的借款申请审核失败";
    tipLabel.textColor = UI_MAIN_COLOR;
    tipLabel.font = [UIFont systemFontOfSize:16];
    [tipView addSubview:tipLabel];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tipView.mas_top).with.offset(3);
        make.left.equalTo(tipImage.mas_right).with.offset(10);
        make.height.equalTo(@15);
    }];
    
    
    UIView *contentView = [[UIView alloc]init];
    contentView.backgroundColor = [UIColor whiteColor];
    contentView.layer.cornerRadius = 5.0;
    [self addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tipView.mas_bottom).with.offset(10);
        make.left.equalTo(wekSelf.mas_left).with.offset(20);
        make.right.equalTo(wekSelf.mas_right).with.offset(-20);
        make.bottom.equalTo(wekSelf.mas_bottom).with.offset(-10);
    }];
    
    UILabel *refusedLabel = [[UILabel alloc]init];
    refusedLabel.text = @"为您匹配更合适平台，借款成功率提高80%";
    refusedLabel.textAlignment = NSTextAlignmentCenter;
    refusedLabel.textColor = termColor;
    refusedLabel.font = [UIFont systemFontOfSize:15];
    if (UI_IS_IPHONE5) {
        refusedLabel.font = [UIFont systemFontOfSize:13];
    }
    [contentView addSubview:refusedLabel];
    
    [refusedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(contentView.mas_centerX);
        make.left.equalTo(contentView.mas_left).with.offset(20);
        make.top.equalTo(contentView.mas_top).with.offset(5);
        make.right.equalTo(contentView.mas_right).with.offset(-20);
        make.height.equalTo(@30);
    }];
    
    UIView *firstView = [[UIView alloc]init];
    firstView.userInteractionEnabled = YES;
    firstView.tag = 101;
    UITapGestureRecognizer *firstTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickFirstView:)];
    [firstView addGestureRecognizer:firstTap];
    [contentView addSubview:firstView];
    [firstView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView.mas_top).with.offset(30);
        make.left.equalTo(contentView.mas_left).with.offset(20);
        make.right.equalTo(contentView.mas_right).with.offset(-20);
        make.height.equalTo(@100);
    }];
    
    self.firstImage = [[UIImageView alloc]init];
    [firstView addSubview:self.firstImage];
    [self.firstImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(firstView.mas_top).with.offset(15);
        make.left.equalTo(firstView.mas_left).with.offset(15);
        make.width.equalTo(@49);
        make.height.equalTo(@49);

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
    
    self.descFirstBtn = [[UIButton alloc]init];
    [Tool setCorner:self.descFirstBtn borderColor:UI_MAIN_COLOR];
    self.descFirstBtn.titleLabel.font = [UIFont systemFontOfSize:11];
    [self.descFirstBtn setTitleColor:UI_MAIN_COLOR forState:UIControlStateNormal];
    [firstView addSubview:self.descFirstBtn];
    [self.descFirstBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wekSelf.termFirstLabel.mas_bottom).with.offset(5);
        make.left.equalTo(wekSelf.firstImage.mas_right).with.offset(15);
        make.height.equalTo(@15);
    }];
//    self.descFirstImage = [[UIImageView alloc]init];
//    [firstView addSubview:self.descFirstImage];
//    [self.descFirstImage mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(wekSelf.termFirstLabel.mas_bottom).with.offset(5);
//        make.left.equalTo(wekSelf.firstImage.mas_right).with.offset(15);
//    }];
    
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
    [contentView addSubview:secondView];
    [secondView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(firstView.mas_bottom).with.offset(0);
        make.left.equalTo(contentView.mas_left).with.offset(20);
        make.right.equalTo(contentView.mas_right).with.offset(-20);
        make.height.equalTo(@100);
        
    }];

    self.secondImage = [[UIImageView alloc]init];
    [secondView addSubview:self.secondImage];
    [self.secondImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(secondView.mas_top).with.offset(10);
        make.left.equalTo(secondView.mas_left).with.offset(10);
        make.width.equalTo(@49);
        make.height.equalTo(@49);

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

    self.descSecondBtn = [[UIButton alloc]init];
    [Tool setCorner:self.descSecondBtn borderColor:UI_MAIN_COLOR];
    self.descSecondBtn.titleLabel.font = [UIFont systemFontOfSize:11];
    [self.descSecondBtn setTitleColor:UI_MAIN_COLOR forState:UIControlStateNormal];
    [firstView addSubview:self.descSecondBtn];
    [self.descSecondBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wekSelf.termSecondLabel.mas_bottom).with.offset(5);
        make.left.equalTo(wekSelf.secondImage.mas_right).with.offset(15);
        make.height.equalTo(@15);
    }];
//    self.descSecondImage = [[UIImageView alloc]init];
//    [secondView addSubview:self.descSecondImage];
//    [self.descSecondImage mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(wekSelf.termSecondLabel.mas_bottom).with.offset(5);
//        make.left.equalTo(wekSelf.secondImage.mas_right).with.offset(15);
//
//    }];

    UIImageView *arrowSecondImage = [[UIImageView alloc]init];
    arrowSecondImage.image = [UIImage imageNamed:@"icon_jiantou"];
    [secondView addSubview:arrowSecondImage];
    [arrowSecondImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(secondView.mas_top).with.offset(40);
        make.right.equalTo(secondView.mas_right).with.offset(-15);

    }];
    
    self.jumpBtn = [[UIButton alloc]init];
    [self.jumpBtn setTitle:@"点击查看更多" forState:UIControlStateNormal];
    [self.jumpBtn setTitleColor:UI_MAIN_COLOR forState:UIControlStateNormal];
    self.jumpBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.jumpBtn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:self.jumpBtn];
    [self.jumpBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(secondView.mas_bottom).with.offset(10);
        make.centerX.equalTo(contentView.mas_centerX);
        make.height.equalTo(@20);
        make.width.equalTo(@100);
    }];
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = UI_MAIN_COLOR;
    [contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wekSelf.jumpBtn.mas_bottom).with.offset(2);
        make.centerX.equalTo(contentView.mas_centerX);
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


-(void)setHomeProductList:(HomeProductList *)homeProductList
{

    [self settingData:homeProductList];
}

-(void)settingData:(HomeProductList *)homeProductList{

    NSURL *firstUrl = [NSURL URLWithString:homeProductList.result.products[0].ext_attr_.icon_];
    [self.firstImage sd_setImageWithURL:firstUrl];
    self.nameFirstLabel.text = homeProductList.result.products[0].name_;
    self.quotaFirstLabel.text = [NSString stringWithFormat:@"额度：最高%@元",homeProductList.result.products[0].principal_top_];
    self.termFirstLabel.text = [NSString stringWithFormat:@"期限：%@-%@%@",homeProductList.result.products[0].staging_top_,homeProductList.result.products[0].staging_bottom_,homeProductList.result.products[0].remark_];
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:self.termFirstLabel.text];
    [attributedStr addAttribute:NSForegroundColorAttributeName value:UI_MAIN_COLOR range:NSMakeRange(3, self.termFirstLabel.text.length-4)];
    self.termFirstLabel.attributedText = attributedStr;
    
    self.feeFirstLabel.text = [NSString stringWithFormat:@"费用：%@/%@",homeProductList.result.products[0].pre_service_fee_rate_,homeProductList.result.products[0].remark_];
    NSMutableAttributedString *feeAttribute = [[NSMutableAttributedString alloc]initWithString:self.feeFirstLabel.text];
    [feeAttribute addAttribute:NSForegroundColorAttributeName value:UI_MAIN_COLOR range:NSMakeRange(3, self.feeFirstLabel.text.length-5)];
    self.feeFirstLabel.attributedText = feeAttribute;
    [self.descFirstBtn setTitle:[NSString stringWithFormat:@" %@ ",homeProductList.result.products[0].ext_attr_.tags[0]] forState:UIControlStateNormal];
//    self.descFirstImage.image = [UIImage imageNamed:@"tuoyuan_1"];
    
    NSURL *secondUrl = [NSURL URLWithString:homeProductList.result.products[1].ext_attr_.icon_];
    [self.secondImage sd_setImageWithURL:secondUrl];
    self.nameSecondLabel.text = homeProductList.result.products[1].name_;
    self.quotaSecondLabel.text = [NSString stringWithFormat:@"额度：最高%@元",homeProductList.result.products[1].principal_top_];
    self.termSecondLabel.text = [NSString stringWithFormat:@"期限：%@-%@%@",homeProductList.result.products[1].staging_top_,homeProductList.result.products[1].staging_bottom_,homeProductList.result.products[1].remark_];
    NSMutableAttributedString *termAttribute = [[NSMutableAttributedString alloc]initWithString:self.termSecondLabel.text];
    [termAttribute addAttribute:NSForegroundColorAttributeName value:UI_MAIN_COLOR range:NSMakeRange(3, self.termSecondLabel.text.length-4)];
    self.termSecondLabel.attributedText = termAttribute;
    self.feeSecondLabel.text = [NSString stringWithFormat:@"费用：%@%@",homeProductList.result.products[1].pre_service_fee_rate_,homeProductList.result.products[1].remark_];
    NSMutableAttributedString *feeSecondAttribute = [[NSMutableAttributedString alloc]initWithString:self.feeSecondLabel.text];
    [feeSecondAttribute addAttribute:NSForegroundColorAttributeName value:UI_MAIN_COLOR range:NSMakeRange(3, self.feeSecondLabel.text.length-4)];
    self.feeSecondLabel.attributedText = feeSecondAttribute;
    [self.descSecondBtn setTitle:[NSString stringWithFormat:@" %@ ",homeProductList.result.products[1].ext_attr_.tags[0]] forState:UIControlStateNormal];
//    self.descSecondImage.image = [UIImage imageNamed:@"tuoyuan_2"];
    self.firstUrl = homeProductList.result.products[1].ext_attr_.path_;
    self.secondUrl = homeProductList.result.products[1].ext_attr_.path_;
    [self setNeedsDisplay];
}
@end
