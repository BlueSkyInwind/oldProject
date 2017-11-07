//
//  UserStateModel.h
//  fxdProduct
//
//  Created by zy on 16/3/25.
//  Copyright © 2016年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserStateModel : NSObject

@property (nonatomic,strong) NSString *productId;
@property (nonatomic,strong) NSString *applyStatus;    
@property (nonatomic,strong) NSString *modifyDate;
@property (nonatomic,strong) NSString *validStatus;
@property (nonatomic,strong) NSString *days;
@property (nonatomic,strong) NSString *identifier;
@property (nonatomic,strong) NSString *applyFlag;
@property (nonatomic,strong) NSString *applyAgain;
@property (nonatomic,strong) NSString *applyID;
@property (nonatomic,strong) NSString *taskStatus;
@property (nonatomic, copy) NSString *platform_type;   //渠道类型  0 ： 发薪贷   2：合规 
@property (nonatomic, copy) NSString *qq_status;
@property (nonatomic, copy) NSString *zfb_status;
@property (nonatomic, assign) BOOL if_add_documents;
@property (nonatomic, copy) NSString *product_id;
@property (nonatomic, copy) NSString *case_info_id;
@property (nonatomic, copy) NSString *bid_id_;
@property (nonatomic, copy) NSString *pre_prove_amt_;
@property (nonatomic, copy) NSString *merchant_status;     //判断渠道，非渠道用户
@end
