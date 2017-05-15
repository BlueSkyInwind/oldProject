//
//  CertificationViewController.m
//  fxdProduct
//
//  Created by dd on 2017/2/22.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "CertificationViewController.h"
#import "FaceCell.h"
#import "MobileCell.h"
#import <MGLivenessDetection/MGLivenessDetection.h>
#import "FaceIDLiveModel.h"
#import "JXLParse.h"
#import "JXLMessagePrse.h"
#import "telphoneView.h"
#import "ReturnMsgBaseClass.h"
#import "MGLiveViewController.h"
#import "BaseNavigationViewController.h"
#import "ExpressViewController.h"
#import "FXDWebViewController.h"
@interface CertificationViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,LiveDeteDelgate>
{
    JXLParse *_jxlParse;
    BOOL _captchaHidenDisplay;
    
    NSMutableArray <NSString *>*_mobileRequArr;
    ReturnMsgBaseClass *_mobileParse;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) BOOL btnStatus;

@end

@implementation CertificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.automaticallyAdjustsScrollViewInsets = false;
    
    _captchaHidenDisplay = true;
    _mobileRequArr = [NSMutableArray arrayWithObjects:@"",@"",@"",@"", nil];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"三方认证";
    _btnStatus = YES;
    [self addBackItem];
    [self configTableView];
    [self fatchMobileOpera];
}

- (void)configTableView
{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([FaceCell class]) bundle:nil] forCellReuseIdentifier:@"FaceCell"];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MobileCell class]) bundle:nil] forCellReuseIdentifier:@"MobileCell"];
    
    //    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _k_w, 100)];
    //    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    //    [footView addSubview:saveBtn];
    //    [saveBtn setTitle:@"点击认证" forState:UIControlStateNormal];
    //    [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    [Tool setCorner:saveBtn borderColor:[UIColor clearColor]];
    //    [saveBtn setBackgroundColor:UI_MAIN_COLOR];
    //    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.equalTo(@20);
    //        make.right.equalTo(@(-20));
    //        make.bottom.equalTo(@0);
    //        make.height.equalTo(saveBtn.mas_width).multipliedBy(0.15);
    //    }];
    //    [saveBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //    self.tableView.tableFooterView = footView;
    
}

//- (void)saveBtnClick
//{
//    DLog(@"认证");
//}

