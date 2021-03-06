//
//  PayMethodViewController.h
//  fxdProduct
//
//  Created by dd on 16/7/18.
//  Copyright © 2016年 dd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SupportBankList.h"
@class BankModel;
@class CardInfo;

typedef NS_ENUM(NSUInteger, PayMethod) {
    PayMethodNormal = 0,
    PayMethodSelectBankCad,
};

typedef void(^BankSelectBlock)(CardInfo *cardInfo, NSInteger currentIndex);

@interface PayMethodViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong)BankModel *bankModel;
@property (nonatomic, strong)NSMutableArray *supportBankListArr;

@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, copy) BankSelectBlock bankSelectBlock;

@property (nonatomic, assign) PayMethod payMethod;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;


-(void)tranferValue:(BankSelectBlock)block;

@end
