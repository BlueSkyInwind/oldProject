//
//  HomepageActivityImageDisplayModule.m
//  fxdProduct
//
//  Created by sxp on 2017/8/10.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "HomepageActivityImageDisplayModule.h"

@interface HomepageActivityImageDisplayModule ()

@end

@implementation HomepageActivityImageDisplayModule

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.firstImageView.userInteractionEnabled = YES;
    self.firstImageView.contentMode = UIViewContentModeScaleAspectFit;
    UITapGestureRecognizer *gest = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageViewTap)];
    [self.firstImageView addGestureRecognizer:gest];
    
}

-(void)imageViewTap{

    if([FXD_Utility sharedUtility].userInfo.juid != nil){
        
        NSDictionary *paramDic =@{@"juid":[FXD_Utility sharedUtility].userInfo.juid,
                                  @"mobile":[FXD_Utility sharedUtility].userInfo.userMobilePhone};
        [[HF_NetWorkRequestManager sharedNetWorkManager] GetWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_sjRecord_url] isNeedNetStatus:true isNeedWait:true parameters:paramDic finished:^(EnumServerStatus status, id object) {
            
        } failure:^(EnumServerStatus status, id object) {
            
        }];
        
    }
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    
    NSURL *url = [NSURL URLWithString:_url];
    UIImage *placeholder = [UIImage imageNamed:@"placeholder_Image"];
    [self.firstImageView sd_setImageWithURL:url placeholderImage:placeholder];
    [self.navigationController setNavigationBarHidden:YES];
}

-(void)viewWillDisappear:(BOOL)animated{

    [self.navigationController setNavigationBarHidden:NO];

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
