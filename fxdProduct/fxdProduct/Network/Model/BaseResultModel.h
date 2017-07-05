//
//  BaseResultModel.h
//  fxdProduct
//
//  Created by admin on 2017/7/5.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface BaseResultModel : JSONModel

@property (nonatomic, strong)NSString<Optional> *msg;
@property (nonatomic, strong)NSString<Optional> * flag;
@property (nonatomic, strong)id<Optional> result;


@end
