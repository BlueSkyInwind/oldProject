//
//  PayDisplayCell.m
//  fxdProduct
//
//  Created by admin on 2017/7/19.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "PayDisplayCell.h"

@implementation PayDisplayCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setDispalyLabeltext:(NSString *)text{
    if (text.length == 11) {
        NSMutableString * str = [text mutableCopy];
        _dispalyLabel.text = [NSString stringWithFormat:@"验证码会发送到您%@的手机",[str stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"]];
    }
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
