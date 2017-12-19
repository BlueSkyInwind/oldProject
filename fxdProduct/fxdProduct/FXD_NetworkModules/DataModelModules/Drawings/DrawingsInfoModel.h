//
//  DrawingsInfoModel.h
//  fxdProduct
//
//  Created by admin on 2017/9/1.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol LoanForModel <NSObject>


@end

@interface LoanForModel : JSONModel

@property(nonatomic,strong)NSString<Optional> * code;
@property(nonatomic,strong)NSString<Optional> * desc;

@end


@interface DrawingsInfoModel : JSONModel

@property(nonatomic,strong)NSString<Optional> * actualAmount;
@property(nonatomic,strong)NSString<Optional> * applicationId;
@property(nonatomic,strong)NSString<Optional> * dayServiceFeeRate;
@property(nonatomic,strong)NSString<Optional> * totalFee;
@property(nonatomic,strong)NSArray<LoanForModel> * loanFor;
@property(nonatomic,strong)NSString<Optional> * maxPeriod;
@property(nonatomic,strong)NSString<Optional> * minPeriod;
@property(nonatomic,strong)NSString<Optional> * period;
@property(nonatomic,strong)NSString<Optional> * numDaysPerPeriod;
@property(nonatomic,strong)NSString<Optional> * platformType;
@property(nonatomic,strong)NSString<Optional> * productId;
@property(nonatomic,strong)NSString<Optional> * repayAmount;          //授信额
@property(nonatomic,strong)NSString<Optional> * userAgain;
@property(nonatomic,strong)NSString<Optional> * userStatus;
@property(nonatomic,strong)NSString<Optional> * taskStatus;
@property(nonatomic,strong)NSString<Optional> * repaymentAmount;     //急速贷到期还款


@end

@protocol SalaryFeeDetailModel <NSObject>


@end

@interface SalaryFeeDetailModel : JSONModel

@property(nonatomic,strong)NSString<Optional> * index;
@property(nonatomic,strong)NSString<Optional> * label;
@property(nonatomic,strong)NSString<Optional> * unit;
@property(nonatomic,strong)NSString<Optional> * value;

@end

@interface SalaryDrawingsFeeInfoModel : JSONModel

@property(nonatomic,strong)NSArray<SalaryFeeDetailModel,Optional> * feeInfo;
@property(nonatomic,strong)NSString<Optional> * repaymentAmount;
@property(nonatomic,strong)NSString<Optional> * totalFee;

@end

@interface WithDrawalsParamModel : JSONModel

@property(nonatomic,strong)NSString<Optional> * periods;
@property(nonatomic,strong)NSString<Optional> * loanFor;
//@property(nonatomic,strong)NSString<Optional> * drawing_amount_;
@property(nonatomic,strong)NSString<Optional> * accountCardId;

@end













