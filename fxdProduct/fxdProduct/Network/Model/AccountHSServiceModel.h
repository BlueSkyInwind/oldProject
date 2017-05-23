//
//  AccountHSServiceModel.h
//  fxdProduct
//
//  Created by sxp on 17/5/23.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountHSServiceModel : NSObject

//2、未开户 3、待激活 4、冻结 5、销户 6、正常
@property (nonatomic,copy)NSString *flg;
//用户合规用户号
@property (nonatomic,copy)NSString *juid;

@end
