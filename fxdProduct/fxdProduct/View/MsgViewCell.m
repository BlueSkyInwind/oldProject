//
//  MsgViewCell.m
//  fxdProduct
//
//  Created by zy on 15/11/6.
//  Copyright © 2015年 dd. All rights reserved.
//

#import "MsgViewCell.h"
#import <POP/POP.h>
@implementation MsgViewCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}
- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];
    if (self.highlighted) {
        POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewScaleXY];
        scaleAnimation.duration = 10;
        scaleAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(0.2, 0.2)];
        [self.lblContent pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
    } else {
        POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
        scaleAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(1, 1)];
        scaleAnimation.velocity = [NSValue valueWithCGPoint:CGPointMake(8,8)];
        scaleAnimation.springBounciness = 15.f;
        [self.lblContent pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
