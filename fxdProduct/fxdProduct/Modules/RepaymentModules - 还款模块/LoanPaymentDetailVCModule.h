//
//  LoanPaymentDetailVCModule.h
//  fxdProduct
//
//  Created by zy on 16/9/1.
//  Copyright © 2016年 dd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@class BankModel,RepayListInfo,Situations,BillList,P2PBillDetail,UserStateModel;

typedef NS_ENUM(NSUInteger, RepayType) {
    RepayTypeOption = 0,
    RepayTypeClean,
};


@interface LoanPaymentDetailVCModule : BaseViewController
@property (weak, nonatomic) IBOutlet UITableView *PayDetailTB;
- (IBAction)btnSureClick:(UIButton *)sender;


@property (nonatomic,strong)BankModel *bankModel;
@property (nonatomic,strong)NSMutableArray *supportBankListArr;

@property (nonatomic,strong)RepayListInfo *repayListInfo;

@property (nonatomic, assign)CGFloat repayAmount;

@property (nonatomic, strong)NSArray<NSNumber *> *cellSelectArr;

@property (nonatomic, assign) CGFloat save_amount;

@property (nonatomic, strong) NSArray<Situations *> *situations;

@property (nonatomic, assign) RepayType repayType;

@property (nonatomic, strong) P2PBillDetail *p2pBillModel;

@property (nonatomic, strong) NSArray<BillList *> *bills;

//页面必须信息
@property (nonatomic, copy) NSString *product_id;
@property (nonatomic, copy) NSString *applicationID;
@property (nonatomic, copy) NSString *platform_Type;

@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@property (nonatomic,assign)BOOL isPopRoot;

@end
