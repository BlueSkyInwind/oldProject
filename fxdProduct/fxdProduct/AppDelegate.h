//
//  AppDelegate.h
//  fxdProduct
//
//  Created by dd on 15/7/27.
//  Copyright (c) 2015年 dd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTabBarViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property float autoSizeScaleX;
@property float autoSizeScaleY;

@property (nonatomic,strong)BaseTabBarViewController *btb;

@end