#pragma mark - TableviewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_showAll) {
        return 2;
    } else {
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (_showAll) {
            return 200.f;
        }else {
            return _k_h-64;
        }
    } else {
        return 380.f;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        if (_showAll) {
            return 7.0f;
        } else {
            return 0.1f;
        }
    }else {
        return 0.1f;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            if (_showAll) {
                FaceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FaceCell"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                [Tool setCorner:cell.detectionBtn borderColor:[UIColor clearColor]];
                
                if (_liveEnabel) {
                    if ([_verifyStatus isEqualToString:@"1"]) {
                        [cell.detectionBtn setTitle:@"进入检测" forState:UIControlStateNormal];
                        cell.detectionBtn.enabled = true;
                        [cell.detectionBtn setBackgroundColor:UI_MAIN_COLOR];
                        [cell.detectionBtn addTarget:self action:@selector(startDetection) forControlEvents:UIControlEventTouchUpInside];
                    } else {
                        cell.detectionBtn.enabled = false;
                        [cell.detectionBtn setBackgroundColor:rgb(139, 140, 143)];
                        [cell.detectionBtn setTitle:@"已认证" forState:UIControlStateNormal];
                    }
                    
                } else {
                    cell.detectionBtn.enabled = false;
                    [cell.detectionBtn setBackgroundColor:rgb(139, 140, 143)];
                    [cell.detectionBtn setTitle:@"已认证" forState:UIControlStateNormal];
                }
                return cell;
            } else {
                MobileCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MobileCell"];
                cell.AgreementImage.userInteractionEnabled = YES;
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickAgreementImage:)];
                [cell.AgreementImage addGestureRecognizer:tap];
                NSString *str = cell.AgreementLabel.text;
                NSMutableAttributedString *ssa = [[NSMutableAttributedString alloc] initWithString:str];
                [ssa addAttribute:NSForegroundColorAttributeName value:UI_MAIN_COLOR range:NSMakeRange(3,13)];
                cell.AgreementLabel.attributedText = ssa;
                cell.AgreementLabel.userInteractionEnabled = YES;
                UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickAgreement)];
                [cell.AgreementLabel addGestureRecognizer:tap1];
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.passwordField.delegate = self;
                cell.veritifyCodeField.delegate = self;
                [Tool setCorner:cell.mobileBtn borderColor:[UIColor clearColor]];
                if ([_isMobileAuth isEqualToString:@"0"]) {
                    if ([self isCanEnable]) {
                        [cell.mobileBtn setBackgroundColor:UI_MAIN_COLOR];
                        cell.mobileBtn.enabled = true;
                        [cell.mobileBtn addTarget:self action:@selector(mobileCheck) forControlEvents:UIControlEventTouchUpInside];
                    }else {
                        [cell.mobileBtn setBackgroundColor:rgb(139, 140, 143)];
                        cell.mobileBtn.enabled = false;
                    }
                } else {
                    [cell.mobileBtn setBackgroundColor:rgb(139, 140, 143)];
                    cell.passwordField.enabled = false;
                    [cell.mobileBtn setTitle:@"已认证" forState:UIControlStateNormal];
                    cell.mobileBtn.enabled = false;
                }
                cell.mobileLabel.text = _mobileRequArr[0];
                cell.operatorLabel.text = _mobileRequArr[1];
                cell.smsCodeView.hidden = _captchaHidenDisplay;
                cell.passwordField.text = _mobileRequArr[2];
                cell.passwordField.tag = 1;
                cell.veritifyCodeField.text = _mobileRequArr[3];
                cell.veritifyCodeField.tag = 2;
                [cell.mobileHelpBtn addTarget:self action:@selector(showMobileHelp) forControlEvents:UIControlEventTouchUpInside];
                
                [cell.mobileBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(@15);
                    //                make.top.equalTo(cell.smsCodeView.mas_bottom).offset(14);
                    make.bottom.equalTo(cell.contentView).offset(-5);
                    make.right.equalTo(@(-15));
                    make.height.equalTo(cell.mobileBtn.mas_width).multipliedBy(0.15);
                }];
                if (_captchaHidenDisplay) {

                    cell.agreementTopConstraint.constant = 5;
                }else{
                
                    cell.agreementTopConstraint.constant = 55;

                    
                }
                return cell;
            }
        }
            break;
        case 1:
        {
            MobileCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MobileCell"];
            
            cell.AgreementImage.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickAgreementImage:)];
            [cell.AgreementImage addGestureRecognizer:tap];
            NSString *str = cell.AgreementLabel.text;
            NSMutableAttributedString *ssa = [[NSMutableAttributedString alloc] initWithString:str];
            [ssa addAttribute:NSForegroundColorAttributeName value:rgb(0, 170, 238) range:NSMakeRange(3,13)];
            cell.AgreementLabel.attributedText = ssa;
            
            cell.AgreementLabel.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickAgreement)];
            [cell.AgreementLabel addGestureRecognizer:tap1];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.passwordField.delegate = self;
            cell.veritifyCodeField.delegate = self;
            [Tool setCorner:cell.mobileBtn borderColor:[UIColor clearColor]];
            if ([_isMobileAuth isEqualToString:@"0"]) {
                if ([self isCanEnable]) {
                    [cell.mobileBtn setBackgroundColor:UI_MAIN_COLOR];
                    cell.mobileBtn.enabled = true;
                    [cell.mobileBtn addTarget:self action:@selector(mobileCheck) forControlEvents:UIControlEventTouchUpInside];
                }else {
                    [cell.mobileBtn setBackgroundColor:rgb(139, 140, 143)];
                    cell.mobileBtn.enabled = false;
                }
            } else {
                [cell.mobileBtn setBackgroundColor:rgb(139, 140, 143)];
                cell.passwordField.enabled = false;
                cell.passView.hidden = true;
                [cell.mobileBtn setTitle:@"已认证" forState:UIControlStateNormal];
                cell.mobileBtn.enabled = false;
            }
            
            cell.mobileLabel.text = _mobileRequArr[0];
            cell.operatorLabel.text = _mobileRequArr[1];
            cell.smsCodeView.hidden = _captchaHidenDisplay;
            cell.passwordField.text = _mobileRequArr[2];
            cell.passwordField.tag = 1;
            cell.veritifyCodeField.text = _mobileRequArr[3];
            cell.veritifyCodeField.tag = 2;
            [cell.mobileHelpBtn addTarget:self action:@selector(showMobileHelp) forControlEvents:UIControlEventTouchUpInside];
            [cell.mobileBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(@15);
                //                make.top.equalTo(cell.smsCodeView.mas_bottom).offset(14);
                make.bottom.equalTo(cell.contentView).offset(-5);
                make.right.equalTo(@(-15));
                make.height.equalTo(cell.mobileBtn.mas_width).multipliedBy(0.15);
            }];
            
            if (_captchaHidenDisplay) {

                cell.agreementTopConstraint.constant = 5;

            }else{
                
                cell.agreementTopConstraint.constant = 55;

            }
            
            return cell;
        }
            break;
        default:
            break;
    }
    
    return nil;
}

