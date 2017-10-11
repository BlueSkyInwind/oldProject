//
//  FXDWebViewController.m
//  fxdProduct
//
//  Created by dd on 2016/11/25.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "ThirdWebViewController.h"
#import <WebKit/WebKit.h>
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDKUI.h>
#import "UserDataViewController.h"
#import "RTRootNavigationController.h"
#import "JSAndOCInteraction.h"
#import "LoanMoneyViewController.h"
#import "ApplicationViewModel.h"
@interface ThirdWebViewController ()<WKScriptMessageHandler,WKNavigationDelegate,WKUIDelegate,ShanLinBackAlertViewDelegate>
{
    UIProgressView *progressView;
}
@property (nonatomic, strong)WKWebView *webView;

@end

@implementation ThirdWebViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    if (self.name != nil) {
        self.title = self.name;
    }
    
    DLog(@"%@",NSStringFromCGRect(self.view.frame));
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    config.preferences = [[WKPreferences alloc] init];
    config.preferences.javaScriptEnabled = true;
    config.preferences.javaScriptCanOpenWindowsAutomatically = true;
    config.userContentController = [[WKUserContentController alloc] init];

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
    
//    self.loadContent = @"<form id=\"payBillForm\" action=\"https://wap.lianlianpay.com/signApply.htm\" method=\"post\"><input type='hidden' name='req_data' value= '{\"oid_partner\":\"201705161001740332\",\"url_return\":\"http://101.95.101.118:10219/open/bankCard/authSignReturn.htm\",\"risk_item\":\"{\"frms_ware_category\":\"2010\",\"user_info_bind_phone\":\"15622222223\",\"user_info_dt_register\":\"20170926113151\",\"user_info_full_name\":\"段金强\",\"user_info_id_no\":\"410526199004223444\",\"user_info_id_type\":\"0\",\"user_info_identify_state\":\"1\",\"user_info_identify_type\":\"1\",\"user_info_mercht_userno\":\"8effbc4b925a4fc6ad970ec68f7bef6d\"}\",\"sign\":\"AuixktknAAfzor/4tCj0AY0UJL/cdi2qZjYxPtIO9/TfH6GlF1Q0TG84eZU9UZkrmG6zFrLt1bhsEB67O8sszpgIAgGrHa81aIR+6MmDqmfQylY9X1lNcWalEID61XdbEBBQlo0fxvDSBohIwE6ClRx2kRMq3TxnGnvYazDNPFM=\",\"app_request\":\"3\",\"version\":\"1.1\",\"id_no\":\"410526199004223444\",\"card_no\":\"6215581116002010000\",\"user_id\":\"8effbc4b925a4fc6ad970ec68f7bef6d\",\"id_type\":\"0\",\"pay_type\":\"I\",\"acct_name\":\"段金强\",\"sign_type\":\"RSA\"}'/><input type=\"submit\" value=\"请求签约\" style=\"display:none;\"></form><script>document.forms['payBillForm'].submit();</script>";
    if (self.loadContent != nil) {
        [_webView loadHTMLString:self.loadContent baseURL:nil];
    }
    
    if (self.urlStr != nil) {
        
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[self.urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]]]];
    }
    
    [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [_webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    [_webView addObserver:self forKeyPath:@"URL" options:NSKeyValueObservingOptionNew context:nil];
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
        
        [self.navigationController popToRootViewControllerAnimated:true];

    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (_isHidden) {
        self.navigationController.navigationBarHidden = true;
    }else{
        self.navigationController.navigationBarHidden = false;
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = false;
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
    
}

#pragma mark -WKNavigationDelegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    NSURLRequest *request = navigationAction.request;
    NSLog(@"=========%@",request.URL.absoluteString);
    if ([request.URL.absoluteString containsString:[NSString stringWithFormat:@"%@%@",_H5_url,_CapitalLoanBack_url]]&&![request.URL.absoluteString containsString:@"#shanlinBack"]) {
        decisionHandler(WKNavigationActionPolicyAllow);
        [self.navigationController popToRootViewControllerAnimated:true];
        
    }else if([request.URL.absoluteString containsString:[NSString stringWithFormat:@"%@%@",_H5_url,_ShanLinBack_url]]){
        
        decisionHandler(WKNavigationActionPolicyAllow);
        [self setAlert];
    }else{
        
        decisionHandler(WKNavigationActionPolicyAllow);
    }
    
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    self.navigationItem.title = @"加载中...";

}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error
{
    self.navigationItem.title = @"加载失败";
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{

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


-(void)setAlert{
    
    ShanLinBackAlertView *ticket=[[ShanLinBackAlertView alloc]init];
    ticket.backgroundColor = [UIColor blackColor];
    ticket.alpha = 0.8;
    ticket.delegate = self;
    [self.view addSubview:ticket];
    
}

-(void)cancelBtn{
    for (UIView *subView in self.view.subviews) {
        if ([subView isKindOfClass:[ShanLinBackAlertView class]]) {
            [subView removeFromSuperview];
            [self.navigationController popToRootViewControllerAnimated:true];
        }
    }
}

-(void)sureBtn{
   
    __weak typeof (self) weakSelf = self;
    ApplicationViewModel * appModel = [[ApplicationViewModel alloc]init];
    [appModel setBlockWithReturnBlock:^(id returnValue) {
        
        for (UIView *subView in weakSelf.view.subviews) {
            if ([subView isKindOfClass:[ShanLinBackAlertView class]]) {
                [subView removeFromSuperview];
            }
        }
        
    } WithFaileBlock:^{
        
    }];
    [appModel capitalLoanFail];
    
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

