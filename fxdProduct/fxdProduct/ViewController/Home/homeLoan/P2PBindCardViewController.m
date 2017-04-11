//
//  P2PBindCardViewController.m
//  fxdProduct
//
//  Created by dd on 2016/9/29.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "P2PBindCardViewController.h"
#import <WebKit/WebKit.h>
#import "DrawService.h"
#import "GetCaseInfo.h"

@interface P2PBindCardViewController ()<WKUIDelegate,WKNavigationDelegate>
{
    UIProgressView *progressView;
}

@property (nonatomic, strong) WKWebView *webview;
@end

@implementation P2PBindCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self addLeftItem];
    
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
    NSString *url = [NSString stringWithFormat:@"%@%@?from_user_id_=%@&from_mobile_=%@&PageType=1&isSubmit=1",_P2P_url,_bindCard_url,[Utility sharedUtility].userInfo.account_id,[Utility sharedUtility].userInfo.userMobilePhone];
    NSString *urlStr = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [_webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
    
    //    [_webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_urlStr]]];
    [_webview addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [_webview addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    [_webview addObserver:self forKeyPath:@"URL" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)addLeftItem
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    
    UIImage *img = [[UIImage imageNamed:@"return"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [btn setImage:img forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 0, 45, 44);
    [btn addTarget:self action:@selector(backUp) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    
    //    修改距离,距离边缘的
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width = -15;
    
    self.navigationItem.leftBarButtonItems = @[spaceItem,item];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [progressView removeFromSuperview];
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

- (void)backUp
{
    //    if (_webview.canGoBack) {
    //        [_webview goBack];
    //    } else {
    //        [self checkP2PState];
    //    }
    [self checkP2PState];
}

- (void)checkP2PState
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
        if ([drawServiceParse.data.flg isEqualToString:@"3"])
        {
            [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:drawServiceParse.appmsg];
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

//绑卡：招商银行 622580
- (void)addBildInfo:(GetCaseInfo *)caseInfo
{
    NSDictionary *paramDic = @{@"product_id_":caseInfo.result.product_id_,
                               @"auditor_":caseInfo.result.auditor_,
                               @"desc_":caseInfo.result.desc_,
                               @"amount_":caseInfo.result.amount_,
                               @"period_":_userSelectNum,
                               @"title_":caseInfo.result.title_,
                               @"from_":caseInfo.result.from_,
                               @"client_":caseInfo.result.client_,
                               @"start_date_":caseInfo.result.start_date_,
                               @"from_case_id_":caseInfo.result.from_case_id_,
                               @"user_id_":caseInfo.result.user_id_,
                               @"description_":caseInfo.result.description_,
                               @"invest_days_":caseInfo.result.invest_days_};
    NSString *url = [NSString stringWithFormat:@"%@%@&from_user_id_=%@&from_mobile_=%@",_P2P_url,_addBidInfo_url,[Utility sharedUtility].userInfo.account_id,[Utility sharedUtility].userInfo.userMobilePhone];
    [[FXDNetWorkManager sharedNetWorkManager] P2POSTWithURL:url parameters:paramDic finished:^(EnumServerStatus status, id object) {
        DrawService *model = [DrawService yy_modelWithJSON:object];
        if ([model.appcode isEqualToString:@"1"]) {
//            [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:@"发标成功"];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        if ([model.appcode isEqualToString:@"-1"]) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:model.appmsg];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        if ([[object objectForKey:@"flag"] isEqualToString:@"0000"]) {
//            [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:@"发标成功"];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        
    } failure:^(EnumServerStatus status, id object) {
        
    }];
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