- (BOOL)isCanEnable
{
    if (_captchaHidenDisplay) {
        if (_mobileRequArr[2].length > 5) {
            return true;
        } else {
            return false;
        }
    } else {
        if (_mobileRequArr[2].length > 5 && _mobileRequArr[3].length > 3) {
            return true;
        } else {
            return false;
        }
    }
}

- (void)showMobileHelp
{
    
    FXDWebViewController *controller = [[FXDWebViewController alloc]init];
    controller.urlStr = [NSString stringWithFormat:@"%@%@",_H5_url,_mobileAuthentication_url];
    [self.navigationController pushViewController:controller animated:YES];
//    telphoneView *telview = [[[NSBundle mainBundle] loadNibNamed:@"telphoneView" owner:self options:nil] lastObject];
//    telview.frame = CGRectMake(0, 0, _k_w, _k_h);
//    [telview show];
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag == 1) {
        if (textField.text.length < 5) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入正确的运营商服务密码"];
            [_mobileRequArr replaceObjectAtIndex:2 withObject:@""];
        } else {
            [_mobileRequArr replaceObjectAtIndex:2 withObject:textField.text];
        }
    }
    if (textField.tag == 2) {
        if (textField.text.length < 3) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入正确的验证码"];
            [_mobileRequArr replaceObjectAtIndex:3 withObject:@""];
        } else {
            [_mobileRequArr replaceObjectAtIndex:3 withObject:textField.text];
        }
    }
    [_tableView reloadData];
}

- (void)mobileCheck
{
    if (!_btnStatus) {
        
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"需同意授权协议，才可进行认证"];
    }else{
    
        if (_showAll) {
            if (_liveEnabel) {
                if ([_verifyStatus isEqualToString:@"1"]) {
                    [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请先进行人脸识别"];
                    return;
                } else {
                    [self saveMobileAuth:@"1"];
                }
                
            } else {
                [self mibileAuth];
            }
        }else {
            [self saveMobileAuth:@"1"];
        }
    }
    
}

- (void)mibileAuth
{
    NSDictionary *paramDic;
    NSString *mobileStr = [_mobileRequArr[0] stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (_captchaHidenDisplay) {
        paramDic = @{@"mobile_phone_":mobileStr,
                     @"service_password_":_mobileRequArr[2]
                     };
    } else {
        paramDic = @{@"mobile_phone_":mobileStr,
                     @"service_password_":_mobileRequArr[2],
                     @"verify_code_":_mobileRequArr[3]
                     };
    }
    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_Certification_url] parameters:paramDic finished:^(EnumServerStatus status, id object) {
        if (status == Enum_SUCCESS) {
            _mobileParse = [ReturnMsgBaseClass modelObjectWithDictionary:object];
            if ([_mobileParse.flag isEqualToString:@"0000"])
            {
                //                [dataListAll2 replaceObjectAtIndex:13 withObject:@"2"];
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:_mobileParse.msg];
                //                _segment.selectedSegmentIndex = 1;
                //                [self createUIWith:_segment.selectedSegmentIndex];
                [self saveMobileAuth:@"1"];
            }else if ([_mobileParse.flag isEqualToString:@"0006"]) {
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:_mobileParse.msg];
                //                [dataListAll2 replaceObjectAtIndex:12 withObject:@"flag"];
                _captchaHidenDisplay = false;//错误时 验证码显示
                [_tableView reloadData];
            }else{
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:_mobileParse.msg];
                [self saveMobileAuth:@"-1"];
            }
        }
    } failure:^(EnumServerStatus status, id object) {
        
    }];
}

