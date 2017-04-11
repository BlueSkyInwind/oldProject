//
//  MyCardCell.m
//  fxdProduct
//
//  Created by zhangbaochuan on 15/12/28.
//  Copyright © 2015年 dd. All rights reserved.
//

#import "MyCardCell.h"

@implementation MyCardCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)btnEditInfo:(id)sender {
    self.myBlock(self.cardTypeFlag);
}
@end
