//
//  JSAndOCInteraction.m
//  fxdProduct
//
//  Created by admin on 2017/9/18.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "JSAndOCInteraction.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDKUI.h>
#import "LoginViewController.h"
#import "LoginViewModel.h"
@implementation JSAndOCInteraction

+ (JSAndOCInteraction *)sharedInteraction
{
    static JSAndOCInteraction *sharedInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}


#pragma mark -- js交互处理
/**
 分享

 @param view 分享视图u
 @param content 分享内容
 @param urlStr 分享链接
 @param title 分享标题
 @param imageUrl 分享图片

 */
-(void)shareContent:(UIViewController *)viewC shareContent:(NSString *)content UrlStr:(NSString *)urlStr shareTitle:(NSString *)title shareImage:(NSString *)imageUrl
{
    NSArray *imageArr = @[[UIImage imageNamed:@"logo_60"]];
    if (imageUrl != nil) {
        imageArr = @[imageUrl];
    }
    
    NSString * titleName  =  title == nil ? @"发薪贷" : title;
    
    NSString * invationCode =  [FXD_Tool getContentWithKey:kInvitationCode];
//    NSString * targetUrl = [urlStr stringByAppendingFormat:@"?merchant_code_=%@",invationCode];
    NSString * targetUrl = urlStr;

    if (imageArr) {
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:content
                                         images:imageArr
                                            url:[NSURL URLWithString:targetUrl]
                                          title:titleName
                                           type:SSDKContentTypeAuto];
        
        [shareParams SSDKSetupSinaWeiboShareParamsByText:[NSString stringWithFormat:@"%@\n%@链接:%@",titleName,content,targetUrl] title:titleName image:imageArr url:[NSURL URLWithString:targetUrl] latitude:0 longitude:0 objectID:nil type:SSDKContentTypeAuto];
        
        [shareParams SSDKSetupSMSParamsByText:[NSString stringWithFormat:@"%@\n%@链接:%@",titleName,content,targetUrl]  title:titleName images:imageArr attachments:nil recipients:nil type:SSDKContentTypeAuto];
        
        [shareParams SSDKEnableUseClientShare];
        [ShareSDK showShareActionSheet:nil
                                 items:nil
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       switch (state) {
                           case SSDKResponseStateSuccess:
                               [[MBPAlertView sharedMBPTextView] showTextOnly:viewC.view message:@"分享成功"];
                               break;
                               
                           case SSDKResponseStateFail:
                               [[MBPAlertView sharedMBPTextView] showTextOnly:viewC.view message:@"分享失败"];
                           default:
                               break;
                       }
                   }];
    }
}

/**
 复制

 @param copyStr 复制内容
 @param vc 视图
 @param str 提示内容
 */
-(void)ClipboardOfCopy:(NSString *)copyStr VC:(UIViewController *)vc prompt:(NSString *)str{
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = copyStr;
    [[MBPAlertView sharedMBPTextView] showTextOnly:vc.view message:str];
    
}
/**
 前往某个固定页面

 @param viewControllerName 视图名称  :
 
            MyOrdersViewController 我的订单
            MyCardsViewController 银行卡列表，
            InvitationViewController  邀请好友，
            DiscountTicketController  我的红包，
            IdeaBackViewController  意见反馈，
            UserEvaluate   用户评价，
            ServiceHotline  服务热线，
            ChangePasswordViewController  修改密码，
            AboutMainViewController  关于我们，
            loginAndRegisterModules  登录
            UserDataAuthenticationListVCModules 资料完善
 
 @param currentVC 当前VC
 */
-(void)pushViewController:(NSString *)viewControllerName VC:(UIViewController *)currentVC{
    
    if ([viewControllerName isEqualToString:@"UserEvaluate"]) {
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/id1089086853"]];
        return;
    }
    
    if ([viewControllerName isEqualToString:@"ServiceHotline"]) {
        [self ServiceHotline:currentVC];
        return;
    }
    
    if (![FXD_Utility sharedUtility].loginFlage || [viewControllerName isEqualToString:@"loginAndRegisterModules"]) {
        [self presentLogin:currentVC];
        return;
    }
    
    NSArray * vcArray = @[@"RepayRecordController",@"MyCardsViewController",@"AboutMainViewController",@"IdeaBackViewController"];
    @try {
        if ([vcArray containsObject:viewControllerName]) {
            Class vc = NSClassFromString(viewControllerName);
            UIViewController *viewController = [[vc alloc] initWithNibName:viewControllerName bundle:nil];
            [currentVC.navigationController pushViewController:viewController animated:true];
        }
        else {
            Class vc = NSClassFromString(viewControllerName);
            UIViewController *viewController = [[vc alloc] init];
            [currentVC.navigationController pushViewController:viewController animated:true];
        }
    } @catch (NSException *exception) {
        DLog(@"%@",exception);
    }
}