- (void)saveMobileAuth:(NSString *)authCode
{
    NSDictionary *dic = @{@"code":authCode};
    __weak CertificationViewController *weakself = self;
    //    __block NSMutableArray * blockDataList = dataListAll2;
    
    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_authMobilePhone_url] parameters:dic finished:^(EnumServerStatus status, id object) {
        ReturnMsgBaseClass *returnParse = [ReturnMsgBaseClass modelObjectWithDictionary:object];
        if ([returnParse.flag isEqualToString:@"0000"]) {
            //            [blockDataList replaceObjectAtIndex:13 withObject:@"2"];
            [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:@"认证成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakself.navigationController popViewControllerAnimated:YES];
            });
        }else{
            //            [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:returnParse.msg];
        }
        
        //        if ([authCode isEqualToString:@"1"]) {
        //            [blockDataList replaceObjectAtIndex:13 withObject:@"2"];
        //        } else {
        //            [blockDataList replaceObjectAtIndex:13 withObject:@""];
        //        }
    } failure:^(EnumServerStatus status, id object) {
    }];
}

//- (void)mobileCheck
//{
//    if (_mobileRequArr[0].length<5 || _mobileRequArr[1].length < 3) {
//        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入服务密码或验证码"];
//    }
//
//    __weak CertificationViewController *weakSelf = self;
//    if (_jxlParse &&![_jxlParse.data.token isEqualToString:@""] && ![_jxlParse.data.datasource.website isEqualToString:@""]) {
//        [self startRequMessage:_jxlParse.data.token finsh:^(JXLMessagePrse *messageParse) {
//            [weakSelf setUIUpdate:messageParse];
//        }];
//    } else {
//        [weakSelf fatchJXLToken:^{
//            [weakSelf startRequMessage:_jxlParse.data.token finsh:^(JXLMessagePrse *messageParse) {
//                [weakSelf setUIUpdate:messageParse];
//            }];
//        }];
//    }
//}

- (void)setUIUpdate:(JXLMessagePrse *)messageParse
{
    if (messageParse.success) {
        switch (messageParse.data.process_code) {
            case 10002:
            case 10004:
            case 10006:
            {
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:messageParse.data.content];
                _captchaHidenDisplay = false;
                [_tableView reloadData];
            }
                break;
            case 10003:
            case 10007:
            case 10009:
            case 10010:
            case 30000:
            {
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:messageParse.data.content];
            }
                break;
            case 10008:
            {
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"认证成功"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:true];
                });
            }
                break;
                
            default:
                break;
        }
    } else {
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:messageParse.data.content];
    }
}


- (void)fatchJXLToken:(void(^)())finsh
{
    NSDictionary *paramDic = @{@"basic_info":@{@"name":@"水世星",
                                               @"id_card_num":@"34040619760917815X",
                                               @"cell_phone_num":@"18108030979"
                                               }
                               };
    [[FXDNetWorkManager sharedNetWorkManager] JXLPOSTWithURL:_JXLGetToken_url parameters:paramDic finished:^(EnumServerStatus status, id object) {
        _jxlParse = [JXLParse yy_modelWithJSON:object];
        DLog(@"%@",_jxlParse);
        if (_jxlParse.success) {
            //            [self startRequMessage:_jxlParse.data.token];
            finsh();
        }
    } failure:^(EnumServerStatus status, id object) {
        
    }];
}

