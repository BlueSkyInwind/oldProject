//
//  CheckFalseView.m
//  fxdProduct
//
//  Created by zhangbaochuan on 16/1/27.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "CheckFalseView.h"

@implementation CheckFalseView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:_promoteLabel.text];
    [attributeStr addAttribute:NSForegroundColorAttributeName value:rgb(255, 134, 25) range:[_promoteLabel.text rangeOfString:@"500~1000"]];
    self.promoteLabel.attributedText = attributeStr;
    [Tool setCorner:self.moreInfoBtn borderColor:[UIColor clearColor]];
}

@end
