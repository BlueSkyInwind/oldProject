//
//  BankCardRecogPro.h
//  BankCardRecogPro
//
//  Created by wintone on 15/3/17.
//  Copyright (c) 2015年 wintone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WTSlideLine.h"
#import <UIKit/UIKit.h>

@interface BankCardRecogPro : NSObject

//授权
@property (nonatomic ,copy) NSString *nsResult;
@property (nonatomic ,copy) NSString *devcode;
@property (nonatomic ,copy) NSString *lpDirectory;

//识别结果
@property(copy, nonatomic) NSString *resultStr;
@property(strong, nonatomic) UIImage *resultImg;
@property(copy, nonatomic) NSString *bankName;
@property(copy, nonatomic) NSString *bankCode;
@property(copy, nonatomic) NSString *cardName;
@property(copy, nonatomic) NSString *cardType;

//初始化核心
-(int)InitBankCardWithDevcode:(NSString *)devcode;
//释放核心
- (void) recogFree;
//设置检边参数
- (void) setRoiWithLeft:(int)nLeft Top:(int)nTop Right:(int)nRight Bottom:(int)nBottom;
//识别
- (WTSlideLine *) RecognizeStreamNV21Ex:(UInt8 *)buffer Width:(int)width Height:(int)height;

/*
    根据银行卡号获取银行信息,cardNumber参数是内容为银行卡号的字符串；
    获取失败返回值为null，获取成功后银行信息保存在字典中；
    字典格式key值如下：
        bankCode = 机构代码;
        bankName = 银行名字
        cardNumber = 银行卡号
        cardType = 卡种
        cradName = 卡名
 */
- (NSDictionary *)getBankInfoWithCardNO:(NSString *)cardNumber;
@end
