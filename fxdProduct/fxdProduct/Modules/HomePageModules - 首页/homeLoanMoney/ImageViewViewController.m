//
//  ImageViewViewController.m
//  fxdProduct
//
//  Created by zhangbaochuan on 15/12/31.
//  Copyright © 2015年 dd. All rights reserved.
//

#import "ImageViewViewController.h"

@interface ImageViewViewController ()<UIScrollViewDelegate>
{
    UIImageView *iag;
    CGFloat hei;
}

@end

@implementation ImageViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addBackItem];
    self.navigationItem.title = @"借款须知";
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIImage *image1= [UIImage imageNamed:@"banner-02-1"];
    hei = image1.size.height;
    _scrollView.contentSize =CGSizeMake(_k_w, hei);
    iag= [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _k_w, hei)];
    iag.image = image1;
    [_scrollView addSubview:iag];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

#pragma mark---ScrollView代理

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat heighty=scrollView.contentOffset.y;
    if (heighty<=0) {
        iag.frame=CGRectMake(_k_w/120.0*heighty/2*0.1, heighty, _k_w-_k_w/120.0*heighty*0.1, hei-heighty);
    }
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
