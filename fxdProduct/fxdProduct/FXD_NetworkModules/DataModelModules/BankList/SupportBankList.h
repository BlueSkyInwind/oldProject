//
//  SupportBankList.h
//  fxdProduct
//
//  Created by admin on 2017/8/2.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface SupportBankList : JSONModel


@property (nonatomic, copy)NSString<Optional> *bank_code_;
@property (nonatomic, copy)NSString<Optional> *bank_name_;
@property (nonatomic, copy)NSString<Optional> *bank_short_name_;
@property (nonatomic, copy)NSString<Optional> *icon_url_;
@property (nonatomic, copy)NSString<Optional> *id_;

@end
