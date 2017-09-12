//
//  UserBankCardListViewController.h
//  fxdProduct
//
//  Created by admin on 2017/8/25.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "BaseViewController.h"
#import "SupportBankList.h"
@class BankModel;
@class CardInfo;


typedef void(^BankSelectBlock)(CardInfo * cardInfo, NSInteger currentIndex);

@interface UserBankCardListViewController : BaseViewController

@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, copy) BankSelectBlock bankSelectBlock;

@property (nonatomic, assign) BOOL isHavealipay;

//swift调用
-(void)userSelectedBankCard:(BankSelectBlock)block;

@end
