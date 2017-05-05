//
//  SesameCreditViewController.m
//  fxdProduct
//
//  Created by sxp on 17/5/4.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "SesameCreditViewController.h"
#import "FXDWebViewController.h"
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

-(void)click{

    FXDWebViewController *webview = [[FXDWebViewController alloc] init];
    NSString *url = [NSString stringWithFormat:@"%@%@?user_name_=%@&id_code_=%@",_ZMXY_url,_findZhimaCredit_url,self.realNameTextField.text,self.userIDNumberTextField.text];
    webview.urlStr = url;
    [self.navigationController pushViewController:webview animated:true];
   
    
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
