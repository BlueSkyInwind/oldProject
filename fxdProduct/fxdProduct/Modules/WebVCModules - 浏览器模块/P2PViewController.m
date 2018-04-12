//
//  P2PViewController.m
//  fxdProduct
//
//  Created by dd on 2016/9/27.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "P2PViewController.h"
#import <WebKit/WebKit.h>

@interface P2PViewController ()<WKScriptMessageHandler,WKUIDelegate,WKNavigationDelegate>
{
    UIProgressView *progressView;
}

@property (nonatomic, strong) WKWebView *webview;

@end

@implementation P2PViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self addBack];
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    config.preferences = [[WKPreferences alloc] init];
    config.preferences.javaScriptEnabled = true;
    config.preferences.javaScriptCanOpenWindowsAutomatically = true;
    config.userContentController = [[WKUserContentController alloc] init];

    [config.userContentController addScriptMessageHandler:self name:@"jsToNative"];
    _webview = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:config];
    
    _webview.UIDelegate = self;
    _webview.navigationDelegate = self;
    
    [self.view addSubview:_webview];
    [_webview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
    
    [self createProUI];

    [_webview loadHTMLString:_jsContent baseURL:nil];
    [_webview addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [_webview addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    [_webview addObserver:self forKeyPath:@"URL" options:NSKeyValueObservingOptionNew context:nil];
}


/**
 h5活动拼装url
 */
-(NSString *)assemblyUrl:(NSString *)urlStr{
    NSString * SplicingCharacter = @"?";
    if ([urlStr containsString:@"?"]) {
        SplicingCharacter = @"&";
    }

    NSString * resultStr = [urlStr stringByAppendingFormat:@"%@type=%@",SplicingCharacter,@"0"];
    return resultStr;
    
}

- (void)addBack
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
    //    修改距离,距离边缘的
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width = -15;
    self.navigationItem.leftBarButtonItems = @[spaceItem,item];
    //    self.navigationController.interactivePopGestureRecognizer.delegate=(id)self;
}

- (void)popBack
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    [self.navigationController popToRootViewControllerAnimated:true];

}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if (object == _webview && [keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        if (newprogress == 1) {
            progressView.hidden = YES;
            [progressView setProgress:0 animated:NO];
        }else {
            progressView.hidden = NO;
            [progressView setProgress:newprogress animated:YES];
        }
    }
    
    if (object == _webview && [keyPath isEqualToString:@"title"]) {
//        NSString *title = [[change objectForKey:NSKeyValueChangeNewKey] stringValue];
        NSString *title = _webview.title;
        if (title) {
            self.navigationItem.title = title;
        }
        DLog(@"%@",title);
    }
    if (object == _webview && [keyPath isEqualToString:@"URL"]) {
        DLog(@"%@",_webview.URL.absoluteString);
    }
}

-(void)createProUI
{
    CGFloat progressBarHeight = 1.f;
    CGRect navigationBarBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0, navigationBarBounds.size.height - progressBarHeight, navigationBarBounds.size.width, progressBarHeight);
    progressView=[[UIProgressView alloc] initWithFrame:barFrame];
    progressView.tintColor=RGBColor(49, 152, 199, 1);
    progressView.trackTintColor=[UIColor whiteColor];
    [self.navigationController.navigationBar addSubview:progressView];
//    [self.view addSubview:progressView];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [progressView removeFromSuperview];
}

//根据webView、navigationAction相关信息决定这次跳转是否可以继续进行,这些信息包含HTTP发送请求，如头部包含User-Agent,Accept
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    NSURLRequest *request = navigationAction.request;
    DLog(@"%@",request.URL.absoluteString);
    DLog(@"=======%@",webView.URL.absoluteString);
    
    if ([request.URL.absoluteString hasPrefix:_retUrl]&&![request.URL.absoluteString isEqualToString:self.urlStr]) {
        decisionHandler(WKNavigationActionPolicyAllow);
        
        IntermediateViewController *controller = [[IntermediateViewController alloc]init];
        [self.navigationController pushViewController:controller animated:true];
        
    }else {
        decisionHandler(WKNavigationActionPolicyAllow);
    }
    
//    if([request.URL.absoluteString containsString:@"app_transition"]){
//        if ([request.URL.absoluteString containsString:@"type"]) {
//            decisionHandler(WKNavigationActionPolicyAllow);
//        }else{
//            NSString *str = [NSString stringWithFormat:@"%@",request.URL];
//            NSString *urlStr = [self assemblyUrl:str];
//            NSURL *url = [NSURL URLWithString:urlStr];
//            [_webview loadRequest:[NSURLRequest requestWithURL:url]];
//
//            decisionHandler(WKNavigationActionPolicyCancel);
//        }
//    }else{
//        
//        decisionHandler(WKNavigationActionPolicyAllow);
//    }
    
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    
    
}
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    DLog(@"%@",webView);
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    
    if ([message.name isEqualToString:@"jsToNative"]) {
        NSDictionary *dic = message.body;
        DLog(@"%@",dic);
        //JS交互点击返回事件
        if ([[dic objectForKey:@"functionName"] isEqualToString:@"mxBack"]) {
            [self.navigationController popToRootViewControllerAnimated:true];
        }
    }
}

-(void)dealloc
{
    [_webview removeObserver:self forKeyPath:@"estimatedProgress"];
    [_webview removeObserver:self forKeyPath:@"title"];
    [_webview removeObserver:self forKeyPath:@"URL"];
    _webview.scrollView.delegate=nil;
    _webview.UIDelegate=nil;
    _webview.navigationDelegate=nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
