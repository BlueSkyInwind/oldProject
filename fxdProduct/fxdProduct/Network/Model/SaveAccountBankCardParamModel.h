//
//  SaveAccountBankCardParamModel.h
//  fxdProduct
//
//  Created by sxp on 17/6/9.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface SaveAccountBankCardParamModel : JSONModel

@property (nonatomic,copy)NSString *card_bank_;
@property (nonatomic,copy)NSString *card_type_;
@property (nonatomic,copy)NSString *card_no_;
@property (nonatomic,copy)NSString *bank_reserve_phone_;
@property (nonatomic,copy)NSString *verify_code_;

@end
