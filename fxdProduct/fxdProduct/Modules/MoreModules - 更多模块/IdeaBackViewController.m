//
//  IdeaBackViewController.m
//  fxdProduct
//
//  Created by zhangbaochuan on 15/10/10.
//  Copyright © 2015年 dd. All rights reserved.
//

#import "IdeaBackViewController.h"
#import "ReturnMsgBaseClass.h"
#import "IdeaBackViewModel.h"
@interface IdeaBackViewController () <UITextViewDelegate>
{
    ReturnMsgBaseClass *_feedParse;
}

- (IBAction)submitBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *foreTextview;

@end

@implementation IdeaBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title=@"意见反馈";
    [self addBackItem];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 提交事件
- (IBAction)submitBtn:(id)sender {
    
    if (![self.foreTextview.text isEqualToString:@""] && ![self.foreTextview.text isEqualToString:@"请在此输入您的宝贵建议"]) {
        if ([self.foreTextview.text length] >101) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入100字以内!"];
        }else{
            NSLog(@"%@",[FXD_Utility sharedUtility].userInfo.userName);
            
            
            IdeaBackViewModel *ideaBackViewModel = [[IdeaBackViewModel alloc]init];
            [ideaBackViewModel setBlockWithReturnBlock:^(id returnValue) {
                
                _feedParse = [ReturnMsgBaseClass modelObjectWithDictionary:returnValue];
                if ([_feedParse.flag isEqualToString:@"0000"]) {
                    [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"谢谢您的反馈"];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self.navigationController popViewControllerAnimated:YES];
                    });
                    
                } else {
                    [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:_feedParse.msg];
                }
                
            } WithFaileBlock:^{
                
            }];
            [ideaBackViewModel saveFeedBackContent:self.foreTextview.text];

        }
    } else {
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请填写您宝贵的意见"];
    }
}

//通过判断表层TextView的内容来实现底层TextView的显示于隐藏
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if(![self.foreTextview.text isEqualToString:@""])
    {
        self.foreTextview.textColor=RGBColor(74.0, 74.0, 74.0, 1);
        self.foreTextview.font=[UIFont boldSystemFontOfSize:15];
    }
    if ([self.foreTextview.text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if([self.foreTextview.text isEqualToString:@"请在此输入您的宝贵建议"])
    {
        self.foreTextview.text=@"";
    }
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    if([self.foreTextview.text isEqualToString:@""])
    {
        self.foreTextview.text=@"请在此输入您的宝贵建议";
        self.foreTextview.textColor=RGBColor(214.0, 214.0, 214.0, 1);
        
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

@end
