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
    self.layer.shadowOpacity = 0.6f;
    self.layer.shadowOffset = CGSizeMake(7.0, 7.0f);
    self.layer.shadowRadius = 7.0f;
}

@end
