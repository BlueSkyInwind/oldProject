//
//  ApplicaitonModel.h
//  fxdProduct
//
//  Created by admin on 2017/9/1.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "DiscountTicketModel.h"

@protocol LoanMoneyFor<NSObject>
@end
@protocol DiscountTicketDetailModel<NSObject>
@end

@interface ApplicaitonModel : JSONModel



@end

@interface ApplicaitonViewInfoModel : JSONModel

@property(nonatomic,strong)NSArray<Optional> * detail;
@property(nonatomic,strong)NSString<Optional> * icon;
@property(nonatomic,strong)NSString<Optional> * productName;
@property(nonatomic,strong)NSArray<Optional> * special;
@property(nonatomic,strong)NSString<Optional> * amount;

//新版
@property(nonatomic,strong)NSArray<Optional,LoanMoneyFor> * loanFor;
@property(nonatomic,strong)NSArray<Optional> * amountList;
@property(nonatomic,strong)NSString<Optional> * actualAmount;
@property(nonatomic,strong)NSString<Optional> * maxAmount;
@property(nonatomic,strong)NSString<Optional> * maxPeriod;
@property(nonatomic,strong)NSString<Optional> * minPeriod;
@property(nonatomic,strong)NSString<Optional> * period;
@property(nonatomic,strong)NSString<Optional> * repayAmount;
@property(nonatomic,strong)NSString<Optional> * tips;
@property(nonatomic,strong)NSArray<DiscountTicketDetailModel,Optional> * voucher;

@end


@interface LoanMoneyFor : JSONModel

@property(nonatomic,strong)NSString<Optional> * code_;
@property(nonatomic,strong)NSString<Optional> * desc_;

@end


