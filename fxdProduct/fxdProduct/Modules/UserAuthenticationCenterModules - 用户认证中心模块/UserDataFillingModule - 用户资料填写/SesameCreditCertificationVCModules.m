//
//  SesameCreditViewController.m
//  fxdProduct
//
//  Created by sxp on 17/5/4.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "SesameCreditCertificationVCModules.h"
#import "FXDWebViewController.h"
#import "SubmitZhimaCreditAuthModel.h"
#import "UserDataAuthenticationListVCModules.h"
#import "HomePageVCModules.h"
@interface SesameCreditCertificationVCModules ()


@end

@implementation SesameCreditCertificationVCModules
 
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"芝麻信用授权";
    [self addBackItem];
    self.realNameTextField.text = [FXD_Utility sharedUtility].userInfo.realName;
    self.userIDNumberTextField.text = [FXD_Utility sharedUtility].userInfo.userIDNumber;
    [self.immediateAuthorizationBtn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    if (UI_IS_IPHONEX) {
        self.headerViewHeader.constant = 88;
    }
    
}
#pragma mark - 点击确认按钮
-(void)click{
    
        DLog(@"%@",self.navigationController.viewControllers);
    
    UserDataViewModel * userDataVM = [[UserDataViewModel alloc]init];
    [userDataVM setBlockWithReturnBlock:^(id returnValue) {
        BaseResultModel * baseRM = returnValue;
        if ([baseRM.errCode isEqualToString:@"0"]) {
            SubmitZhimaCreditAuthModel *model = [[SubmitZhimaCreditAuthModel alloc]initWithDictionary:(NSDictionary *)baseRM.data error:nil];
            FXDWebViewController *webview = [[FXDWebViewController alloc] init];
            NSLog(@"%@",model.auth_url);
            webview.urlStr = model.auth_url;
            webview.isZhima = YES;
            [self.navigationController pushViewController:webview animated:true];
        }else{
            [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:baseRM.friendErrMsg];
        }
    } WithFaileBlock:^{
        
    }];
    [userDataVM SubmitZhimaCreditID_code:self.userIDNumberTextField.text user_name:self.realNameTextField.text];
    
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
