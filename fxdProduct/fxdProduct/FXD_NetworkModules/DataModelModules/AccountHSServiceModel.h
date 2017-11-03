//
//  AccountHSServiceModel.h
//  fxdProduct
//
//  Created by sxp on 17/5/23.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AccountHSServiceDataModel;

@interface AccountHSServiceModel : NSObject

//用户合规用户号
@property (nonatomic,strong)AccountHSServiceDataModel *data;
//返回状态码
@property (nonatomic,copy)NSString *appcode;

@end

@interface AccountHSServiceDataModel : NSObject

//2、未开户 3、待激活 4、冻结 5、销户 6、正常
@property (nonatomic,copy)NSString *flg;
//用户合规用户号
@property (nonatomic,copy)NSString *juid;
//结果描述
@property (nonatomic,copy)NSString *appmsg;

@end
