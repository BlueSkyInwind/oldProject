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


typedef void(^PayPatternSelectBlock)(CardInfo * cardInfo, NSInteger currentIndex , PatternOfPayment patternOfPayment);

@interface UserBankCardListViewController : BaseViewController

@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, copy) PayPatternSelectBlock payPatternSelectBlock;

@property (nonatomic, assign) BOOL isHavealipay;

@property (nonatomic,assign)PatternOfPayment payPattern;

//swift调用
-(void)userSelectedBankCard:(PayPatternSelectBlock)block;

@end
