//
//  MBPAlertView.h
//  fxdProduct
//
//  Created by dd on 15/11/9.
//  Copyright © 2015年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class MBProgressHUD;

@interface MBPAlertView : NSObject{
    
}

@property (nonatomic,strong) MBProgressHUD *progressHud;
@property (nonatomic,strong) MBProgressHUD *waitHud;
@property (nonatomic,strong) MBProgressHUD *waitHudView;

+ (MBPAlertView *)sharedMBPTextView;

//- (void)presentViewController:(UIViewController *)viewControllerToPresent animated: (BOOL)flag completion:(void (^ __nullable)(void))completion

- (void) showTextOnly:(UIView *)view message: (NSString *)message;

/**
进度显示

 @param view 父视图
 @param progress 进度值
 */
- (void) showProgressOnly:(UIView *)view Progress: (float)progress;

/**
 展现等待条

 @param view 父视图
 */
- (void) showIndeterminateOnly:(UIView *)view;
-(void)removeWaitHud;

/**
 动画等待条

 @param view 父视图
 */
- (void)loadingWaitHUDView:(UIView *)view;
-(void)removeWaitHUDView;

@end
