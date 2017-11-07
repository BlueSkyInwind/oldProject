//
//  UserBankCardListVCModule.h
//  fxdProduct
//
//  Created by admin on 2017/8/25.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "BaseViewController.h"
#import "SupportBankList.h"
@class BankModel;
@class CardInfo;

//typedef void(^PayPatternSelectBlock)(CardInfo * cardInfo, NSInteger currentIndex , PatternOfChoose patternOfChoose ,NSString * patternName);
typedef void(^PayPatternSelectBlock)(CardInfo * cardInfo, NSInteger currentIndex);

@interface UserBankCardListVCModule : BaseViewController

@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, copy) PayPatternSelectBlock payPatternSelectBlock;

//swift调用
-(void)userSelectedBankCard:(PayPatternSelectBlock)block;

@end
