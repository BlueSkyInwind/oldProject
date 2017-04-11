//
//  DaysCell.m
//  fxdProduct
//
//  Created by dd on 2017/2/6.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "DaysCell.h"

@implementation DaysCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [Tool setCorner:self.dayView borderColor:[UIColor clearColor]];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
