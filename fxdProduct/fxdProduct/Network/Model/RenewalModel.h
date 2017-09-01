//
//  RenewalModel.h
//  fxdProduct
//
//  Created by sxp on 2017/9/1.
//  Copyright © 2017年 dd. All rights reserved.
//


#import <JSONModel/JSONModel.h>
//@class RenewalDataModel;

@interface RenewalModel : JSONModel


@property (strong,nonatomic)NSString<Optional> * balanceFee;
@property (strong,nonatomic)NSString<Optional> * extensionFee;
@property (strong,nonatomic)NSString<Optional> * overdueAmount;
@property (strong,nonatomic)NSString<Optional> * shallPayFee;


//@property (nonatomic , copy) NSString              * errCode;
//@property (nonatomic , strong) RenewalDataModel              * data;
//@property (nonatomic , copy) NSString              * errMsg;
//@property (nonatomic , copy) NSString              * friendErrMsg;

@end

//@interface RenewalDataModel : NSObject
//
////溢缴金
//@property (nonatomic , copy)NSString *balanceFee;
////续期费用
//@property (nonatomic , copy)NSString *extensionFee;
////逾期费用
//@property (nonatomic , copy)NSString *overdueAmount;
////应付金额
//@property (nonatomic , copy)NSString *shallPayFee;
//
//@end
