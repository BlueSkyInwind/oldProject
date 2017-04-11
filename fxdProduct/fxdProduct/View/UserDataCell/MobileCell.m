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
    [Tool setCorner:self.passView borderColor:rgb(0, 170, 238)];
    [Tool setCorner:self.smsCodeView borderColor:rgb(0, 170, 238)];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
