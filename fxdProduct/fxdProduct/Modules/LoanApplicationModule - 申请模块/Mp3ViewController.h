//
//  Mp3ViewController.h
//  fxdProduct
//
//  Created by zhangbaochuan on 16/1/25.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "BaseViewController.h"

@interface Mp3ViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIImageView *webImage;
@property (weak, nonatomic) IBOutlet UIButton *recordBtn;
- (IBAction)recordBtn:(id)sender;
- (IBAction)recordBtnDown:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *voiceImage;
@property (weak, nonatomic) IBOutlet UIButton *deleBtn;
- (IBAction)deleBtn:(id)sender;
- (IBAction)timeBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *timeBtn;
@property (weak, nonatomic) IBOutlet UIButton *sendBtn;
- (IBAction)sendBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *view02;
@property (weak, nonatomic) IBOutlet UIView *view01;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end
