//
//  SumCell.m
//  fxdProduct
//
//  Created by dd on 2017/2/6.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "SumCell.h"

@implementation SumCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [Tool setCorner:self.lowBtn borderColor:[UIColor blackColor]];
    [Tool setCorner:self.middleBtn borderColor:[UIColor blackColor]];
    [Tool setCorner:self.heighBtn borderColor:[UIColor blackColor]];
    [self.lowBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.middleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.heighBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.lowBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.middleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.heighBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
