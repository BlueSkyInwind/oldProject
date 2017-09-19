//
//  InvitationViewController.m
//  fxdProduct
//
//  Created by dd on 2017/2/7.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "InvitationViewController.h"
#import "HMScannerController.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import "ReconfrInfoModel.h"

@interface InvitationViewController ()
{
    YYTextView *_textView;
}

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation InvitationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"好友邀请";
    self.automaticallyAdjustsScrollViewInsets = false;
    self.scrollView.showsVerticalScrollIndicator = false;
    self.scrollView.bounces = true;
    [self addBackItem];
    self.scrollView.contentSize = CGSizeMake(_k_w, _k_h*1.1);
    //    self.scrollView.backgroundColor = [UIColor redColor];
//    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(20, 30, _k_w-40, 370)];
    UIView *topView = [[UIView alloc] init];
    [Tool setCorner:topView borderColor:[UIColor clearColor]];
    topView.clipsToBounds = true;
    [self.scrollView addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(20);
        make.top.equalTo(self.scrollView.mas_top).offset(30);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.height.equalTo(topView.mas_width).multipliedBy(1.2f);
    }];
    topView.backgroundColor = rgb(240, 241, 242);
    
    UIView *bannerView = [[UIView alloc] init];
    [topView addSubview:bannerView];
    [bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.height.equalTo(@60);
    }];
    bannerView.backgroundColor = UI_MAIN_COLOR;
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"推荐好友";
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:19.f];
    label.textAlignment = NSTextAlignmentCenter;
    [bannerView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@0);
        make.right.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
    
    UILabel *invitationTitle = [[UILabel alloc] init];
    invitationTitle.text = @"我的邀请码";
    invitationTitle.textColor = [UIColor whiteColor];
    invitationTitle.textAlignment = NSTextAlignmentCenter;
    invitationTitle.textColor = rgb(96, 98, 98);
    invitationTitle.font = [UIFont systemFontOfSize:16.f];
    [topView addSubview:invitationTitle];
    [invitationTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(label.mas_bottom).offset(25);
        make.right.equalTo(@0);
        make.height.equalTo(@20);
    }];
    
    UILabel *invitationCode = [[UILabel alloc] init];
    invitationCode.text = [Tool getContentWithKey:kInvitationCode];
    invitationCode.textColor = rgb(0, 141, 233);
    invitationCode.font = [UIFont boldSystemFontOfSize:23.f];
    invitationCode.textAlignment = NSTextAlignmentCenter;
    [topView addSubview:invitationCode];
    [invitationCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(invitationTitle.mas_bottom).offset(0);
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.height.equalTo(@30);
    }];
    
    UIView *qrCodeView = [[UIView alloc] init];
    [topView addSubview:qrCodeView];
    qrCodeView.backgroundColor = [UIColor whiteColor];
//    if (UI_IS_IPHONE5) {
//        [qrCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(@50);
//            make.top.equalTo(invitationCode.mas_bottom).offset(10);
//            make.right.equalTo(@(-50));
//            make.height.equalTo(qrCodeView.mas_width).multipliedBy(1.12f);
//        }];
//    } else {
//        [qrCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(@80);
//            make.top.equalTo(invitationCode.mas_bottom).offset(10);
//            make.right.equalTo(@(-80));
//            make.height.equalTo(qrCodeView.mas_width).multipliedBy(1.12f);
//        }];
//    }
    [qrCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@80);
        make.top.equalTo(invitationCode.mas_bottom).offset(10);
        make.right.equalTo(@(-80));
        make.height.equalTo(qrCodeView.mas_width).multipliedBy(1.12f);
    }];
    
    
    UIImageView *qrImageView = [[UIImageView alloc] init];
//    qrImageView.backgroundColor = [UIColor redColor];
    [qrCodeView addSubview:qrImageView];
    [qrImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@10);
        make.left.equalTo(@10);
        make.right.equalTo(@(-10));
//        make.height.equalTo(@165);
        make.height.equalTo(qrImageView.mas_width).multipliedBy(1.f);
    }];
    
    UILabel *myQrLabel = [[UILabel alloc] init];
    myQrLabel.text = @"我的邀请二维码";
    myQrLabel.font = [UIFont systemFontOfSize:12.f];
    myQrLabel.textAlignment = NSTextAlignmentCenter;
    myQrLabel.textColor = rgb(104, 105, 106);
    [qrCodeView addSubview:myQrLabel];
    [myQrLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(qrImageView.mas_bottom).offset(5);
        make.right.equalTo(@0);
        make.bottom.equalTo(@(-5));
    }];
    
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [Tool setCorner:shareBtn borderColor:[UIColor clearColor]];
//    shareBtn.frame = CGRectMake(30, 450, _k_w-60, 60);
    [shareBtn setTitle:@"点击分享" forState:UIControlStateNormal];
    [shareBtn setTintColor:[UIColor whiteColor]];
    [shareBtn addTarget:self action:@selector(shareContent) forControlEvents:UIControlEventTouchUpInside];
    shareBtn.backgroundColor = UI_MAIN_COLOR;
    shareBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17.f];
    [self.scrollView addSubview:shareBtn];
    [shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom).offset(15.f);
        make.left.equalTo(self.view.mas_left).offset(30);
        make.right.equalTo(self.view.mas_right).offset(-30);
        make.height.equalTo(shareBtn.mas_width).multipliedBy(0.16f);
    }];

