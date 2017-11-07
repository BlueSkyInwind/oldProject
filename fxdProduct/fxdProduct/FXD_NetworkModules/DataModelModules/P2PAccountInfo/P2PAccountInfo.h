//
//  P2PAccountInfo.h
//  fxdProduct
//
//  Created by dd on 2016/10/11.
//  Copyright © 2016年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>
@class P2PAccountData,AccountInfo;

@interface P2PAccountInfo : NSObject

@property (nonatomic, copy)NSString *appcode;

@property (nonatomic, strong)P2PAccountData *data;

@end


@interface P2PAccountData : NSObject

@property (nonatomic, copy)NSString *appcode;

@property (nonatomic, assign)BOOL success;

@property (nonatomic, strong)AccountInfo *accountInfo;

@end

/*
 user_id_   用户id
 
 user_name_ 用户姓名
 
 id_number_ 身份证
 
 mer_id_    商户ID
 
 user_cus_id_   汇付账号
 
 balance_   账户余额
 
 available_amount_  可用余额
 
 frozen_amount_     冻结金额
 
 tender_plan_mark_   1:开 2:关

 */

@interface AccountInfo : NSObject

@property (nonatomic, copy)NSString *user_name_;

@property (nonatomic, copy)NSString *update_time_;

@property (nonatomic, assign)CGFloat available_amount_;

@property (nonatomic, copy)NSString *id_;

@property (nonatomic, assign)CGFloat frozen_amount_;

@property (nonatomic, copy)NSString *mer_id_;

@property (nonatomic, copy)NSString *user_cus_id_;

@property (nonatomic, copy)NSString *user_id_;

@property (nonatomic, copy)NSString *id_number_;

@property (nonatomic, assign)CGFloat balance_;

@property (nonatomic, copy)NSString *create_time_;

@end
