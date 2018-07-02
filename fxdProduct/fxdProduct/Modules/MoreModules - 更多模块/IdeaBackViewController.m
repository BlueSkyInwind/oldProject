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
@property (weak, nonatomic) IBOutlet UIButton *customerServiceBtn;

@end

@implementation IdeaBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title=@"意见反馈";
    [self addBackItem];
}

- (IBAction)customerServiceBtnClick:(id)sender {
    
    UIAlertController *actionSheett = [UIAlertController alertControllerWithTitle:@"热线服务时间:9:00-17:30(工作日)" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *teleAction = [UIAlertAction actionWithTitle:@"4008-678-655" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSURL *telURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", @"4008-678-655"]];
        [[UIApplication sharedApplication] openURL:telURL];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [actionSheett addAction:teleAction];
    [actionSheett addAction:cancelAction];
    [self presentViewController:actionSheett animated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 提交事件
- (IBAction)submitBtn:(id)sender {
    
    if ([self.foreTextview.text isEqualToString:@""] || [self.foreTextview.text isEqualToString:@"请在此输入您的宝贵建议"]) {
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请填写您宝贵的意见"];
        return;
    }
    
    if ([self.foreTextview.text length] >101) {
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入100字以内!"];
        return;
    }
    
    IdeaBackViewModel *ideaBackViewModel = [[IdeaBackViewModel alloc]init];
    [ideaBackViewModel setBlockWithReturnBlock:^(id returnValue) {
        BaseResultModel * baseRM = returnValue;
        if ([baseRM.errCode isEqualToString:@"0"]) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"谢谢您的反馈"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        } else {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:baseRM.friendErrMsg];
        }
    } WithFaileBlock:^{
        
    }];
    [ideaBackViewModel saveFeedBackContent:self.foreTextview.text];
}

//通过判断表层TextView的内容来实现底层TextView的显示于隐藏
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if(![self.foreTextview.text isEqualToString:@""])
    {
        self.foreTextview.textColor=RGBColor(74.0, 74.0, 74.0, 1);
        self.foreTextview.font=[UIFont boldSystemFontOfSize:15];
    }
    
    if ([[FXD_Tool share] stringContainsEmoji:text] || [[FXD_Tool share] hasEmoji:text]) {
        return NO;
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
