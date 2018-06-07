//
//  UIButton+YXTool.m
//  fxdProduct
//
//  Created by admin on 2018/6/7.
//  Copyright © 2018年 dd. All rights reserved.
//

#import "UIButton+YXTool.h"

@implementation UIButton (YXTool)

-(void)changeTitleTopInsets:(CGFloat)num{
    [self setTitleEdgeInsets:UIEdgeInsetsMake(-num, 0, 0, 0)];
}
-(void)changeTitleLeftInsets:(CGFloat)num{
    [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -num, 0, 0)];
}
-(void)changeTitleBottomInsets:(CGFloat)num{
    [self setTitleEdgeInsets:UIEdgeInsetsMake(num, 0, 0, 0)];
}
-(void)changeTitleRightInsets:(CGFloat)num{
    [self setTitleEdgeInsets:UIEdgeInsetsMake(0, num, 0, 0)];
}

-(void)changeTitleOfLeftAndImageOfRight{
    CGSize titleSize = self.titleLabel.bounds.size;
    CGSize imageSize = self.imageView.bounds.size;
    CGFloat interval = 1.0;
    self.imageEdgeInsets = UIEdgeInsetsMake(0,titleSize.width + interval, 0, -(titleSize.width + interval));
    self.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageSize.width + interval), 0, imageSize.width + interval);
}

@end
