//
//  CircleView.h
//  fxdProduct
//
//  Created by zhangbaochuan on 15/12/14.
//  Copyright © 2015年 dd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircleView : UIView

-(id)initWithFrame:(CGRect)frame arcWidth:(double)width current:(double)current total:(double)total;
+ (void)createCurrent:(double)current total:(double)total;

@end
