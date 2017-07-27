//
//  SesameCreditViewController.m
//  fxdProduct
//
//  Created by sxp on 17/5/4.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "SesameCreditViewController.h"
#import "FXDWebViewController.h"
#import "SubmitZhimaCreditAuthModel.h"
#import "UserDataViewController.h"
#import "HomeViewController.h"
@interface SesameCreditViewController ()


@end

@implementation SesameCreditViewController
 
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"芝麻信用授权";
    [self addBackItem];
    self.realNameTextField.text = [Utility sharedUtility].userInfo.realName;
    self.userIDNumberTextField.text = [Utility sharedUtility].userInfo.userIDNumber;
    [self.immediateAuthorizationBtn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    
}
#pragma mark - 获取首页产品列表
-(void)click{
    
        DLog(@"%@",self.navigationController.viewControllers);
    
        NSDictionary *paramDic = @{
                                   @"juid":[Utility sharedUtility].userInfo.juid,
                                   @"id_code_":self.userIDNumberTextField.text,
                                   @"user_name_":self.realNameTextField.text
                                   };
        
        [[FXDNetWorkManager sharedNetWorkManager]POSTHideHUD:[NSString stringWithFormat:@"%@%@",_main_url,_submitZhimaCredit_url] parameters:paramDic finished:^(EnumServerStatus status, id object) {
            
            DLog(@"=======%@",object);
        
            SubmitZhimaCreditAuthModel *model = [SubmitZhimaCreditAuthModel yy_modelWithJSON:object];
            FXDWebViewController *webview = [[FXDWebViewController alloc] init];
            NSLog(@"%@",model.result.auth_url);
            webview.urlStr = model.result.auth_url;
            webview.isZhima = YES;
            [self.navigationController pushViewController:webview animated:true];
        } failure:^(EnumServerStatus status, id object) {
            
            DLog(@"%@",object);
            
        }];
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