//    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 550, _k_w, 6)];
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = rgb(235, 236, 237);
    [self.scrollView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(shareBtn.mas_bottom).offset(45);
        make.height.equalTo(lineView.mas_width).multipliedBy(0.02);
    }];
    
    
//    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 566, _k_w, 160)];
    UIView *bottomView = [[UIView alloc] init];
    [self.scrollView addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(lineView.mas_bottom);
        make.right.equalTo(self.view);
        make.height.equalTo(@160);
    }];
    UILabel *ruleLabel = [[UILabel alloc] init];
    [bottomView addSubview:ruleLabel];
    ruleLabel.text = @"活动规则:";
    ruleLabel.font = [UIFont boldSystemFontOfSize:17.f];
    [ruleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@8);
        make.top.equalTo(@10);
        make.right.equalTo(@0);
        make.height.equalTo(@15);
    }];
    
    
    _textView = [YYTextView new];
    _textView.scrollEnabled = true;
    _textView.editable = false;
//    NSMutableAttributedString *contentText = [[NSMutableAttributedString alloc] initWithString:@"新用户注册时输入上方【我的邀请码】或扫描【我的邀请二维码】，注册成功后，您即可获得以下大礼：\n1 免息券******\n2 现金红包******\n3 更高额度奖励\n您也可以直接截图本页面发送至朋友圈，供好友识别二维码"];
//    _textView.attributedText = contentText;
    [bottomView addSubview:_textView];
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@8);
        make.top.equalTo(ruleLabel.mas_bottom).offset(3);
        make.right.equalTo(@(-8));
        make.bottom.equalTo(@0);
    }];
    
    NSString *cardStr = [NSString stringWithFormat:@"%@%@?invitation_code=%@",_H5_url,_h5register_url,[Tool getContentWithKey:kInvitationCode]];
    UIImage *avatar = [UIImage imageNamed:@"app_logo"];
    
    [HMScannerController cardImageWithCardName:cardStr avatar:avatar scale:0.2 completion:^(UIImage *image) {
        qrImageView.image = image;
    }];
    [self getrecomInfo];
}

- (void)getrecomInfo
{
    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_GetRecomfrInfo_url] parameters:nil finished:^(EnumServerStatus status, id object) {
        ReconfrInfoModel *reconfrInfo = [ReconfrInfoModel yy_modelWithJSON:object];
        NSMutableString *str = [[NSMutableString alloc] init];
        for (ReconfrList *list in reconfrInfo.result.list) {
            [str appendFormat:@"%@\n",list.protocol_content_];
        }
        NSMutableAttributedString *contentText = [[NSMutableAttributedString alloc] initWithString:str];
        contentText.yy_font = [UIFont systemFontOfSize:14];
        contentText.yy_color = rgb(139, 139, 140);
        _textView.attributedText = contentText;
    } failure:^(EnumServerStatus status, id object) {
        
    }];
}

-(void)shareContent
{
    NSArray *imageArr = @[[UIImage imageNamed:@"logo_60"]];
    if (imageArr) {
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        NSString *shareUrl = [NSString stringWithFormat:@"%@%@?invitation_code=%@",_H5_url,_h5register_url,[Tool getContentWithKey:kInvitationCode]];
        [shareParams SSDKSetupShareParamsByText:[NSString stringWithFormat:@"发薪贷只专注于网络小额贷款。是一款新型网络小额贷款神器, 尽可能优化贷款申请流程，申请步骤更便捷，轻完成网上贷款。链接:%@",shareUrl]
                                         images:imageArr
                                            url:[NSURL URLWithString:shareUrl]
                                          title:@"发薪贷"
                                           type:SSDKContentTypeAuto];
        [shareParams SSDKEnableUseClientShare];
        [ShareSDK showShareActionSheet:nil
                                 items:@[@(SSDKPlatformSubTypeWechatSession),
                                         @(SSDKPlatformSubTypeWechatTimeline),
                                         @(SSDKPlatformTypeSinaWeibo),
                                         @(SSDKPlatformTypeQQ),
                                         @(SSDKPlatformSubTypeQZone),
                                         @(SSDKPlatformTypeSMS)]
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       switch (state) {
                           case SSDKResponseStateSuccess:
                               [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"分享成功"];
                               break;
                               
                           case SSDKResponseStateFail:
                               [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"分享失败"];
                           default:
                               break;
                       }
                   }];
    }
}


- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
        [self.view addSubview:_scrollView];
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view);
            make.top.equalTo(@64);
            make.right.equalTo(self.view);
            make.bottom.equalTo(self.view);
        }];
    }
    
    return _scrollView;
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
