//
//  HGBankListModel.h
//  fxdProduct
//
//  Created by admin on 2017/7/24.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface HGBankListModel : JSONModel

@property (nonatomic, strong)NSString<Optional> *desc_;
@property (nonatomic, strong)NSString<Optional> *id_;
@property (nonatomic, strong)NSString<Optional> *dic_index_id_;
@property (nonatomic, strong)NSString<Optional> *status_;
@property (nonatomic, strong)NSString<Optional> *code_;
@property (nonatomic, strong)NSString<Optional> *key_;

@end
