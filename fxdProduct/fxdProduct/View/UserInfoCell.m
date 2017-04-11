//
//  UserInfoCell.m
//  fxdProduct
//
//  Created by dd on 15/8/27.
//  Copyright (c) 2015年 dd. All rights reserved.
//

#import "UserInfoCell.h"

@implementation UserInfoCell

- (void)awakeFromNib {
    // Initialization code
    
    self.headImage.clipsToBounds=YES;
    [self.headImage.layer setMasksToBounds:YES];
    self.headImage.layer.cornerRadius=_headImage.frame.size.width/2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
