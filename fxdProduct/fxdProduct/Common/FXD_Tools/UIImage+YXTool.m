//
//  UIImage+YXTool.m
//  fxdProduct
//
//  Created by admin on 2018/6/22.
//  Copyright © 2018年 dd. All rights reserved.
//

#import "UIImage+YXTool.h"

@implementation UIImage (YXTool)

/**
 生成对应颜色的图片
 @param color 色值
 @return 图片
 */
+(UIImage *)imageWithColor:(UIColor *)color {
    
    CGRect rect = CGRectMake(0.0, 0.0, 1.0, 1.0);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef  context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage * image =  UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
