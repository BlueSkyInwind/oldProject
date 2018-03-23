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
@protocol ReimbursementWayModel<NSObject>
@end


@interface ApplicaitonModel : JSONModel

@property(nonatomic,strong)NSString<Optional> * baseId;
@property(nonatomic,strong)NSString<Optional> * loanAmount;
@property(nonatomic,strong)NSString<Optional> * loanFor;
@property(nonatomic,strong)NSString<Optional> * periods;
@property(nonatomic,strong)NSString<Optional> * platformCode;
@property(nonatomic,strong)NSString<Optional> * productId;
@property(nonatomic,strong)NSString<Optional> * stagingType;

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
@property(nonatomic,strong)NSString<Optional> * answer;
@property(nonatomic,strong)NSString<Optional> * example;
@property(nonatomic,strong)NSString<Optional> * question;
@property(nonatomic,strong)NSArray<DiscountTicketDetailModel,Optional> * voucher;
@property(nonatomic,strong)NSArray<ReimbursementWayModel,Optional> * stagingTypeList;
//计算模型结果
@property(nonatomic,strong)NSString<Optional> * repaymentAmount;

@end

@interface LoanMoneyFor : JSONModel

@property(nonatomic,strong)NSString<Optional> * code_;
@property(nonatomic,strong)NSString<Optional> * desc_;

@end

@interface ReimbursementWayModel: JSONModel

@property(nonatomic,strong)NSString<Optional> * stagingType;
@property(nonatomic,strong)NSString<Optional> * typeText;
@property(nonatomic,strong)NSArray<Optional> * validStagingList;
@property(nonatomic,strong)NSString<Optional> * duration;
@property(nonatomic,strong)NSString<Optional> * durationUnit;
@property(nonatomic,strong)NSString<Optional> * example;

@end

@interface ApplicaitonCalculateParamModel : JSONModel

@property(nonatomic,strong)NSString<Optional> * loanAmount;
@property(nonatomic,strong)NSString<Optional> * periods;
@property(nonatomic,strong)NSString<Optional> * productId;
@property(nonatomic,strong)NSString<Optional> * voucherAmount;
@property(nonatomic,strong)NSString<Optional> * stagingType;



@end