- (void)startRequMessage:(NSString *)tokenStr finsh:(void(^)(JXLMessagePrse *messageParse))finish
{
    NSDictionary *paramDic;
    if (_captchaHidenDisplay) {
        paramDic = @{@"token":tokenStr,
                     @"account":@"18108030979",
                     @"password":_mobileRequArr[0],
                     @"website":_jxlParse.data.datasource.website};
    } else {
        paramDic = @{@"token":tokenStr,
                     @"account":@"18108030979",
                     @"password":_mobileRequArr[0],
                     @"website":_jxlParse.data.datasource.website,
                     @"captcha":_mobileRequArr[1],
                     @"type":@"SUBMIT_CAPTCHA"};
    }
    
    //    @"type":
    [[FXDNetWorkManager sharedNetWorkManager] JXLPOSTWithURL:_messagesReq_url parameters:paramDic finished:^(EnumServerStatus status, id object) {
        DLog(@"%@",object);
        JXLMessagePrse *messageParse = [JXLMessagePrse yy_modelWithJSON:object];
        finish(messageParse);
    } failure:^(EnumServerStatus status, id object) {
        
    }];
}

- (void)startDetection
{
    [MGLicenseManager licenseForNetWokrFinish:^(bool License) {
        if (License) {
            [self checkFaceDecetion];
        } else {
            
        }
    }];
}


- (void)checkFaceDecetion
{
    [MGLicenseManager licenseForNetWokrFinish:^(bool License) {
        if (License) {
            MGLiveViewController *myVC = [[MGLiveViewController alloc] initWithDefauleSetting];
            myVC.delagate = self;
            BaseNavigationViewController *liveVC = [[BaseNavigationViewController alloc] initWithRootViewController:myVC];
            
            [self presentViewController:liveVC animated:true completion:nil];
        } else {
            
        }
    }];
    
    
    //    MGLiveManager *manager = [[MGLiveManager alloc] init];
    //    manager.detectionWithMovier = NO;
    //    manager.actionCount = 3;
    //
    //    __weak CertificationViewController *weakSlf = self;
    //    [manager startFaceDecetionViewController:self finish:^(FaceIDData *finishDic, UIViewController *viewController) {
    //        [viewController dismissViewControllerAnimated:YES completion:nil];
    //        [weakSlf verifyLive:finishDic];
    //    } error:^(MGLivenessDetectionFailedType errorType, UIViewController *viewController) {
    //        [viewController dismissViewControllerAnimated:YES completion:nil];
    //
    //        [self showErrorString:errorType];
    //    }];
}

#pragma mark - LiveDeteDelgate

- (void)liveDateSuccess:(FaceIDData *)faceIDData
{
    [self verifyLive:faceIDData];
}

- (void)liveDateFaile:(MGLivenessDetectionFailedType)errorType
{
    [self showErrorString:errorType];
}

- (void)verifyLive:(FaceIDData *)imagesDic
{
    NSDictionary *paramDic = @{@"api_key":FaceIDAppKey,
                               @"api_secret":FaceIDAppSecret,
                               @"comparison_type":@1,
                               @"face_image_type":@"meglive",
                               @"idcard_name":[Utility sharedUtility].userInfo.realName,
                               @"idcard_number":[Utility sharedUtility].userInfo.userIDNumber,
                               @"delta":imagesDic.delta};
    [[FXDNetWorkManager sharedNetWorkManager] POSTUpLoadImage:_verifyLive_url FilePath:imagesDic.images parameters:paramDic finished:^(EnumServerStatus status, id object) {
        DLog(@"%@",object);
        FaceIDLiveModel *faceIDLiveParse = [FaceIDLiveModel yy_modelWithJSON:object];
        if (!faceIDLiveParse.error_message) {
            NSDictionary *dic = [NSDictionary dictionaryWithDictionary:object];
            NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
            NSString *jsonStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            [self uploadLiveInfo:jsonStr];
        } else {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:faceIDLiveParse.error_message];
        }
    } failure:^(EnumServerStatus status, id object) {
//        NSError *error = object;
//        
//        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:[NSString stringWithFormat:@"Error-%ld",(long)error.code]];
    }];
}

