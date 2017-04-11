//
//  Mp3ViewController.m
//  fxdProduct
//
//  Created by zhangbaochuan on 16/1/25.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "Mp3ViewController.h"
#import "RecordManager.h"
#import "UIImage+GIF.h"
#import "CheckViewController.h"

//测量一段程序的时间
#define TICK   NSDate *startTime = [NSDate date]
#define TOCK   NSLog(@"Time: %f", -[startTime timeIntervalSinceNow])

@interface Mp3ViewController ()<VoiceDelegate>
{
    BOOL flagView;
    int flagfont;
    NSString *urlString;
}


@end

@implementation Mp3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addBackItem];
    self.navigationItem.title = @"资料填写";
    flagView = NO;
    if (flagView) {
        [self ishiddenWithView1:YES andWithView2:NO andFlage:YES];
    }else{
        [self ishiddenWithView1:NO andWithView2:YES andFlage:YES];
    }
    
    [RecordManager shareRecordManager].delegate=self;
    if (_k_h == 414) {
        flagfont = 6;
        urlString=@"<font style='color:rgb(0, 170, 238)' size ='4'>&nbsp;按住语言按钮朗读一下内容:</font><br/><font size = '3'>&nbsp;&nbsp;&nbsp;&nbsp;本人<span class=‘h1’>xxx</span>，性别x，身份证号<span class=‘h1’>xxxxxx</span>职业<span class=‘h1’>xxx</span>现通过中赢金融平台向具体投资人申请借款，借款金额为<span class=‘h1’>xxxx</span>。本人承诺如下：<br/>&nbsp;&nbsp;&nbsp;&nbsp;第一，本人提交的身份资料、收入资料、个人征信报告等资料均为真实、合法、有效；<br/>&nbsp;&nbsp;&nbsp;&nbsp;第二，本人借款用途为<span class=‘hl’>xxxxxx</span>本人将按约定的合法用途使用借款，绝不挪作他用，如有违反，由此产生的一切责任由本人承担；<br/>&nbsp;&nbsp;&nbsp;&nbsp;第三，本人已知晓此笔借款每期还款日及还款金额，并承诺在每期还款日按时将应还金额存入还款账户，并授权银行或第三方支付机构进行相应的划转。若逾期还款，本人愿意承担一切责任；<br/>&nbsp;&nbsp;&nbsp;&nbsp;第四，本人已知晓借款合同约定的权利、义务、责任，并同意签署借款合同。本人已完全理解合同的所有条款，自愿承担由此产生的一切责任。</font></p>";
    }else {
        flagfont =2;
        urlString=@"<font style='color:rgb(0, 170, 238)' style=‘font-size: 10px;’>&nbsp;按住语言按钮朗读一下内容:</font><br/><p style=‘font-size: 50px;’>&nbsp;&nbsp;&nbsp;&nbsp;本人<span class=‘h1’>xxx</span>，性别x，身份证号<span class=‘h1’>xxxxxx</span>职业<span class=‘h1’>xxx</span>现通过中赢金融平台向具体投资人申请借款，借款金额为<span class=‘h1’>xxxx</span>。本人承诺如下：<br/>&nbsp;&nbsp;&nbsp;&nbsp;第一，本人提交的身份资料、收入资料、个人征信报告等资料均为真实、合法、有效；<br/>&nbsp;&nbsp;&nbsp;&nbsp;第二，本人借款用途为<span class=‘hl’>xxxxxx</span>本人将按约定的合法用途使用借款，绝不挪作他用，如有违反，由此产生的一切责任由本人承担；<br/>&nbsp;&nbsp;&nbsp;&nbsp;第三，本人已知晓此笔借款每期还款日及还款金额，并承诺在每期还款日按时将应还金额存入还款账户，并授权银行或第三方支付机构进行相应的划转。若逾期还款，本人愿意承担一切责任；<br/>&nbsp;&nbsp;&nbsp;&nbsp;第四，本人已知晓借款合同约定的权利、义务、责任，并同意签署借款合同。本人已完全理解合同的所有条款，自愿承担由此产生的一切责任。</p>";
    }
//    NSString *urlString=@"<p style='color:rgb(0, 170, 238)'> <font size ='4'>&nbsp;按住语言按钮朗读一下内容:</font><p><font size = ‘2’>&nbsp;&nbsp;&nbsp;&nbsp;本人<span class=‘h1’>xxx</span>，性别x，身份证号<span class=‘h1’>xxxxxx</span>职业<span class=‘h1’>xxx</span>现通过中赢金融平台向具体投资人申请借款，借款金额为<span class=‘h1’>xxxx</span>。本人承诺如下：<br/>&nbsp;&nbsp;&nbsp;&nbsp;第一，本人提交的身份资料、收入资料、个人征信报告等资料均为真实、合法、有效；<br/>&nbsp;&nbsp;&nbsp;&nbsp;第二，本人借款用途为<span class=‘hl’>xxxxxx</span>本人将按约定的合法用途使用借款，绝不挪作他用，如有违反，由此产生的一切责任由本人承担；<br/>&nbsp;&nbsp;&nbsp;&nbsp;第三，本人已知晓此笔借款每期还款日及还款金额，并承诺在每期还款日按时将应还金额存入还款账户，并授权银行或第三方支付机构进行相应的划转。若逾期还款，本人愿意承担一切责任；<br/>&nbsp;&nbsp;&nbsp;&nbsp;第四，本人已知晓借款合同约定的权利、义务、责任，并同意签署借款合同。本人已完全理解合同的所有条款，自愿承担由此产生的一切责任。</font></p>";
//    urlString=@"<font style='color:rgb(0, 170, 238)' size ='4'>&nbsp;按住语言按钮朗读一下内容:</font><br/><font size = '3'>&nbsp;&nbsp;&nbsp;&nbsp;本人<span class=‘h1’>xxx</span>，性别x，身份证号<span class=‘h1’>xxxxxx</span>职业<span class=‘h1’>xxx</span>现通过中赢金融平台向具体投资人申请借款，借款金额为<span class=‘h1’>xxxx</span>。本人承诺如下：<br/>&nbsp;&nbsp;&nbsp;&nbsp;第一，本人提交的身份资料、收入资料、个人征信报告等资料均为真实、合法、有效；<br/>&nbsp;&nbsp;&nbsp;&nbsp;第二，本人借款用途为<span class=‘hl’>xxxxxx</span>本人将按约定的合法用途使用借款，绝不挪作他用，如有违反，由此产生的一切责任由本人承担；<br/>&nbsp;&nbsp;&nbsp;&nbsp;第三，本人已知晓此笔借款每期还款日及还款金额，并承诺在每期还款日按时将应还金额存入还款账户，并授权银行或第三方支付机构进行相应的划转。若逾期还款，本人愿意承担一切责任；<br/>&nbsp;&nbsp;&nbsp;&nbsp;第四，本人已知晓借款合同约定的权利、义务、责任，并同意签署借款合同。本人已完全理解合同的所有条款，自愿承担由此产生的一切责任。</font></p>";
    [_webView loadHTMLString:urlString baseURL:nil];
}