-(void)ServiceHotline:(UIViewController *)vc{
    
    UIAlertController *actionSheett = [UIAlertController alertControllerWithTitle:@"热线服务时间:9:00-17:30(工作日)" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *teleAction = [UIAlertAction actionWithTitle:@"4008-678-655" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSURL *telURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", @"4008-678-655"]];
        [[UIApplication sharedApplication] openURL:telURL];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [actionSheett addAction:teleAction];
    [actionSheett addAction:cancelAction];
    [vc presentViewController:actionSheett animated:YES completion:nil];
}

/**
 保存相册

 @param src 图片URL
 @param currentVC 当前VC
 */
- (void)savePictureToAlbum:(NSString *)src VC:(UIViewController *)currentVC
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要保存到相册吗？" preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        [self loadImage:src VC:currentVC];
    }]];
    [currentVC presentViewController:alert animated:YES completion:nil];
}

/**
 活动图片下载

 @param loadUrl 下载链接
 */
-(void)loadImage:(NSString *)loadUrl VC:(UIViewController *)currentVC{
    [[SDWebImageManager sharedManager] loadImageWithURL:[NSURL URLWithString:loadUrl] options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        if (expectedSize > 0) {
            float numper = (float)receivedSize / (float)expectedSize;
            [[MBPAlertView sharedMBPTextView] showProgressOnly:currentVC.view Progress:numper];
        }
    } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
        NSLog(@"%ld",cacheType);
        if (data || image) {
            UIImage * resultImage = data == nil ? image : [UIImage imageWithData:data];
            UIImageWriteToSavedPhotosAlbum(resultImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        }else{
            [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:@"保存失败"];
        }
    }];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (error != NULL){
        [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:@"保存失败"];
    }else{
        [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:@"保存成功"];
    }
}


/**
 调用本地等待条
 
 @param vc 父视图
 */
-(void)waitHubAnimationView:(UIViewController *)vc{
    
    [[MBPAlertView sharedMBPTextView]loadingWaitHUDView:vc.view];

}
-(void)removeWaitHubAnimationView{
    [[MBPAlertView sharedMBPTextView]removeWaitHUDView];
}

- (void)presentLogin:(UIViewController *)vc
{
    @try{
        if ([FXD_Utility sharedUtility].loginFlage) {
            LoginViewModel * loginVM = [[LoginViewModel alloc]init];
            [loginVM deleteUserRegisterID];
            [FXD_Utility EmptyData];
        }
        
//        dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0/*延迟执行时间*/ * NSEC_PER_SEC));
//        dispatch_after(delayTime, dispatch_get_main_queue(), ^{
//            [vc.navigationController popToRootViewControllerAnimated:YES];
//        });
        
        loginAndRegisterModules *myMessageVC=[[loginAndRegisterModules alloc]init];
        BaseNavigationViewController *nav = [[BaseNavigationViewController alloc]initWithRootViewController:myMessageVC];
        [vc presentViewController:nav animated:true completion:nil];
    }@catch (NSException *exception) {
        DLog(@"%@",exception);
    }
}

-(void)obtainLoginInfo:(NSDictionary *)dic{
    @try{
        LoginSyncParse * loginSP = [[LoginSyncParse alloc]initWithDictionary:dic error:nil];
        //储存用户标识juid
        [FXD_Tool saveUserDefaul:loginSP.juid Key:Fxd_JUID];
        [FXD_Utility sharedUtility].userInfo.juid = loginSP.juid;
        [FXD_Tool saveUserDefaul:loginSP.invitation_code Key:kInvitationCode];
        //保存登录状态
        [FXD_Utility sharedUtility].loginFlage = 1;
        [FXD_Tool saveUserDefaul:@"1" Key:kLoginFlag];
        //储存用户手机号
        [FXD_Tool saveUserDefaul:loginSP.mobile_phone_ Key:UserName];
        [FXD_Utility sharedUtility].userInfo.userMobilePhone = loginSP.mobile_phone_;
        //获取登录token
        NSString * keyToken = [NSString stringWithFormat:@"%@token",loginSP.juid];
        if ([FXD_Tool dicContainsKey:dic keyValue:keyToken]) {
            [FXD_Tool saveUserDefaul:[dic objectForKey:keyToken] Key:Fxd_Token];
            [FXD_Utility sharedUtility].userInfo.tokenStr = [dic objectForKey:keyToken];
        }
    }@catch (NSException *exception) {
        DLog(@"%@",exception);
    }
}

/*
- (NSString *)noWhiteSpaceString {
    NSString *newString = self;
    //去除掉首尾的空白字符和换行字符
    newString = [newString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    newString = [newString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    newString = [newString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符使用
    newString = [newString stringByReplacingOccurrencesOfString:@" " withString:@""];
    //    可以去掉空格，注意此时生成的strUrl是autorelease属性的，所以不必对strUrl进行release操作！
    return newString;
}
*/
 #pragma mark -- app启动跳转处理
/**
 外部启动app跳转某个页面

 @param viewControllerNameIden 识别符
 */
-(void)pushAppViewController:(NSString *)viewControllerNameIden{
    BaseNavigationViewController * BaseNavigationVC = [self jumpVC];
}

-(BaseNavigationViewController *)jumpVC{
    id currentVC = [[FXD_Tool share] topViewController];
    BaseNavigationViewController * BaseNavigationVC;
    if ([currentVC isKindOfClass:[FXDBaseTabBarVCModule class]]) {
        FXDBaseTabBarVCModule * baseTabVC = currentVC;
        BaseNavigationVC = baseTabVC.selectedViewController;
    }
    return BaseNavigationVC;
}















@end
