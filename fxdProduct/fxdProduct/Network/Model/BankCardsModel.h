//
//  BankCardsModel.h
//  fxdProduct
//
//  Created by sxp on 17/5/22.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BankCardsDataModel;

@interface BankCardsModel : NSObject


//结果描述
@property (nonatomic,copy)NSString *appmsg;

@property (nonatomic,strong)BankCardsDataModel *data;

@end


@interface BankCardsDataModel : NSObject

//结果标志   true false
@property (nonatomic,copy)NSString *success;
//结果对照码   1发送成功 -1发送失败
@property (nonatomic,copy)NSString *appcode;

@end
