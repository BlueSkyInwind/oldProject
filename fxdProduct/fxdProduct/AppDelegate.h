//
//  AppDelegate.h
//  fxdProduct
//
//  Created by dd on 15/7/27.
//  Copyright (c) 2015年 dd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTabBarViewController.h"

static NSString *appKey = @"ba8e9f4d543ae506db5295fb";
static NSString *channel = @"App Store";
static BOOL isProduction = false;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property float autoSizeScaleX;
@property float autoSizeScaleY;

@property (nonatomic,strong)BaseTabBarViewController *btb;
@property (nonatomic,strong)NSDictionary * notificationContentInfo;

@end

