//
//  CapitalLoanParam.h
//  fxdProduct
//
//  Created by sxp on 2017/9/25.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface CapitalLoanParam : JSONModel

//银行卡id
@property (nonatomic,strong)NSString * cardId;
//接口用途
@property (nonatomic,strong)NSString * loanfor;
//借款周期（急速贷传1）
@property (nonatomic,strong)NSString * periods;

@end
