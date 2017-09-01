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
@property(nonatomic,strong)NSString<Optional> * fee;
@property(nonatomic,strong)NSArray<LoanForModel *> * loanFor;
@property(nonatomic,strong)NSString<Optional> * maxPeriod;
@property(nonatomic,strong)NSString<Optional> * minPeriod;
@property(nonatomic,strong)NSString<Optional> * numDaysPerPeriod;
@property(nonatomic,strong)NSString<Optional> * platformType;
@property(nonatomic,strong)NSString<Optional> * productId;
@property(nonatomic,strong)NSString<Optional> * repayAmount;
@property(nonatomic,strong)NSString<Optional> * userAgain;
@property(nonatomic,strong)NSString<Optional> * userStatus;


@end







