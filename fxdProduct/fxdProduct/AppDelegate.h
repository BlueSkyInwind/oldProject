//
//  AppDelegate.h
//  fxdProduct
//
//  Created by dd on 15/7/27.
//  Copyright (c) 2015年 dd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FXDBaseTabBarVCModule.h"

static NSString *appKey = @"ba8e9f4d543ae506db5295fb";
static NSString *channel = @"App Store";
static BOOL isProduction = true;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property float autoSizeScaleX;
@property float autoSizeScaleY;

@property (nonatomic,strong)FXDBaseTabBarVCModule *btb;
@property (nonatomic,strong)NSDictionary * notificationContentInfo;
@property (nonatomic,assign)BOOL isHomeChooseShow;

@end

