//
//  UIImage+YXTool.h
//  fxdProduct
//
//  Created by admin on 2018/6/22.
//  Copyright © 2018年 dd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (YXTool)

/**
 生成对应颜色的图片
 @param color 色值
 @return 图片
 */
+(UIImage *)imageWithColor:(UIColor *)color;

/**
 生成渐变图片
 
 @param colors 颜色
 @param type 渐变类型  0--->从上到下   1--->从左到右
 @return 图片
 */
+(UIImage *)gradientmageWithFrame:(CGRect)bound Colors:(NSArray *)colors GradientType:(int)type;

@end
