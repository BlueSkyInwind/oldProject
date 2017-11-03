//
//  P2PViewController.m
//  fxdProduct
//
//  Created by dd on 2016/9/27.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "P2PViewController.h"
#import <WebKit/WebKit.h>
#import "GetCaseInfo.h"
#import "DrawService.h"
#import "LoanMoneyViewController.h"
#import "RTRootNavigationController.h"
#import "WithdrawalsVCModule.h"
#import "AccountHSServiceModel.h"
#import "QryUserStatusModel.h"
#import "getBidStatus.h"
#import "RepayDetailViewController.h"
#import "CheckViewModel.h"
#import "RepayRequestManage.h"
@interface P2PViewController ()<WKUIDelegate,WKNavigationDelegate>
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
//    [self addBackItem];
    
//    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
//    config.preferences = [[WKPreferences alloc] init];
//    config.preferences.javaScriptEnabled = true;
//    config.preferences.javaScriptCanOpenWindowsAutomatically = true;
//    config.userContentController = [[WKUserContentController alloc] init];
//    WKUserScript *script = [[WKUserScript alloc] initWithSource:@"function iosMethod() { alert('在载入webview时通过OC注入的JS方法'); }" injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:true];
//    [config.userContentController addUserScript:script];
//    [config.userContentController addScriptMessageHandler:self name:@"AppModel"];
    
    _webview = [[WKWebView alloc] init];
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
    
    [_webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_urlStr]]];
    [_webview addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [_webview addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    [_webview addObserver:self forKeyPath:@"URL" options:NSKeyValueObservingOptionNew context:nil];
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
    [self getUserStatus:self.applicationId];
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
    
    if ([request.URL.absoluteString isEqualToString:_transition_url]&&![request.URL.absoluteString isEqualToString:self.urlStr]) {
        decisionHandler(WKNavigationActionPolicyAllow);
        [self getUserStatus:self.applicationId];
    }else {
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    
    

}
#pragma mark  fxd用户状态查询，viewmodel
-(void)getUserStatus:(NSString *)applicationId{
    
    ComplianceViewModel *complianceViewModel = [[ComplianceViewModel alloc]init];
    [complianceViewModel setBlockWithReturnBlock:^(id returnValue) {
        QryUserStatusModel *qryUserStatusModel = [QryUserStatusModel yy_modelWithJSON:returnValue];
        if ([qryUserStatusModel.flag isEqualToString:@"0000"]) {
            
            if ([qryUserStatusModel.result.flg isEqualToString:@"2"]) {//未开户
                for (UIViewController* vc in self.rt_navigationController.rt_viewControllers) {
                    if ([vc isKindOfClass:[WithdrawalsVCModule class]]) {
                        WithdrawalsVCModule *controller = (WithdrawalsVCModule *)vc;
                        [self.navigationController popToViewController:controller animated:YES];
                    }
                }
            }else{
                if ([qryUserStatusModel.result.flg isEqualToString:@"6"]&&_isRepay) {//正常用户并且从我要还款入口进入
                    RepayRequestManage *repayRequest = [[RepayRequestManage alloc] init];
                    repayRequest.targetVC = self;
                    repayRequest.isPopRoot = YES;
                    [repayRequest repayRequest];
                }else{
                    LoanMoneyViewController *controller;
                    BOOL isHave = NO;
                    for (UIViewController* vc in self.rt_navigationController.rt_viewControllers) {
                        if ([vc isKindOfClass:[LoanMoneyViewController class]]) {
                            isHave = YES;
                            controller = (LoanMoneyViewController *)vc;
//                            controller.qryUserStatusModel = qryUserStatusModel;
                            controller.applicationStatus = ComplianceRepayment;
                        }
                    }
                    if (isHave) {
                        [self.navigationController popToViewController:controller animated:YES];
                    }else{
                        LoanMoneyViewController *controller = [LoanMoneyViewController new];
//                        controller.qryUserStatusModel = qryUserStatusModel;
                        controller.applicationStatus = ComplianceInLoan;
                        [self.navigationController pushViewController:controller animated:YES];
                    }
                }
            }
        }else{
            [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:qryUserStatusModel.msg];
        }
    } WithFaileBlock:^{
    }];
    [complianceViewModel getUserStatus:applicationId];
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