- (void)uploadLiveInfo:(NSString *)resultJSONStr
{
    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_detectInfo_url] parameters:@{@"records":resultJSONStr} finished:^(EnumServerStatus status, id object) {
        if ([[object objectForKey:@"flag"] isEqualToString:@"0000"]) {
            NSNumber *status = [[object objectForKey:@"result"] objectForKey:@"verify_status_"];
            if (status.intValue == 2 || status.intValue == 3) {
                _liveEnabel = false;
                [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:[[object objectForKey:@"result"] objectForKey:@"verify_msg_"]];
                if ([_isMobileAuth isEqualToString:@"1"]) {
                    [self.navigationController popViewControllerAnimated:true];
                }
            } else {
                _liveEnabel = true;
                _verifyStatus = [NSString stringWithFormat:@"%d",status.intValue];
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:[[object objectForKey:@"result"] objectForKey:@"verify_msg_"]];
            }
        } else {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:[object objectForKey:@"msg"]];
        }
        [_tableView reloadData];
    } failure:^(EnumServerStatus status, id object) {
        
    }];
    
}

- (void)showErrorString:(MGLivenessDetectionFailedType)errorType{
    switch (errorType) {
        case DETECTION_FAILED_TYPE_ACTIONBLEND:
        {
            [self showMessage:@"请按照提示完成动作"];
        }
            break;
        case DETECTION_FAILED_TYPE_NOTVIDEO:
        {
            [self showMessage:@"活体检测未成功"];
        }
            break;
        case DETECTION_FAILED_TYPE_TIMEOUT:
        {
            [self showMessage:@"请在规定时间内完成动作"];
        }
            break;
        default:
        {
            [self showMessage:@"请按照提示完成动作"];
        }
            break;
    }
}

- (void)showMessage:(NSString *)msg
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:action];
    [self presentViewController:alertController animated:true completion:nil];
}

- (void)fatchMobileOpera
{
    //获取手机运营商
    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_getMobileOpera_url] parameters:nil finished:^(EnumServerStatus status, id object) {
        if (status == Enum_SUCCESS) {
            if ([[object objectForKey:@"flag"] isEqualToString:@"0000"]) {
                NSString *telNum = [[object objectForKey:@"ext"] objectForKey:@"mobile_phone_"];
                [_mobileRequArr replaceObjectAtIndex:0 withObject:[self formatString:telNum]];
                NSString *result = [object objectForKey:@"result"];
                [_mobileRequArr replaceObjectAtIndex:1 withObject:result];
                [_tableView reloadData];
            }else{
                DLog(@"获取失败");
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"运营商信息获取失败"];
            }
        }
    } failure:^(EnumServerStatus status, id object) {
        
    }];
}

- (NSString *)formatString:(NSString *)str
{
    NSMutableString *returnStr = [NSMutableString stringWithString:str];
    
    NSMutableString *zbc = [NSMutableString string];
    for (NSInteger i = 0; i < returnStr.length; i++) {
        unichar c = [returnStr characterAtIndex:i];
        if (i > 0) {
            if (i == 2) {
                [zbc appendFormat:@"%C ",c];
                
            }else if (i == 6){
                [zbc appendFormat:@"%C ",c];
            }else {
                [zbc appendFormat:@"%C",c];
            }
        } else {
            [zbc appendFormat:@"%C",c];
        }
    }
    
    return zbc;
}


-(void)clickAgreementImage:(UITapGestureRecognizer *)sender{

    UIImageView *agreementImage = (UIImageView *)sender.view;
    self.btnStatus = !self.btnStatus;
    
    if (!self.btnStatus) {
        agreementImage.image = [UIImage imageNamed:@"trick"];
    } else {
        agreementImage.image = [UIImage imageNamed:@"tricked"];
    
    }
    
    
}

-(void)clickAgreement{
    
    ExpressViewController *controller = [[ExpressViewController alloc]init];
    controller.productId = @"operInfo";
    [self.navigationController pushViewController:controller animated:YES];
    
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
