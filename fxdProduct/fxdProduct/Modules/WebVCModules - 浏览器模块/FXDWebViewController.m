//
//  FXDWebViewController.m
//  fxdProduct
//
//  Created by dd on 2016/11/25.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "FXDWebViewController.h"
#import <WebKit/WebKit.h>
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDKUI.h>
#import "UserDataAuthenticationListVCModules.h"
#import "RTRootNavigationController.h"
#import "JSAndOCInteraction.h"
@interface FXDWebViewController ()<WKScriptMessageHandler,WKNavigationDelegate,WKUIDelegate>
{
    UIProgressView *progressView;
}
@property (nonatomic, strong)WKWebView *webView;

@end

@implementation FXDWebViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    config.preferences = [[WKPreferences alloc] init];
    config.preferences.javaScriptEnabled = true;
    config.preferences.javaScriptCanOpenWindowsAutomatically = true;
    config.userContentController = [[WKUserContentController alloc] init];
    // 添加JS到HTML中，可以直接在JS中调用添加的JS方法
    //    WKUserScript *script = [[WKUserScript alloc] initWithSource:@"function showAlert() { alert('在载入webview时通过OC注入的JS方法'); }" injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:true];
    //   [config.userContentController addUserScript:script];
    //   window.webkit.messageHandlers.FXDNative.postMessage({body: 'nativeShare'})
    [config.userContentController addScriptMessageHandler:self name:@"jsToNative"];
    _webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:config];
    _webView.navigationDelegate = self;
    _webView.UIDelegate = self;
    _webView.scrollView.contentSize = self.view.bounds.size;
    DLog(@"%@  --- %@",NSStringFromCGRect(_webView.frame),NSStringFromCGSize(_webView.scrollView.contentSize));
    [self.view addSubview:_webView];
    [self createProUI];
    [self addBackItem];
    _webView.scrollView.showsVerticalScrollIndicator = false;
    DLog(@"%@",_urlStr);
    _urlStr = [_urlStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (_isZhima) {
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_urlStr]]];
    }else{
        //h5活动拼装url
        if([_urlStr containsString:@"wxact"]){
            _urlStr = [self assemblyUrl:_urlStr];
        }
//        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[_urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]]]];
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_urlStr]]];

    }

    [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [_webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    [_webView addObserver:self forKeyPath:@"URL" options:NSKeyValueObservingOptionNew context:nil];
    
    
}


/**
 h5活动拼装url
 */
-(NSString *)assemblyUrl:(NSString *)urlStr{
    NSString * SplicingCharacter = @"?";
    if ([urlStr containsString:@"?"]) {
        SplicingCharacter = @"&";
    }
    NSString * juidStr = [FXD_Utility sharedUtility].userInfo.juid == nil ? @"" : [FXD_Utility sharedUtility].userInfo.juid;
    NSString * tokenStr = [FXD_Utility sharedUtility].userInfo.tokenStr == nil ? @"" : [FXD_Utility sharedUtility].userInfo.tokenStr;
    NSString * phoneNumber = [FXD_Utility sharedUtility].userInfo.userMobilePhone == nil ? @"" : [FXD_Utility sharedUtility].userInfo.userMobilePhone;
    NSString * invationCode =  [FXD_Tool getContentWithKey:kInvitationCode];
    NSString * resultStr = [urlStr stringByAppendingFormat:@"%@type=%@&juid=%@&token=%@&mobile_phone_=%@&invitation_code_=%@",SplicingCharacter,@"0",juidStr,tokenStr,phoneNumber,invationCode];
    return resultStr;
    
}

- (void)addBackItem
{
    if (@available(iOS 11.0, *)) {
        UIBarButtonItem *aBarbi = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"return"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(popBack)];
        //initWithTitle:@"消息" style:UIBarButtonItemStyleDone target:self action:@selector(click)];
        self.navigationItem.leftBarButtonItem = aBarbi;
        return;
    }
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    UIImage *img = [[UIImage imageNamed:@"return"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [btn setImage:img forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 0, 45, 44);
    [btn addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    //修改距离,距离边缘的
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width = -15;
    self.navigationItem.leftBarButtonItems = @[spaceItem,item];
    self.navigationController.interactivePopGestureRecognizer.delegate=(id)self;
}

- (void)popBack
{
    if ([_webView canGoBack]) {
        [_webView goBack];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if (object == _webView && [keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        if (newprogress == 1) {
            progressView.hidden = YES;
            [progressView setProgress:0 animated:NO];
        }else {
            progressView.hidden = NO;
            [progressView setProgress:newprogress animated:YES];
        }
    }
    
    if (object == _webView && [keyPath isEqualToString:@"title"]) {
        //        NSString *title = [[change objectForKey:NSKeyValueChangeNewKey] stringValue];
        NSString *title = _webView.title;
        if (title) {
            self.navigationItem.title = title;
        }
    }
    
    if (object == _webView && [keyPath isEqualToString:@"URL"]) {
        DLog(@"%@",_webView.URL.absoluteString);
    }
}

-(void)createProUI
{
    CGFloat progressBarHeight = 0.7f;
    CGRect navigationBarBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0, navigationBarBounds.size.height - progressBarHeight, navigationBarBounds.size.width, progressBarHeight);
    progressView=[[UIProgressView alloc] initWithFrame:barFrame];
    progressView.tintColor=RGBColor(49, 152, 199, 1);
    progressView.trackTintColor=[UIColor whiteColor];
    [self.navigationController.navigationBar addSubview:progressView];
}

#pragma mark -WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    if ([message.name isEqualToString:@"jsToNative"]) {
        NSDictionary *dic = message.body;
        DLog(@"%@",dic);
        //JS交互点击返回事件
        if ([[dic objectForKey:@"functionName"] isEqualToString:@"mxBack"]) {
            [self.navigationController popViewControllerAnimated:YES];
        }
        //JS交互分享事件  FXDShare
        /*
        {
            "FXDShare" : {
                "shareContent" : "djeiojgffejfoewk",
                "shareUrl" : "djeiojgffejfoewk"
                "shareTitle" : "djeiojgffejfoewk"
                "shareImage" : "djeiojgffejfoewk"
            }
        }
         */
        if ([[dic allKeys] containsObject:@"FXDShare"]) {
            NSDictionary * resultDic = dic[@"FXDShare"];
            NSString * shareContent =  resultDic[@"shareContent"];
            NSString * shareUrl =  resultDic[@"shareUrl"];
            NSString * shareTitle =  resultDic[@"shareTitle"];
            NSString * shareImage =  resultDic[@"shareImage"];
            [[JSAndOCInteraction sharedInteraction] shareContent:self shareContent:shareContent UrlStr:shareUrl shareTitle:shareTitle shareImage:shareImage];
        }
        //JS交互前往某个页面  FXDClipboardOfCopy
        /*
        {
            "FXDClipboardOfCopy" : {
                "copyContent" : "djeiojgffejfoewk",
            }
        }
         */
        if ([[dic allKeys] containsObject:@"FXDClipboardOfCopy"]) {
            NSDictionary * resultDic = dic[@"FXDClipboardOfCopy"];
            NSString * copyContent =  resultDic[@"copyContent"];
            [[JSAndOCInteraction sharedInteraction] ClipboardOfCopy:copyContent VC:self prompt:@"复制成功"];
        }
        
        //JS交互复制内容到剪贴板  FXDPushVC
        /*
        {
            "FXDPushVC" : {
                "viewControllerName" : "djeiojgffejfoewk",
            }
        }
         */
        if ([[dic allKeys] containsObject:@"FXDPushVC"]) {
            NSDictionary * resultDic = dic[@"FXDPushVC"];
            NSString * viewControllerName =  resultDic[@"viewControllerName"];
            [[JSAndOCInteraction sharedInteraction] pushViewController:viewControllerName VC:self];
        }
        
        //JS交互保存图片到本地  FXDSaveImage
        /*
        {
            "FXDSaveImage" : {
                "saveImageUrl" : "djeiojgffejfoewk",
            }
        }
         */
        if ([[dic allKeys] containsObject:@"FXDSaveImage"]) {
            NSDictionary * resultDic = dic[@"FXDSaveImage"];
            NSString * saveImageUrl =  resultDic[@"saveImageUrl"];
            [[JSAndOCInteraction sharedInteraction] savePictureToAlbum:saveImageUrl VC:self];
        }
        //JS交互等待条  FXDWaitHubView
        /*
         {
             "FXDWaitHubView" : {
                "ShowOrRemove" : "Show",  \  "ShowOrRemove" : "Remove",
             }
         }
         */
        if ([[dic allKeys] containsObject:@"FXDWaitHubView"]) {
            NSDictionary * resultDic = dic[@"FXDWaitHubView"];
            if ([[resultDic objectForKey:@"ShowOrRemove"] isEqualToString:@"Show"]) {
                [[JSAndOCInteraction sharedInteraction] waitHubAnimationView:self];
            }
            if ([[resultDic objectForKey:@"ShowOrRemove"] isEqualToString:@"Remove"]) {
                [[JSAndOCInteraction sharedInteraction] removeWaitHubAnimationView];
            }
        }
    }
}

/**
 h5交互结果返回处理
 */
-(void)payOverpopBack{
    
    for (UIViewController* vc in self.rt_navigationController.rt_viewControllers) {
        if ([vc isKindOfClass:[LoanMoneyViewController class]]) {
            LoanMoneyViewController *  loanMoneyVC  =(LoanMoneyViewController *) vc;
            if ([self.acceptType isEqualToString:@"1"]) {
                loanMoneyVC.applicationStatus = Repayment;
            }else if ([self.acceptType isEqualToString:@"2"]){
                loanMoneyVC.applicationStatus = Staging;
            }
            [self.navigationController popToViewController:loanMoneyVC animated:YES];
        }
    }
}

#pragma mark -WKNavigationDelegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    NSURLRequest *request = navigationAction.request;
    
    NSLog(@"=========%@",request.URL.absoluteString);
    WKNavigationActionPolicy policy = WKNavigationActionPolicyAllow;
    /* 判断itunes的host链接 */
    if([[request.URL host] isEqualToString:@"itunes.apple.com"] &&
       [[UIApplication sharedApplication] openURL:navigationAction.request.URL]){
        policy = WKNavigationActionPolicyCancel;
    }
    if ([request.URL.absoluteString hasSuffix:@"main.html"]) {
        policy = WKNavigationActionPolicyCancel;
    }
    decisionHandler(policy);
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    self.navigationItem.title = @"加载中...";
    if([webView.URL.absoluteString containsString:[NSString stringWithFormat:@"%@%@",_main_url,_zhimaCreditCallBack_url]]){
        for (UIViewController* vc in self.rt_navigationController.rt_viewControllers) {
            if ([vc isKindOfClass:[UserDataAuthenticationListVCModules class]]) {
                [self.navigationController popToViewController:vc animated:YES];
            }
        }
    }
}
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error
{
    self.navigationItem.title = @"加载失败";
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    
//    NSString * paramStr = [[JSAndOCInteraction sharedInteraction] obtainLoginInfo];
    //调用js发送平台
    if([webView.URL.absoluteString containsString:@"fxd-pay-fe"]){
//        NSString *inputValueJS = [NSString stringWithFormat:@"window.FXDNAVIGATOR.platformFn('0',%@)",paramStr];
        NSString *inputValueJS = [NSString stringWithFormat:@"window.FXDNAVIGATOR.platformFn('0')"];
        DLog(@"%@",inputValueJS);
        //执行JS
        [webView evaluateJavaScript:inputValueJS completionHandler:^(id _Nullable response, NSError * _Nullable error) {
            DLog(@"value: %@ error: %@", response, error);
        }];
    }
    
    
}

#pragma mark -
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
    DLog(@"alert");
//    [[MBPAlertView sharedMBPTextView]showTextOnly:[UIApplication sharedApplication].keyWindow message:message];
    completionHandler();
}
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler
{
    DLog(@"confim");
    completionHandler(true);
}
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable result))completionHandler
{
    DLog(@"inputPanel");
    completionHandler(@"");
}
-(void)dealloc
{
    [_webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [_webView removeObserver:self forKeyPath:@"title"];
    [_webView removeObserver:self forKeyPath:@"URL"];
    [_webView.configuration.userContentController removeScriptMessageHandlerForName:@"FXDNative"];
    _webView.navigationDelegate = nil;
    _webView.UIDelegate = nil;
    _webView = nil;
}

- (void)showMessage:(NSString *)msg vc:(UIViewController *)vc
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:true];
    }];
    [alertController addAction:action];
    [vc presentViewController:alertController animated:true completion:nil];
}

