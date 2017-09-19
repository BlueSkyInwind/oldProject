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
    if (urlStr != nil) {
        imageArr = @[imageUrl];
    }
    
    NSString * titleName  =  title == nil ? @"发薪贷" : title;
    
    if (![Utility sharedUtility].loginFlage) {
        [self presentLogin:viewC];
        return;
    }
    
    NSString * invationCode =  [Tool getContentWithKey:kInvitationCode];
    NSString * targetUrl = [urlStr stringByAppendingFormat:@"?merchant_code_=%@",invationCode];
    
    if (imageArr) {
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:content
                                         images:imageArr
                                            url:[NSURL URLWithString:targetUrl]
                                          title:titleName
                                           type:SSDKContentTypeAuto];
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
-(void)pushViewController:(NSString *)viewControllerName VC:(UIViewController *)currentVC{
    
    if ([viewControllerName isEqualToString:@"UserEvaluate"]) {
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/id1089086853"]];
        return;
    }
    
    if ([viewControllerName isEqualToString:@"ServiceHotline"]) {
        [self ServiceHotline:currentVC];
        return;
    }
    
    if (![Utility sharedUtility].loginFlage) {
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
        
        [[SDWebImageManager sharedManager] loadImageWithURL:[NSURL URLWithString:src] options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
            NSLog(@"%ld",cacheType);
            if (data) {
                UIImage *image = [UIImage imageWithData:data];
                UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
            }else{
                [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:@"保存失败"];
            }
        }];
    }]];
    [currentVC presentViewController:alert animated:YES completion:nil];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (error != NULL){
        [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:@"保存失败"];
    }else{
        [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:@"保存成功"];
    }
}

- (void)presentLogin:(UIViewController *)vc
{
    LoginViewController *loginVC = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
    BaseNavigationViewController *nav = [[BaseNavigationViewController alloc]initWithRootViewController:loginVC];
    [vc presentViewController:nav animated:YES completion:nil];
}








@end
