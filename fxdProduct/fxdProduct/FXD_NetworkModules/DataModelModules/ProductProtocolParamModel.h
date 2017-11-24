//
//  ProductProtocolParamModel.h
//  fxdProduct
//
//  Created by sxp on 17/6/9.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface ProductProtocolParamModel : JSONModel

@property (nonatomic,copy)NSString *apply_id_;
@property (nonatomic,copy)NSString *product_id_;
@property (nonatomic,copy)NSString *protocol_type_;
@property (nonatomic,copy)NSString *card_no_;
@property (nonatomic,copy)NSString *card_bank_;
@property (nonatomic,copy)NSString *periods_;
@end
