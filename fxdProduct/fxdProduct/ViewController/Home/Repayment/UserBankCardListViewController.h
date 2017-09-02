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

typedef NS_ENUM(NSUInteger, UserPayMethod) {
    UserPayMethodNormal = 0,
    UserPayMethodSelectBankCad,
};

typedef void(^BankSelectBlock)(CardInfo * cardInfo, NSInteger currentIndex);

@interface UserBankCardListViewController : BaseViewController

@property (nonatomic, strong)NSMutableArray *supportBankListArr;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) BankSelectBlock bankSelectBlock;
@property (nonatomic, assign) UserPayMethod payMethod;
  
-(void)tranferValue:(BankSelectBlock)block;
@end
