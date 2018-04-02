//
//  WithdrawCashDetailModel.h
//  fxdProduct
//
//  Created by sxp on 2017/12/4.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <JSONModel/JSONModel.h>


@protocol WithdrawCashDetailListModel <NSObject>


@end

@interface WithdrawCashDetailModel : JSONModel

@property(nonatomic,strong)NSArray<WithdrawCashDetailListModel,Optional> * withdrawCashDetailList;

@end


@interface WithdrawCashDetailListModel : JSONModel

@property(nonatomic,strong)NSString<Optional> * transAmount;
@property(nonatomic,strong)NSString<Optional> * transDate;
@property(nonatomic,strong)NSString<Optional> * detailName;

@end
