//
//  SesameCreditCell.m
//  fxdProduct
//
//  Created by sxp on 17/5/3.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "SesameCreditCell.h"

@implementation SesameCreditCell

- (void)awakeFromNib {
    [super awakeFromNib];

    NSString *str =self.tipLabel.text;
     NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc]initWithString:str];
    [str1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0/255.0 green:122/255.0 blue:255/255.0 alpha:1.0] range:NSMakeRange(4,2)];
    self.tipLabel.attributedText = str1;
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
