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
#import "P2PBindCardViewController.h"

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
    [self addBackItem];
    
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

//- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
//{
//    if ([message.name isEqualToString:@"AppModel"]) {
//        NSLog(@"message name is AppModel");
//    }
//}

//根据webView、navigationAction相关信息决定这次跳转是否可以继续进行,这些信息包含HTTP发送请求，如头部包含User-Agent,Accept
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    NSURLRequest *request = navigationAction.request;
    DLog(@"%@",request.URL.absoluteString);
    if ([request.URL.absoluteString isEqualToString:_transition_url]) {
        decisionHandler(WKNavigationActionPolicyAllow);
        [self checkP2PUserState];
    }else {
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}

- (void)checkP2PUserState
{
    NSDictionary *paramDic = @{@"user_info":[Tool objextToJSON:[[_uploadP2PUserInfo objectForKey:@"result"] objectForKey:@"user_info"]],
                               @"user_contacter":[Tool objextToJSON:[[_uploadP2PUserInfo objectForKey:@"result"] objectForKey:@"user_contacter"]],
                               @"mobile_":[[_uploadP2PUserInfo objectForKey:@"result"] objectForKey:@"mobile_"],
                               @"id_number_":[Utility sharedUtility].userInfo.userIDNumber};
    NSString *url = [NSString stringWithFormat:@"%@%@&from_user_id_=%@&from_mobile_=%@",_P2P_url,_drawService_url,[Utility sharedUtility].userInfo.account_id,[Utility sharedUtility].userInfo.userMobilePhone];
    [[FXDNetWorkManager sharedNetWorkManager] P2POSTWithURL:url parameters:paramDic finished:^(EnumServerStatus status, id object) {
        DLog(@"%@",object);
        DrawService *drawServiceParse = [DrawService yy_modelWithJSON:object];
        //                        drawServiceParse.data.flg = @"4";
        //开户
        if ([drawServiceParse.data.flg isEqualToString:@"2"]) {
//            NSString *url = [NSString stringWithFormat:@"%@%@?from_user_id_=%@&from_mobile_=%@&id_number_=%@&user_name_=%@&PageType=1&RetUrl=%@",_P2P_url,_register_url,[Utility sharedUtility].userInfo.account_id,[Utility sharedUtility].userInfo.userMobilePhone,[Utility sharedUtility].userInfo.userIDNumber,[Utility sharedUtility].userInfo.realName,_transition_url];
//            self.urlStr = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
//            [_webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_urlStr]]];
//            [_webview reload];
            [self.navigationController popViewControllerAnimated:YES];
        }
        //绑卡
        if ([drawServiceParse.data.flg isEqualToString:@"3"]) {
            P2PBindCardViewController *p2pBindCardVC = [[P2PBindCardViewController alloc] init];
            p2pBindCardVC.uploadP2PUserInfo = _uploadP2PUserInfo;
            p2pBindCardVC.userSelectNum = _userSelectNum;
            [self.navigationController pushViewController:p2pBindCardVC animated:YES];
        }
        //发标
        if ([drawServiceParse.data.flg isEqualToString:@"4"]) {
            [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_ValidESB_url,_getFXDCaseInfo_url] parameters:nil finished:^(EnumServerStatus status, id object) {
                DLog(@"%@",object);
                GetCaseInfo *caseInfo = [GetCaseInfo yy_modelWithJSON:object];
                if ([caseInfo.flag isEqualToString:@"0000"]) {
                    [self addBildInfo:caseInfo];
                } else {
                    
                }
                
            } failure:^(EnumServerStatus status, id object) {
                
            }];
        }
    } failure:^(EnumServerStatus status, id object) {
        
    }];
}

- (void)addBildInfo:(GetCaseInfo *)caseInfo
{
    NSDictionary *paramDic = @{@"product_id_":caseInfo.result.product_id_,
                               @"auditor_":caseInfo.result.auditor_,
                               @"desc_":caseInfo.result.desc_,
                               @"amount_":caseInfo.result.amount_,
                               @"period_":_userSelectNum,
                               @"loan_for_":_purposeSelect,
                               @"title_":caseInfo.result.title_};
    NSString *url = [NSString stringWithFormat:@"%@%@&from_user_id_=%@&from_mobile_=%@",_P2P_url,_addBidInfo_url,[Utility sharedUtility].userInfo.account_id,[Utility sharedUtility].userInfo.userMobilePhone];
    [[FXDNetWorkManager sharedNetWorkManager] P2POSTWithURL:url parameters:paramDic finished:^(EnumServerStatus status, id object) {
        if ([[object objectForKey:@"flag"] isEqualToString:@"0000"]) {
//            [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:@"发标成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(EnumServerStatus status, id object) {
        
    }];
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
