//
//  MyViewACell.m
//  fxdProduct
//
//  Created by dd on 15/8/19.
//  Copyright (c) 2015年 dd. All rights reserved.
//

#import "MyViewACell.h"

@implementation MyViewACell

- (void)awakeFromNib {
    // Initialization code
    self.mineBackGround.clipsToBounds=YES;
    self.iconImageView.clipsToBounds=YES;
    [self.iconImageView.layer setMasksToBounds:YES];
    self.iconImageView.layer.cornerRadius=_iconImageView.frame.size.width/2;
//    self.iconImageView.layer.borderWidth = 0.5;
//    self.iconImageView.layer.borderColor = [UIColor whiteColor].CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
