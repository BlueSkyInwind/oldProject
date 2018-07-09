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
 
 @param copyContent 复制内容
 @param vc 视图
 @param str 提示内容
 */
-(void)ClipboardOfCopy:(id)copyContent VC:(UIViewController *)vc prompt:(NSString *)str;

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
 长按获取图片地址

 @param imgUrl 图片链接
 @param currentVC 当前VC
 */
-(void)obtainImgUrlEvent:(NSString *)imgUrl VC:(UIViewController *)currentVC;
/**
 保存相册
 
 @param src 图片URL
 @param currentVC 当前VC
 */
- (void)savePictureToAlbum:(NSString *)src VC:(UIViewController *)currentVC;

/**
 识别二维码图片

 @param imgUrl 图片url
 @param currentVC当前视图
 @param isCopy 是否复制到剪贴板
 @param complication 识别结果回调
 */
-(void)obtainImgUrlEvent:(NSString *)imgUrl VC:(UIViewController *)currentVC isCopy:(BOOL)isCopy complication:(void(^)(NSString * content))result;
/**
 调用本地等待条
 @param vc 父视图
 */
-(void)waitHubAnimationView:(UIViewController *)vc;
-(void)removeWaitHubAnimationView;

/**
 存储app的登录信息

 @param 数据
 */
-(void)saveJsLoginInfo:(NSDictionary *)dic;
/**
 获取app的登录信息-> h5
 */
-(LoginSyncParse *)obtainLoginInfo;
#pragma mark -- app启动跳转处理

/**
 外部启动app跳转某个页面
 
 @param viewControllerNameIden 识别符
 */
-(void)pushAppViewController:(NSString *)viewControllerNameIden;


@end
