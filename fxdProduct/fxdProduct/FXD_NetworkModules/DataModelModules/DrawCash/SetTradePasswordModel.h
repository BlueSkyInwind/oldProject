//
//  SetTradePasswordModel.h
//  fxdProduct
//
//  Created by admin on 2017/11/24.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface SetTradePasswordParam : JSONModel

@property (nonatomic,strong)NSString <Optional> * firstPassword;
@property (nonatomic,strong)NSString <Optional> * type;
@property (nonatomic,strong)NSString <Optional> * secondPassword;
@property (nonatomic,strong)NSString <Optional> * oldPassword;
@property (nonatomic,strong)NSString <Optional> * verify_code;

@end

@interface SetTradePasswordModel : JSONModel

@property (nonatomic,strong)NSString <Optional> * amount;
@property (nonatomic,strong)NSString <Optional> * message;
@property (nonatomic,strong)NSString <Optional> * status;

@end


