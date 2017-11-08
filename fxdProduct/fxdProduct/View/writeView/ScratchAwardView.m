//
//  ScratchAwardView.m
//  fxdProduct
//
//  Created by sxp on 2017/11/8.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "ScratchAwardView.h"
#import <WebKit/WebKit.h>

@interface ScratchAwardView ()<WKScriptMessageHandler,WKNavigationDelegate,WKUIDelegate>

{
    UIProgressView *progressView;
}
@property (nonatomic, strong)WKWebView *webView;

@end
@implementation ScratchAwardView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self configureView];
        
    }
    return self;
}

-(void)configureView{
    
    _webView = [[WKWebView alloc]init];
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    
    [self addSubview:_webView];
    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.bottom.equalTo(self);
        
    }];
    [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [_webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    [_webView addObserver:self forKeyPath:@"URL" options:NSKeyValueObservingOptionNew context:nil];
    
    [self createProUI];
}

-(void)createProUI
{
    CGFloat progressBarHeight = 0.7f;
//    CGRect navigationBarBounds = self.bounds;
//    CGRect navigationBarBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0, 30, _k_w, progressBarHeight);
    progressView=[[UIProgressView alloc] initWithFrame:barFrame];
//    progressView.tintColor = [UIColor redColor];
    progressView.tintColor=RGBColor(49, 152, 199, 1);
    progressView.trackTintColor=[UIColor whiteColor];
    [_webView addSubview:progressView];
//    [self.navigationController.navigationBar addSubview:progressView];
}

-(void)loadData{
    
//    self.linkUrl = @"https://www.baidu.com";
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.linkUrl]]];
}
#pragma mark -WKNavigationDelegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    NSURLRequest *request = navigationAction.request;
    NSLog(@"=========%@",request.URL.absoluteString);
//    WKNavigationActionPolicy policy = WKNavigationActionPolicyAllow;
//    /* 判断itunes的host链接 */
//    if([[request.URL host] isEqualToString:@"itunes.apple.com"] &&
//       [[UIApplication sharedApplication] openURL:navigationAction.request.URL]){
//        policy = WKNavigationActionPolicyCancel;
//    }
//    if ([request.URL.absoluteString hasSuffix:@"main.html"]) {
//        policy = WKNavigationActionPolicyCancel;
//    }
    decisionHandler(WKNavigationActionPolicyAllow);
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
//            self.navigationItem.title = title;
        }
    }
    
    if (object == _webView && [keyPath isEqualToString:@"URL"]) {
        DLog(@"%@",_webView.URL.absoluteString);
    }
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

+ (instancetype)defaultPopView
{
   
    return [[ScratchAwardView alloc]initWithFrame:CGRectMake(0, 0, _k_w, _k_h)];
    
}

@end
