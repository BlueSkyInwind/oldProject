//
//  UIView+YXTool.m
//  fxdProduct
//
//  Created by admin on 2018/6/7.
//  Copyright © 2018年 dd. All rights reserved.
//

#import "UIView+YXTool.h"

@implementation UIView (YXTool)

- (void)addShadow{
    self.layer.shadowPath =[UIBezierPath bezierPathWithRect:self.bounds].CGPath;
    self.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.layer.shadowOpacity = 1.0f;
    self.layer.shadowOffset = CGSizeMake(0, 0);
    self.layer.shadowRadius = 5.0f;
}
- (void)setCornerRadius:(CGFloat)radius withShadow:(BOOL)shadow withOpacity:(CGFloat)opacity {
    self.layer.cornerRadius = radius;
    if (shadow) {
        self.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        self.layer.shadowOpacity = opacity;
        self.layer.shadowOffset = CGSizeMake(0, 1);
        self.layer.shadowRadius = 2;
        self.layer.shouldRasterize = NO;
        self.layer.shadowPath = [[UIBezierPath bezierPathWithRoundedRect:[self bounds] cornerRadius:radius] CGPath];
    }
    self.layer.masksToBounds = !shadow;
}
@end
