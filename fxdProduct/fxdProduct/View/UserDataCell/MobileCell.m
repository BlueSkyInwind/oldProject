//
//  MobileCell.m
//  fxdProduct
//
//  Created by dd on 2017/2/22.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "MobileCell.h"

@implementation MobileCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [FXD_Tool setCorner:self.passView borderColor:UI_MAIN_COLOR];
    [FXD_Tool setCorner:self.smsCodeView borderColor:UI_MAIN_COLOR];
    [FXD_Tool setCorner:self.picCodeView borderColor:UI_MAIN_COLOR];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