- (void)deleteWebCache {
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0) {
        
        NSSet *websiteDataTypes
        
        = [NSSet setWithArray:@[
                                
                                WKWebsiteDataTypeDiskCache,
                                
                                //WKWebsiteDataTypeOfflineWebApplicationCache,
                                
                                WKWebsiteDataTypeMemoryCache,
                                
                                //WKWebsiteDataTypeLocalStorage,
                                
                                //WKWebsiteDataTypeCookies,
                                
                                //WKWebsiteDataTypeSessionStorage,
                                
                                //WKWebsiteDataTypeIndexedDBDatabases,
                                
                                //WKWebsiteDataTypeWebSQLDatabases
                                
                                ]];
        
        //// All kinds of data
        
        //NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
        
        //// Date from
        
        NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
        
        //// Execute
        
        [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
            
            // Done
            
        }];
        
    } else {
        
        NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *cookiesFolderPath = [libraryPath stringByAppendingString:@"/Cookies"];
        NSError *errors;
        [[NSFileManager defaultManager] removeItemAtPath:cookiesFolderPath error:&errors];
        
    }
}

-(void)viewDidAppear:(BOOL)animated{
    [self deleteWebCache];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [progressView removeFromSuperview];
    [self deleteWebCache];
    [[JSAndOCInteraction sharedInteraction] removeWaitHubAnimationView];
}



-(WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures{
    
    if (!navigationAction.targetFrame.isMainFrame) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
