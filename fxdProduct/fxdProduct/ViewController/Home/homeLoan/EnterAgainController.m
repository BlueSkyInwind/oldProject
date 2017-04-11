//
//  EnterAgainController.m
//  fxdProduct
//
//  Created by zy on 16/5/12.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "EnterAgainController.h"

#import "LoanMoneyViewController.h"
#import "BankCardViewController.h"

@interface EnterAgainController ()
{
    UIImageView *bankImg;
    NSDictionary *_createBankDict;
    NSString *bankNum;
    NSString *bankName;
    NSString *bankCode;
    NSArray *_bankImageArray;
    NSArray *_bankArray;
    NSInteger _cardFlag;
    NSString *_card_holder_;
    UIButton *btnSure;
    BOOL btnFlag;
}
@end

@implementation EnterAgainController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"到账到银行卡";
    bankNum = @"";
    bankCode = @"";
    bankName = @"";
    _card_holder_ = @"";
    btnFlag = 0;
    _createBankDict = @{@"2":@[@"工商银行",@"中国工商银行"],
                        @"1":@[@"中国银行"],
                        @"3":@[@"中国建设银行",@"建设银行"],
                        @"10":@[@"中国光大银行",@"光大银行"],
                        @"6":@[@"中国民生银行",@"民生银行"],
                        @"9":@[@"兴业银行"],
                        @"8":@[@"中信银行"],
                        @"5":@[@"上海浦东发展银行",@"浦东发展银行",@"浦发银行"],
                        @"28":@[@"平安银行"]
                        };
    _bankImageArray = @[@"bank_ICBC",@"bank_boc",@"bank_CBC",
                        @"bank_CEB",@"bank_CMSZ",@"bank_CIB",
                        @"bank_CITIC",@"bank_spd",@"pinganbank"];
    _bankArray = @[@"中国工商银行",@"中国银行",@"中国建设银行",
                   @"中国光大银行",@"中国民生银行",@"兴业银行",
                   @"中信银行",@"浦发银行",@"平安银行"];

    [self addBackItem];
    [self PostGetBankCardCheck];
    
}
-(void)createUI
{
    self.view.backgroundColor=rgb(245, 245, 245);
    
    UIView *backView=[[UIView alloc]initWithFrame:CGRectMake(0, 64+10*_k_WSwitch, _k_w, 150*_k_WSwitch)];
    backView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:backView];
    
    
    NSArray *titAry=@[@"姓名",@"卡号"];
    for(int i=0;i<3;i++)
    {
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, i*50*_k_WSwitch, _k_w, 50*_k_WSwitch)];
        
        UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(20*_k_WSwitch,view.frame.size.height-1 ,_k_w- 20*_k_WSwitch, 1)];
        lineView.backgroundColor=rgb(214, 214, 214);
        [view addSubview:lineView];
        
        if(i==2)
        {
            bankImg=[[UIImageView alloc]initWithFrame:CGRectMake(20*_k_WSwitch, 7.5*_k_WSwitch, 35*_k_WSwitch, 35*_k_WSwitch)];
//            bankImg.backgroundColor=[UIColor redColor];
            bankImg.image = [UIImage imageNamed:_bankImageArray[_cardFlag]];
            [view addSubview:bankImg];
            
            UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake([self getView:bankImg]+20*_k_WSwitch, 7.5*_k_WSwitch, _k_w-[self getView:bankImg]-40*_k_WSwitch, 35*_k_WSwitch)];
            [view addSubview:lbl];
            
            if(_k_w==320)
            {
                lbl.font=[UIFont systemFontOfSize:14];
            }
            else
            {
                lbl.font=[UIFont systemFontOfSize:17];
            }
            lbl.tag=50+i;
            //银行明
            lbl.text = _bankArray[_cardFlag];
            lineView.hidden=YES;
        }
        else
        {
            UILabel *titleLbl=[[UILabel alloc]initWithFrame:CGRectMake(20*_k_WSwitch, 7.5*_k_WSwitch, 35*_k_WSwitch, 35*_k_WSwitch)];
            if(_k_w==320)
            {
                titleLbl.font=[UIFont systemFontOfSize:14];
            }
            else
            {
                titleLbl.font=[UIFont systemFontOfSize:17];
            }
            titleLbl.textColor=rgb(74, 74, 74);
            titleLbl.textAlignment=NSTextAlignmentRight;
            titleLbl.text=titAry[i];
            [view addSubview:titleLbl];
            
            UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake([self getView:titleLbl]+20*_k_WSwitch, 7.5*_k_WSwitch, _k_w-[self getView:titleLbl]-40*_k_WSwitch, 35*_k_WSwitch)];
            lbl.tag=50+i;
            [view addSubview:lbl];
            lineView.hidden=NO;
            if(_k_w==320)
            {
                titleLbl.font=[UIFont systemFontOfSize:14];
                lbl.font=[UIFont systemFontOfSize:14];
            }
            else
            {
                titleLbl.font=[UIFont systemFontOfSize:17];
                lbl.font=[UIFont systemFontOfSize:17];
            }
            if (i == 0) {
                lbl.text = _card_holder_;
            }
            if (i == 1) {
                lbl.text = bankNum;
            }
            
            
        }
        [backView addSubview:view];
    }
    
    UIImageView *warmingImg=[[UIImageView alloc]initWithFrame:CGRectMake(20*_k_WSwitch, [self getViewH:backView]+25*_k_WSwitch, 20*_k_WSwitch, 20*_k_WSwitch)];
