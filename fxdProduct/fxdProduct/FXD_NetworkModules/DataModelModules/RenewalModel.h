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

//溢缴金
@property (strong,nonatomic)NSString<Optional> * balanceFee;
//续期费用
@property (strong,nonatomic)NSString<Optional> * extensionFee;
//逾期费用
@property (strong,nonatomic)NSString<Optional> * overdueAmount;
//应付金额
@property (strong,nonatomic)NSString<Optional> * shallPayFee;


@end

