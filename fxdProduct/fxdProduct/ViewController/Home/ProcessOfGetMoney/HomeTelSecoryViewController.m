//
//  HomeTelSecoryViewController.m
//  fxdProduct
//
//  Created by zhangbaochuan on 15/11/2.
//  Copyright © 2015年 dd. All rights reserved.
//

#import "HomeTelSecoryViewController.h"

@interface HomeTelSecoryViewController ()
{
    UILabel *_label;
}
@end

@implementation HomeTelSecoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self addBackItem];
    [self createUI];
    self.automaticallyAdjustsScrollViewInsets= NO;
}

//UI
-(void)createUI{
    self.title=@"如何获取手机服务密码";    
    NSString *stringHtml=@"<p>一：中国移动用户请拨打移动热线10086，或通过中国移动网上营业厅<a href='https://sh.ac.10086.cn/login'>https://sh.ac.10086.cn/login</a> ，找回密码功能找回服务密码。<br>二：中国联动用户请拨打联通热线10010，或者通过中国联通网上营业厅<a href='https://uac.10010.com/'>https://uac.10010.com/</a>，忘记密码功能找回服务密码。<br>三：中国电信用户请拨打电信热线10000，或者通过中国电信网上营业厅<a href='http://login.189.cn/login'>http://login.189.cn/login</a>，忘记密码功能找回服务密码。</p>";
    
    UIWebView *webView=[[UIWebView alloc] initWithFrame:CGRectMake(0, 64, _k_w, _k_h-64)];
    [webView loadHTMLString:stringHtml baseURL:nil];
    webView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:webView];
    
}

//隐藏tabbar
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

@end
