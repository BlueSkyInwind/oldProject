//
//  PhotoDetailViewController.m
//  fxdProduct
//
//  Created by zhangbaochuan on 16/2/17.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "PhotoDetailViewController.h"

@interface PhotoDetailViewController ()<UIScrollViewDelegate>
{
    UIImageView *_imageView0;
    CGFloat _hei;
}
@end

@implementation PhotoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addBackItem];
    self.navigationItem.title = @"自拍说明";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIImage *image =[UIImage imageNamed:@"zipai_01"];
    _hei = image.size.height;
    _imageView0 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _k_w, _hei)];
    _imageView0.image = image;
    _imageView0.contentMode = UIViewContentModeScaleAspectFill;
    [_scrollview addSubview:_imageView0];
    
    CGFloat _hei2 =_hei;
    for (int i=1; i<5; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"zipai_0%d",i+1]];
        CGFloat _hei1 = image.size.height;
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, _hei2, _k_w, _hei1)];
        imageview.image = image;
        [_scrollview addSubview:imageview];
        
        _hei2 = _hei2 + _hei1;
    }
    
    
    
    _scrollview.contentSize = CGSizeMake(_k_w, _hei2);
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

#pragma mark---ScrollView代理

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat heighty=scrollView.contentOffset.y;
    if (heighty <= 0) {
        _imageView0.frame=CGRectMake(_k_w/120.0*heighty/2*0.1, heighty, _k_w-_k_w/120.0*heighty*0.1, _hei-heighty);
    }
}


@end
