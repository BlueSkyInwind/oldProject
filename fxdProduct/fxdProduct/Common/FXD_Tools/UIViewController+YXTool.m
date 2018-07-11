//
//  UIViewController+YXTool.m
//  fxdProduct
//
//  Created by admin on 2018/7/11.
//  Copyright © 2018年 dd. All rights reserved.
//

#import "UIViewController+YXTool.h"

@implementation UIViewController (YXTool)

-(CGFloat)obtainBarHeight_New{
    return [[UIApplication sharedApplication] statusBarFrame].size.height + self.navigationController.navigationBar.frame.size.height;
}


@end
