//
//  QryUserStatusModel.h
//  fxdProduct
//
//  Created by sxp on 17/5/31.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QryUserStatusModel : NSObject

/**/
@property (nonatomic,copy)NSString *appCode;
@property (nonatomic,copy)NSString *appmsg;
/*2、未开户 3、待激活 4、冻结 5、销户 6、正常7，已注册*/
@property (nonatomic,copy)NSString *flg;

@property (nonatomic,copy)NSString *juid;

@end
