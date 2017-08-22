//
//  UnfoldTableViewCell.m
//  fxdProduct
//
//  Created by admin on 2017/8/21.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "UnfoldTableViewCell.h"

@implementation UnfoldTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    UITapGestureRecognizer * tap  = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapViewClick)];
    [self.tapView addGestureRecognizer:tap];
}
-(void)tapViewClick{
    
    if (self.unfoldBtnClick) {
        self.unfoldBtnClick();
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
