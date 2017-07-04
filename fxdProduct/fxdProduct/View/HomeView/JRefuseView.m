//
//  JRefuseView.m
//  fxdProduct
//
//  Created by sxp on 17/6/28.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "JRefuseView.h"
#define tipColor rgb(0,170,238)
#define nameColor rgb(26,26,26)
#define quotaColor rgb(77,77,77)
#define termColor rgb(102,102,102)
@implementation JRefuseView

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

    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    __weak typeof(self) weakSelf = self;
    UIImageView *image = [[UIImageView alloc]init];
    image.image = [UIImage imageNamed:@"logo_kuang_2"];
    image.userInteractionEnabled = YES;
    [self addSubview:image];
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(20);
        make.right.equalTo(weakSelf.mas_right).with.offset(-20);
        make.top.equalTo(weakSelf.mas_top).with.offset(50);
    }];
    
    UIImageView *closeImage = [[UIImageView alloc]init];
    closeImage.image = [UIImage imageNamed:@"icon_cha"];
    [self addSubview:closeImage];
    [closeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).with.offset(70);
        make.right.equalTo(weakSelf.mas_right).with.offset(-20);
    }];
    
    UILabel *label = [[UILabel alloc]init];
    label.text = @"抱歉，您的信用评分不足";
    label.textColor = nameColor;
    label.font = [UIFont systemFontOfSize:18];
    [image addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(image.mas_top).with.offset(140);
        make.centerX.equalTo(image.mas_centerX);
        make.height.equalTo(@20);
    }];
    
    UILabel *tipLabel = [[UILabel alloc]init];
    tipLabel.text = @"试试急速贷产品？通过率更高";
    tipLabel.textColor = tipColor;
    tipLabel.font = [UIFont systemFontOfSize:14];
    [image addSubview:tipLabel];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(image.mas_top).with.offset(200);
        make.left.equalTo(image.mas_left).with.offset(20);
        make.height.equalTo(@15);
    }];
    
    UIImageView *bottomImage = [[UIImageView alloc]init];
    bottomImage.image = [UIImage imageNamed:@"kuang"];
    [image addSubview:bottomImage];
    [bottomImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(image.mas_top).with.offset(230);
        make.left.equalTo(image.mas_left).with.offset(20);
        make.right.equalTo(image.mas_right).with.offset(-20);
        make.height.equalTo(@150);
    }];
    
    self.nameImage = [[UIImageView alloc]init];
    [bottomImage addSubview:self.nameImage];
    [self.nameImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomImage.mas_top).with.offset(20);
        make.left.equalTo(bottomImage.mas_left).with.offset(20);
        
    }];
    
    self.nameLabel = [[UILabel alloc]init];
    self.nameLabel.textColor = nameColor;
    self.nameLabel.font = [UIFont systemFontOfSize:18];
    [bottomImage addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomImage.mas_top).with.offset(30);
        make.left.equalTo(weakSelf.nameImage.mas_right).with.offset(10);
        make.height.equalTo(@20);
    }];
    
    self.contentImage = [[UIImageView alloc]init];
    [bottomImage addSubview:self.contentImage];
    [self.contentImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomImage.mas_top).with.offset(30);
        make.left.equalTo(weakSelf.nameLabel.mas_right).with.offset(10);
        
    }];
    
    self.quotaLabel = [[UILabel alloc]init];
    self.quotaLabel.textColor = quotaColor;
    self.quotaLabel.font = [UIFont systemFontOfSize:17];
    self.quotaLabel.textAlignment = NSTextAlignmentCenter;
    [bottomImage addSubview:self.quotaLabel];
    [self.quotaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.nameLabel.mas_bottom).with.offset(20);
        make.left.equalTo(bottomImage.mas_left).with.offset(20);
        make.height.equalTo(@15);
        make.width.equalTo(@((width-120)/2));
    }];
    
    UILabel *quLabel = [[UILabel alloc]init];
    quLabel.text = @"额度";
    quLabel.textColor = termColor;
    quLabel.font = [UIFont systemFontOfSize:15];
    quLabel.textAlignment = NSTextAlignmentCenter;
    [bottomImage addSubview:quLabel];
    [quLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.quotaLabel.mas_bottom).with.offset(10);
        make.height.equalTo(@15);
        make.left.equalTo(bottomImage.mas_left).with.offset(20);
        make.width.equalTo(@((width-120)/2));
    }];
    UIImageView *lineImage = [[UIImageView alloc]init];
    lineImage.image = [UIImage imageNamed:@"xuxian"];
    [bottomImage addSubview:lineImage];
    [lineImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.nameLabel.mas_bottom).with.offset(20);
        make.centerX.equalTo(bottomImage.mas_centerX);
        
    }];
    
    self.termLabel = [[UILabel alloc]init];
    self.termLabel.textColor = quotaColor;
    self.termLabel.font = [UIFont systemFontOfSize:17];
    self.termLabel.textAlignment = NSTextAlignmentCenter;
    [bottomImage addSubview:self.termLabel];
    [self.termLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.nameLabel.mas_bottom).with.offset(20);
        make.height.equalTo(@15);
        make.right.equalTo(bottomImage.mas_right).with.offset(-20);
        make.width.equalTo(@((width-120)/2));
    }];
    
    UILabel *terLabel = [[UILabel alloc]init];
    terLabel.textColor = termColor;
    terLabel.text = @"期限";
    terLabel.font = [UIFont systemFontOfSize:15];
    terLabel.textAlignment = NSTextAlignmentCenter;
    [bottomImage addSubview:terLabel];
    [terLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.termLabel.mas_bottom).with.offset(10);
        make.height.equalTo(@15);
        make.right.equalTo(bottomImage.mas_right).with.offset(-20);
        make.width.equalTo(@((width-120)/2));
    }];
    
    self.abandonBtn = [[UIButton alloc]init];
    [self.abandonBtn setTitle:@"放弃" forState:UIControlStateNormal];
    [self.abandonBtn setTitleColor:quotaColor forState:UIControlStateNormal];
    self.abandonBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [self.abandonBtn setBackgroundColor:[UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0]];
    [Tool setCorner:self.abandonBtn borderColor:[UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0]];
    [image addSubview:self.abandonBtn];
    [self.abandonBtn addTarget:self action:@selector(clickAbandoneBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.abandonBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(bottomImage.mas_bottom).with.offset(20);
        make.left.equalTo(image.mas_left).with.offset(20);
        make.height.equalTo(@44);
        make.width.equalTo(@((width-100)/2));
    }];
    
    self.applayBtn = [[UIButton alloc]init];
    [self.applayBtn setTitle:@"去申请" forState:UIControlStateNormal];
    [self.applayBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.applayBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [self.applayBtn setBackgroundColor:tipColor];
    [Tool setCorner:self.applayBtn borderColor:tipColor];
    [self.applayBtn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    [image addSubview:self.applayBtn];
    [self.applayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomImage.mas_bottom).with.offset(20);
        make.right.equalTo(image.mas_right).with.offset(-20);
        make.height.equalTo(@44);
        make.width.equalTo(@((width-100)/2));
    }];
}

-(void)clickAbandoneBtn{

    if (self.abandonBtnClick) {
        self.abandonBtnClick();
    }
    
}
-(void)clickBtn{

    if (self.applayBtnClick) {
        self.applayBtnClick();
    }
}

-(void)setContent:(NSArray *)content{

    self.nameImage.image = [UIImage imageNamed:content[0]];
    self.nameLabel.text = content[1];
    self.contentImage.image = [UIImage imageNamed:content[2]];
    self.quotaLabel.text = content[3];
    self.termLabel.text = content[4];
}
@end
