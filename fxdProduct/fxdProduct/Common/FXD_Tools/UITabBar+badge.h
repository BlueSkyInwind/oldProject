//
//  UITabBar+badge.h
//  fxdProduct
//
//  Created by sxp on 2017/12/7.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (badge)

- (void)showBadgeOnItemIndex:(int)index;
- (void)hideBadgeOnItemIndex:(int)index;

@end
