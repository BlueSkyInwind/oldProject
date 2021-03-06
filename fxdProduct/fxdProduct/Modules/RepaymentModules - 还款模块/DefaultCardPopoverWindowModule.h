//
//  DefaultCardPopoverWindowModule.h
//  fxdProduct
//
//  Created by dd on 16/7/15.
//  Copyright © 2016年 dd. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CardInfo;
@class BankModel;


typedef NS_ENUM(NSUInteger, PayType) {
    PayTypeWeekPay = 0,
    PayTypeCleanPay,
    PayTypeGetMoneyToCard,
};
//typedef void(^MakeSurePayBlock)(PayType payType,CardInfo *cardInfo,NSInteger currentIndex);
typedef void(^MakeSurePayBlock)(PayType payType);

typedef void(^ChangeBankBlock)(void);
@interface DefaultCardPopoverWindowModule : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *myTableview;

@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@property (nonatomic, strong)MakeSurePayBlock makesureBlock;
@property (nonatomic, strong)ChangeBankBlock  changeBankBlock;
// 付款还是提款
@property (nonatomic, assign)PayType payType;

@property (nonatomic, strong) CardInfo *cardInfo;

@property (nonatomic, copy) NSString *shouldAmount;

@property (nonatomic, assign) NSInteger banckCurrentIndex;

//BankModel *_bankCardModel;
@property (nonatomic, strong) BankModel *bankCardModel;
@property (nonatomic, strong) NSMutableArray * supportBankListArr;

@property (nonatomic,assign)BOOL isP2P;

//银行卡名字
@property (nonatomic,copy)NSString *bankName;
//银行卡尾号
@property (nonatomic,copy)NSString *banNum;


@end
