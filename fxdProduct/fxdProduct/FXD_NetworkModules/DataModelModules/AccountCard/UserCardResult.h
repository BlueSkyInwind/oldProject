//
//  UserCardResult.h
//  fxdProduct
//
//  Created by dd on 16/7/29.
//  Copyright © 2016年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Ext,CardResult;
@interface UserCardResult : NSObject

@property (nonatomic, copy) NSString *flag;

@property (nonatomic, strong) Ext *ext;

@property (nonatomic, strong) NSArray<CardResult *> *result;

@property (nonatomic, copy) NSString *msg;

@end
@interface Ext : NSObject

@property (nonatomic, copy) NSString *mobile_phone_;

@end

@interface CardResult : NSObject

@property (nonatomic, copy) NSString *card_bank_;

@property (nonatomic, copy) NSString *card_no_;

@property (nonatomic, copy) NSString *card_type_;

@property (nonatomic, copy) NSString *id_;

@property (nonatomic, copy) NSString *bank_reserve_phone_;

@property (nonatomic, copy) NSString *card_holder_;

@property (nonatomic, copy) NSString *credentials_type_;

@property (nonatomic, copy) NSString *if_default_;

@property (nonatomic, copy) NSString *is_del_;

@property (nonatomic, copy) NSString *account_base_id_;

@property (nonatomic, copy) NSString *credentials_no_;

@end

