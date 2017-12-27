//
//  ProtocolParamModel.h
//  fxdProduct
//
//  Created by admin on 2017/12/27.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface ProtocolParamModel : JSONModel

@property(nonatomic,strong)NSString<Optional> * apply_id_;
@property(nonatomic,strong)NSString<Optional> * periods_;
@property(nonatomic,strong)NSString<Optional> * product_id_;
@property(nonatomic,strong)NSString<Optional> * protocol_type_;

@end