//    warmingImg.backgroundColor=[UIColor blueColor];
    warmingImg.image = [UIImage imageNamed:@"20160513_icon-2x"];
    [self.view addSubview:warmingImg];
    
    UILabel *warmingLbl=[[UILabel alloc]initWithFrame:CGRectMake([self getView:warmingImg]+3*_k_WSwitch, warmingImg.frame.origin.y, 200, 20*_k_WSwitch)];
    warmingLbl.textColor=rgb(74, 74, 74);
    warmingLbl.text=@"您确认后我们会尽快到账";
    warmingLbl.font=[UIFont systemFontOfSize:12];
    [self.view addSubview:warmingLbl];
    
    btnSure=[UIButton buttonWithType:UIButtonTypeCustom];
    btnSure.frame=CGRectMake(17*_k_WSwitch, [self getViewH:warmingLbl]+50*_k_WSwitch, 341*_k_WSwitch, 51*_k_WSwitch);
    [btnSure setBackgroundImage:[UIImage imageNamed:@"8_but_04"] forState:UIControlStateNormal];
    [btnSure addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [btnSure setEnabled:btnFlag];
    [self.view addSubview:btnSure];
}
-(CGFloat)getView:(UIView*)view
{
    return view.frame.origin.x+view.frame.size.width;
}
-(CGFloat)getViewH:(UIView*)view
{
    return view.frame.origin.y+view.frame.size.height;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)sureBtnClick
{
    NSLog(@"提交二次进件");
    [self PostGetdrawApplyAgain];
}
#pragma mark -> 银行卡读取接口
-(void)PostGetBankCardCheck
{
   
                if (_userCardModel.result.count >0) {
                    CardResult *cardResult = _userCardModel.result[0];
                    bankNum = [self formatString:cardResult.card_no_];
                    bankCode = cardResult.card_bank_;
                    _card_holder_ = cardResult.card_holder_;
                    
                    switch ([bankCode integerValue]) {
                        case 2:
                            _cardFlag = 0;
                            break;
                        case 1:
                            _cardFlag = 1;
                            break;
                        case 3:
                            _cardFlag = 2;
                            break;
                        case 10:
                            _cardFlag = 3;
                            break;
                        case 6:
                            _cardFlag = 4;
                            break;
                        case 9:
                            _cardFlag = 5;
                            break;
                        case 8:
                            _cardFlag = 6;
                            break;
                        case 5:
                            _cardFlag = 7;
                            break;
                        case 28:
                            _cardFlag = 8;
                            break;
                        default:
                            _cardFlag = 100;
                            break;
                    }
                    
                    if (_cardFlag == 100) {
                        
                    }else{
                        
                        bankName = _bankArray[_cardFlag];
                        bankImg.image = [UIImage imageNamed:_bankImageArray[_cardFlag]];
                        
                    }
                    btnFlag = 1;
                    [self createUI];
                    
                }
                
                
}

#pragma mark -> 二次提款
-(void)PostGetdrawApplyAgain
{
    CardResult *cardRsult = _userCardModel.result[0];
    NSDictionary *paramDic = @{@"periods_":_periods_,
                               @"drawing_amount_":_drawing_amount_,
                               @"account_card_id_":cardRsult.id_
                               };
    //银行卡四要素验证
    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_drawApplyAgain_jhtml] parameters:paramDic finished:^(EnumServerStatus status, id object) {
        if (status == Enum_SUCCESS) {
            if ([[object objectForKey:@"flag"]isEqualToString:@"0000"]) {
               
                LoanMoneyViewController *loanVC =[LoanMoneyViewController new];
                [self.navigationController pushViewController:loanVC animated:YES];
                
            } else {
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:[object objectForKey:@"msg"]];
            }
        }
    } failure:^(EnumServerStatus status, id object) {
       
    }];
}

- (NSString *)formatString:(NSString *)str
{
//    NSMutableString *tempStr = [NSMutableString string];
//    for (NSInteger i = 0; i < str.length - 5; i++) {
//        [tempStr appendString:@"*"];
//    }
//    
//    NSMutableString *returnStr = [NSMutableString stringWithString:[str stringByReplacingCharactersInRange:NSMakeRange(1, str.length - 5) withString:tempStr]];
    NSMutableString *returnStr = [NSMutableString stringWithString:str];
    NSMutableString *ss = [NSMutableString string];
    for (NSInteger i = 0; i < returnStr.length; i++) {
        unichar c = [returnStr characterAtIndex:i];
        if (i > 0) {
            if (i%4 == 0) {
                [ss appendFormat:@" %C",c];
            } else {
                [ss appendFormat:@"%C",c];
            }
        } else {
            [ss appendFormat:@"%C",c];
        }
        
        if (i == returnStr.length) {
            [ss replaceCharactersInRange:NSMakeRange(returnStr.length, 1) withString:@""];
        }
    }
    
    return ss;
}


@end
