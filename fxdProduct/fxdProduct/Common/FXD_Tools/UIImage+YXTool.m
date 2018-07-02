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

/**
 生成渐变图片

 @param colors 颜色
 @param type 渐变类型  0--->从上到下   1--->从左到右
 @return 图片
 */
+(UIImage *)gradientmageWithFrame:(CGRect)bound Colors:(NSArray *)colors GradientType:(int)type{
    
    NSMutableArray *arr = [NSMutableArray array];
    
    for(UIColor * c in colors) {
        [arr addObject:(id)c.CGColor];
    }
    
    CGRect rect = bound;
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)arr, NULL);
    CGPoint start;
    CGPoint end;
    
    switch (type) {
        case 0:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(0.0, rect.size.height);
            break;
        case 1:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(rect.size.width, 0.0);
            break;
        default:
            //默认横向
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(0.0, rect.size.height);
            break;
    }
    
    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    return image;
}




@end