- (void) proximityChanged:(NSNotification *)notification {
    //--------------------------------------------------------------
    //如果此时手机靠近面部放在耳朵旁，那么声音将通过听筒输出，并将屏幕变暗
    
    if ([[UIDevice currentDevice] proximityState] == YES)
        
    {
        NSLog(@"接近耳朵");
        //设置从听筒不放,状态设置成播放和录音
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
        
        
        
    }
    else//没黑屏幕
    {
        NSLog(@"不接近耳朵");
        //设置扬声器播放
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    }
    
}

-(void)getView:(double)getFlag
{
    if (0<getFlag<=0.13) {
        [_webImage setImage:[UIImage imageNamed:@"3_lc_icon_20"]];
    }else if (0.13<getFlag<=0.27) {
        [_webImage setImage:[UIImage imageNamed:@"gif_02"]];
    }else if (0.27<getFlag<=0.41) {
        [_webImage setImage:[UIImage imageNamed:@"gif_03"]];
    }else if (0.41<getFlag<=0.62) {
        [_webImage setImage:[UIImage imageNamed:@"gif_04"]];
    }else if (0.62<getFlag<=0.76) {
        [_webImage setImage:[UIImage imageNamed:@"gif_05"]];
    }else if (0.76<getFlag<=0.83) {
        [_webImage setImage:[UIImage imageNamed:@"gif_06"]];
    }else if (0.83<getFlag<=0.9) {
        [_webImage setImage:[UIImage imageNamed:@"gif_06"]];
    }else {
        [_webImage setImage:[UIImage imageNamed:@"gif_07"]];
    }
}

#pragma mark VoiceDelegate
-(void)VoiceDelegate:(double)getflag
{
    [self getView:getflag];
//    NSLog(@"%f",getflag);
}
-(void)RecordSuccess:(int)time
{
    NSLog(@"%d  %@",time,[RecordManager shareRecordManager].urlPlay);
//    NSData *data=[NSData dataWithContentsOfURL:[RecordManager shareRecordManager].urlPlay];
//    NSLog(@"%@",data);
    NSString *timemi= [NSString stringWithFormat:@"                   %d″",time];
    [_timeBtn setTitle:timemi forState:UIControlStateNormal];
}

-(void)RecordSuccess
{
    _voiceImage.image = [UIImage imageNamed:@"3_lc_icon_22"];
    
}

-(void)RecordFail
{
    DLog(@"录音失败");
}

//点击
- (IBAction)recordBtn:(id)sender {
    flagView = YES;
    [self ishiddenWithView1:YES andWithView2:NO andFlage:YES];
    [[RecordManager shareRecordManager] FinishRecord];//转换
    _webImage.image =[UIImage imageNamed:@"3_lc_icon_20"];
    
}

//长按//录音
- (IBAction)recordBtnDown:(id)sender {
     [[RecordManager shareRecordManager] ReadyRecord];
}
//删除
- (IBAction)deleBtn:(id)sender {

    _webImage.image = [UIImage imageNamed:@"3_lc_icon_20"];
    flagView = NO;
    [self ishiddenWithView1:NO andWithView2:YES andFlage:YES];
    [[RecordManager shareRecordManager] cancelRecord];
}

//播放
- (IBAction)timeBtn:(id)sender {
    _voiceImage.image = [UIImage sd_animatedGIFNamed:[[NSBundle mainBundle] pathForResource:@"3_lc_icon_23" ofType:@"gif"]];
    [[RecordManager shareRecordManager] recordPlay];
    
}
//上传网络
- (IBAction)sendBtn:(id)sender {
    DLog(@"发送");

    CheckViewController *chec = [CheckViewController new];
    [self.navigationController pushViewController:chec animated:YES];
}

-(void)ishiddenWithView1:(BOOL)boolView1 andWithView2:(BOOL)boolView2 andFlage:(BOOL)boolflag{
    _view01.hidden = boolView1;
    _view02.hidden = boolView2;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    
    if (flagView) {
        [self ishiddenWithView1:YES andWithView2:NO andFlage:YES];
    }else{
        [self ishiddenWithView1:NO andWithView2:YES andFlage:YES];
    }
}
@end
