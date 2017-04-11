//
//  CircleView.m
//  fxdProduct
//
//  Created by zhangbaochuan on 15/12/14.
//  Copyright © 2015年 dd. All rights reserved.
//

#import "CircleView.h"

@implementation CircleView
static float arcWidth; //圆弧的宽度
static double pieCapacity;  //角度增量值
static float formWidth;



-(id)initWithFrame:(CGRect)frame arcWidth:(double)width current:(double)current total:(double)total
{
    self = [super initWithFrame:frame];
    if (self) {
        formWidth = frame.size.width;
        arcWidth=width;
        pieCapacity=current/total;
//        DLog(@"pieCapacity->>%f",pieCapacity);
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
   
    drawArcbg();
    drawArc();
   
}

+ (void)createCurrent:(double)current total:(double)total
{
    pieCapacity=current/total;
    DLog(@"pieCapacity->>%f",pieCapacity);
    drawArc();
}



//画圆弧
void drawArc()
{
    //1.获得图形上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    
    //2.绘制图形
//    CGContextAddArc(context, 100, 10, 50, M_PI_2, M_PI, 0);
//    //CGContextAddArc(context, 100, 100, 50, M_PI_2, M_PI, 0);
//    //                                      90,    180, 1逆时针，0顺时针
//    //3.显示
//    CGContextStrokePath(context);
    CGContextSetRGBStrokeColor(context, 0/255.0, 170/255.0, 238/255.0, 1.0);
    CGContextSetLineWidth(context, arcWidth);
    //void CGContextAddArc(CGContextRef c,CGFloat x, CGFloat y,CGFloat radius,CGFloat startAngle,CGFloat endAngle, int clockwise)1弧度＝180°/π （≈57.3°） 度＝弧度×180°/π 360°＝360×π/180 ＝2π 弧度
    // x,y为圆点坐标，radius半径，startAngle为开始的弧度，endAngle为 结束的弧度，clockwise 0为顺时针，1为逆时
    CGContextAddArc(context, formWidth/2.0, formWidth/2.0+10, formWidth/2.0-10, 5*M_PI/6.0, 5*M_PI/6.0+pieCapacity*(13*M_PI/6.0 - 5*M_PI/6.0), 0);
//    CGContextAddArc(context, formWidth/2.0, formWidth/2.0, formWidth/2.0-5, 5*PI/6.0, (1 - pieCapacity)*13*PI/6.0, 0);
    CGContextDrawPath(context, kCGPathStroke);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGContextSetLineCap(context, kCGLineCapRound);//线的顶端
    
    
//    CGContextRelease(context);
}
//画圆弧
void drawArcbg()
{
    //1.获得图形上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    
    //2.绘制图形
    //    CGContextAddArc(context, 100, 10, 50, M_PI_2, M_PI, 0);
    //    //CGContextAddArc(context, 100, 100, 50, M_PI_2, M_PI, 0);
    //    //                                      90,    180, 1逆时针，0顺时针
    //    //3.显示
    //    CGContextStrokePath(context);
    CGContextSetRGBStrokeColor(context, 250/255.0, 199/255.0, 0/255.0, 1.0);
    CGContextSetLineWidth(context, arcWidth);
    //void CGContextAddArc(CGContextRef c,CGFloat x, CGFloat y,CGFloat radius,CGFloat startAngle,CGFloat endAngle, int clockwise)1弧度＝180°/π （≈57.3°） 度＝弧度×180°/π 360°＝360×π/180 ＝2π 弧度
    // x,y为圆点坐标，radius半径，startAngle为开始的弧度，endAngle为 结束的弧度，clockwise 0为顺时针，1为逆时
    CGContextAddArc(context, formWidth/2.0, formWidth/2.0+10, formWidth/2.0-10, 5*M_PI/6.0, 13*M_PI/6.0, 0);
    //    CGContextAddArc(context, formWidth/2.0, formWidth/2.0, formWidth/2.0-5, 5*PI/6.0, (1 - pieCapacity)*13*PI/6.0, 0);
    CGContextDrawPath(context, kCGPathStroke);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGContextSetLineCap(context, kCGLineCapRound);//线的顶端
    
//        CGContextRelease(context);
}


@end
