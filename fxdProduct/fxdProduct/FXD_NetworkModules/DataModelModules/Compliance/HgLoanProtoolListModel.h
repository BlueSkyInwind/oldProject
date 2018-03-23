//
//  HgLoanProtoolListModel.h
//  fxdProduct
//
//  Created by sxp on 2018/3/20.
//  Copyright © 2018年 dd. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface HgLoanProtoolListModel : JSONModel

//默认银行名称
@property (nonatomic, strong)NSString<Optional> *inverBorrowId;
//银行卡号
@property (nonatomic, strong)NSString<Optional> *protocolName;

@end
