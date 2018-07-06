//
//  JSAndOCInteraction.h
//  fxdProduct
//
//  Created by admin on 2017/9/18.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSAndOCInteraction : NSObject

+ (JSAndOCInteraction *)sharedInteraction;

#pragma mark -- js交互处理

/**
 分享
 
 @param view 分享视图u
 @param content 分享内容
 @param urlStr 分享链接
 @param title 分享标题
 @param imageUrl 分享图片
 
 */
-(void)shareContent:(UIViewController *)viewC shareContent:(NSString *)content UrlStr:(NSString *)urlStr shareTitle:(NSString *)title shareImage:(NSString *)imageUrl;

/**
 复制
 
 @param copyStr 复制内容
 @param vc 视图
 @param str 提示内容
 */
-(void)ClipboardOfCopy:(NSString *)copyStr VC:(UIViewController *)vc prompt:(NSString *)str;

/**
 前往某个固定页面
 
 @param viewControllerName 视图名称  :
 
 RepayRecordController  借款记录，
 MyCardsViewController 银行卡，
 InvitationViewController  邀请好友，
 DiscountTicketController  我的红包，
 IdeaBackViewController  意见反馈，
 UserEvaluate   用户评价，
 ServiceHotline  服务热线，
 ChangePasswordViewController  修改密码，
 AboutMainViewController  关于我们，
 
 @param currentVC 当前VC
 */
-(void)pushViewController:(NSString *)viewControllerName VC:(UIViewController *)currentVC;

/**
 保存相册
 
 @param src 图片URL
 @param currentVC 当前VC
 */
- (void)savePictureToAlbum:(NSString *)src VC:(UIViewController *)currentVC;

/**
 调用本地等待条
 @param vc 父视图
 */
-(void)waitHubAnimationView:(UIViewController *)vc;
-(void)removeWaitHubAnimationView;

/**
 获取app的登录信息

 @param 数据
 */
-(void)obtainLoginInfo:(NSDictionary *)dic;

#pragma mark -- app启动跳转处理

/**
 外部启动app跳转某个页面
 
 @param viewControllerNameIden 识别符
 */
-(void)pushAppViewController:(NSString *)viewControllerNameIden;


@end
