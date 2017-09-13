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
#import "UserDataViewController.h"
#import "RTRootNavigationController.h"
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
    
    DLog(@"%@",NSStringFromCGRect(self.view.frame));
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    config.preferences = [[WKPreferences alloc] init];
    config.preferences.javaScriptEnabled = true;
    config.preferences.javaScriptCanOpenWindowsAutomatically = true;
    config.userContentController = [[WKUserContentController alloc] init];
    // 添加JS到HTML中，可以直接在JS中调用添加的JS方法
    //    WKUserScript *script = [[WKUserScript alloc] initWithSource:@"function showAlert() { alert('在载入webview时通过OC注入的JS方法'); }" injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:true];
    //    [config.userContentController addUserScript:script];
//     window.webkit.messageHandlers.FXDNative.postMessage({body: 'nativeShare'})
    [config.userContentController addScriptMessageHandler:self name:@"jsToNative"];
    _webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:config];
    _webView.navigationDelegate = self;
    _webView.UIDelegate = self;
    _webView.scrollView.contentSize = self.view.bounds.size;
    DLog(@"%@  --- %@",NSStringFromCGRect(_webView.frame),NSStringFromCGSize(_webView.scrollView.contentSize));
    
    [self.view addSubview:_webView];
    [self createProUI];
    [self addBackItem];
    
    NSLog(@"%@",_urlStr);
    _webView.scrollView.showsVerticalScrollIndicator = false;
    if (_isZhima) {
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_urlStr]]];
    }else{
        // NSString * str = @"https://fintech.chinazyjr.com/p2p/http/huifush/toBosAcctActivate.jhtml?page_type_=1&ret_url_=https://h5.faxindai.com:8028/fxd-h5/page/case/app_transition.html&from_mobile_=15241892226";
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[self.urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]]]];
    }
    
    [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [_webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    [_webView addObserver:self forKeyPath:@"URL" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)addBackItem
{
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
        DLog(@"%@",[message.body class]);
        NSDictionary *dic = message.body;
        //JS交互点击事件
        if ([[dic objectForKey:@"functionName"] isEqualToString:@"mxBack"]) {
            [self.navigationController popViewControllerAnimated:YES];
        }
        //三方支付点击结果反馈   1、还款中 2、还款成功 3、还款失败  4、第三方未受理
        if ([[dic allKeys] containsObject:@"payData"]) {
            NSDictionary * resultDic = dic[@"payData"];
            NSString * str =  resultDic[@"status"];
            if ([str isEqualToString:@"2"]) {
                [self payOverpopBack];
            }
        }
    }
}

/**
 三方支付结果，返回处理
 */
-(void)payOverpopBack{
    
    for (UIViewController* vc in self.rt_navigationController.rt_viewControllers) {
        if ([vc isKindOfClass:[LoanMoneyViewController class]]) {
            LoanMoneyViewController *  loanMoneyVC  =(LoanMoneyViewController *) vc;
            if ([self.payType isEqualToString:@"1"]) {
                loanMoneyVC.applicationStatus = Repayment;
            }else if ([self.payType isEqualToString:@"2"]){
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
    //打开支付宝
    if ([request.URL.absoluteString hasPrefix:@"alipays"]) {
        if ([Tool getIOSVersion] < 10) {
            if ([[UIApplication sharedApplication] canOpenURL:request.URL]) {
                [[UIApplication sharedApplication] openURL:request.URL ];
            }
            else{
                [self showMessage:@"打开支付宝失败！" vc:self];
            }
        }
        else {
            [[UIApplication sharedApplication] openURL:request.URL options:@{} completionHandler:^(BOOL success) {
                if (!success) {
                    [self showMessage:@"打开支付宝失败！" vc:self];
                }
            }];
        }
           decisionHandler(WKNavigationActionPolicyAllow);
    }
    
    if ([request.URL.absoluteString hasSuffix:@"main.html"]) {
        decisionHandler(WKNavigationActionPolicyCancel);
//        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    self.navigationItem.title = @"加载中...";
    if([webView.URL.absoluteString containsString:[NSString stringWithFormat:@"%@%@",_main_url,_zhimaCreditCallBack_url]]){
        for (UIViewController* vc in self.rt_navigationController.rt_viewControllers) {
            if ([vc isKindOfClass:[UserDataViewController class]]) {
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
    
//    NSString *inputValueJS = @"document.getElementsByName('click_a')[0].onclick";
//    NSLog(@"%@",inputValueJS);
//    //执行JS
//    [webView evaluateJavaScript:inputValueJS completionHandler:^(id _Nullable response, NSError * _Nullable error) {
//        NSLog(@"value: %@ error: %@", response, error);
//    }];
    
}

#pragma mark -
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
    DLog(@"alert");
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
-(void)shareContent:(UIView *)view
{
    NSArray *imageArr = @[[UIImage imageNamed:@"logo_60"]];
    if (imageArr) {
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:_shareContent
                                         images:imageArr
                                            url:[NSURL URLWithString:_urlStr]
                                          title:@"发薪贷"
                                           type:SSDKContentTypeAuto];
        [shareParams SSDKEnableUseClientShare];
        [ShareSDK showShareActionSheet:nil
                                 items:nil
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       switch (state) {
                           case SSDKResponseStateSuccess:
                               [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"分享成功"];
                               break;
                               
                           case SSDKResponseStateFail:
                               [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"分享失败"];
                           default:
                               break;
                       }
                   }];
    }
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
