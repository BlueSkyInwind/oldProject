//
//  MyAboutOursViewController.m
//  fxdProduct
//
//  Created by zhangbaochuan on 15/11/10.
//  Copyright © 2015年 dd. All rights reserved.
//

#import "MyAboutOursViewController.h"

@interface MyAboutOursViewController ()

@end

@implementation MyAboutOursViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBColor(245, 245, 245, 1);
    [self addBackItem];
    [self createUI];
}

-(void)createUI{
    self.title=@"发薪贷简介";
    UIImage *imagelogo=[UIImage imageNamed:@"more-logo"];
    CGFloat logoHeight = 114;
    CGFloat logoWeight = 114;
    UIImageView *logoimageView=[[UIImageView alloc] initWithFrame:CGRectMake((_k_w-logoWeight)/2, 94, logoWeight, logoHeight)];
    logoimageView.image=imagelogo;
    [self.view addSubview:logoimageView];
    
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0, logoimageView.frame.size.height+logoimageView.frame.origin.y+17, _k_w, 25)];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = RGBColor(0, 144, 255, 1);
    label.font = [UIFont systemFontOfSize:17];
    label.text= @"发薪贷，为生活加点“薪”";
    [self.view addSubview:label];
    
    UIWebView *webView=[[UIWebView alloc]initWithFrame:CGRectMake(0,label.frame.origin.y+label.frame.size.height+33 , _k_w, _k_h-label.frame.origin.y+label.frame.size.height-33)];
    webView.backgroundColor=RGBColor(245, 245, 245, 1);
    [webView loadHTMLString:@"<br><span style='font-size:15px'>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp发薪贷总部位于东方之珠上海，是中赢金融（股权代码：203767）旗下独立的子公司，致力于互联网金融产品的研发和在线支付方案的设计。<p>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp公司以科技为主题，爱是公司的灵魂，信任是基础，建立自由平等的互联网个人金融服务平台是公司的长期追求。<p>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp基于信任，针对目前广大劳薪阶层超小额贷款难的问题，2015年公司全力打造了一款移动信贷产品“发薪贷”。该产品依托公司内部强大专业的大数据团队以及一流的风控系统，经过市场试点的反馈，反复修正和改进，成为一款专为超小额贷款量身定制的快速、安全、简易的移动交易工具，第一时间解决了老百姓的燃眉之急。</span>" baseURL:nil];
    [self.view addSubview:webView];
}

-(void)tapClick{

    UIAlertController *alertCon=[UIAlertController alertControllerWithTitle:@"" message:@"工作时间：9：00~17：30" preferredStyle:UIAlertControllerStyleActionSheet];
    [alertCon addAction:[UIAlertAction actionWithTitle:@"☎️400-088-0888" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSURL *telURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", @"400-088-0888"]];
        [[UIApplication sharedApplication] openURL:telURL];
    }]];
    [alertCon addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alertCon animated:YES completion:nil];
}

//隐藏与现实tabbar
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}


@end
