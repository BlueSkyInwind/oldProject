//
//  DetailViewController.m
//  fxdProduct
//
//  Created by dd on 2016/12/2.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "DetailViewController.h"
#import <WebKit/WebKit.h>

@interface DetailViewController ()
@property (nonatomic, strong)WKWebView *webView;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = _navTitle;
    
    _webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    [self addBackItem];
    _webView.scrollView.showsVerticalScrollIndicator = false;
    
    NSString *headerString = @"<header><meta name='viewport' content='width=device-width, initial-scale=0.8, maximum-scale=0.8, minimum-scale=0.8, user-scalable=no'></header>";
    if (_content) {
        [_webView loadHTMLString:[headerString stringByAppendingString:_content] baseURL:nil];
    }
    [self.view addSubview:_webView];
    [_webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    
    if (object == _webView && [keyPath isEqualToString:@"title"]) {
        //        NSString *title = [[change objectForKey:NSKeyValueChangeNewKey] stringValue];
        NSString *title = _webView.title;
        if (title) {
            self.navigationItem.title = title;
        }
    }
}
- (void)dealloc
{
    [_webView removeObserver:self forKeyPath:@"title"];
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
