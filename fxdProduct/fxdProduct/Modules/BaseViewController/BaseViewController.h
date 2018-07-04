//
//  BaseViewController.h
//  fxdProduct
//
//  Created by dd on 15/7/31.
//  Copyright (c) 2015年 dd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+RTRootNavigationController.h"

@interface BaseViewController : UIViewController <UITabBarControllerDelegate,UITabBarDelegate>{
    
    
    
}

/**失败加载的状态*/
@property (nonatomic,assign,readonly)BOOL isFailure;

#pragma mrak - 跳转登录
-(void)presentLoginVCCompletion:(void (^ __nullable)(void))completion;

- (void)setNavMesRightBar;

- (void)setNavCallRightBar;

- (void)setNavSignLeftBar;

#pragma mrak - 导航左侧按钮类型
- (void)addBackItem;

- (void)addBackItemRoot;

- (void)popBack;

-(void)setFailView;
-(void)removeFailView;
-(void)LoadFailureLoadRefreshButtonClick;
- (void)addCloseItem;


@end
