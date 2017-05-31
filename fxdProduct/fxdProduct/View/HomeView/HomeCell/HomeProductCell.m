//
//  HomeProductCell.m
//  fxdProduct
//
//  Created by dd on 2017/1/3.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "HomeProductCell.h"

@implementation HomeProductCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [_proLogoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(@17);
        make.height.equalTo(@37);
        make.width.equalTo(_proLogoImage.mas_height).multipliedBy(1);
    }];
    
    [_amountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_proLogoImage.mas_right).offset(25);
        make.top.equalTo(_proLogoImage.mas_top).offset(-5);
        make.width.equalTo(@64);
        make.height.equalTo(_amountView.mas_width).multipliedBy(0.29);
    }];
    
    [_periodLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.equalTo(_proLogoImage.mas_right).offset(25);
        make.top.equalTo(_amountView.mas_bottom).offset(9);
        make.width.equalTo(@120);
        make.height.equalTo(_periodLabel.mas_width).multipliedBy(0.15);
    }];
    
    [self.specialtyImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.amountView.mas_top).offset(-2);
        make.left.equalTo(self.amountView.mas_right).offset(5);
        make.height.equalTo(@21);
        make.width.equalTo(@63);
    }];
    
//    self.linesLimitImageView  = [[UIImageView alloc]init];
//    [self.contentView addSubview:self.linesLimitImageView];
//    [self.linesLimitImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.contentView.mas_top).offset(30);
//        make
//        
//        
//    }];
    
    
    if (!self.helpImage.isHidden) {
        [self.helpImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@17);
            make.width.equalTo(@17);
            make.left.equalTo(self.periodLabel.mas_right).offset(0);
            make.top.equalTo(self.specialtyImage.mas_bottom).offset(10);
        }];
    }
    
    
}

- (YYLabel *)amountLabel {
    if (_amountLabel == nil) {
        _amountLabel = [YYLabel new];
        _amountLabel.textVerticalAlignment = YYTextVerticalAlignmentCenter;
        _amountLabel.numberOfLines = 0;
        [self.amountView addSubview:_amountLabel];
        [_amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
            make.left.equalTo(@0);
            make.right.equalTo(@0);
            make.bottom.equalTo(@0);
        }];
    }
    return _amountLabel;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
