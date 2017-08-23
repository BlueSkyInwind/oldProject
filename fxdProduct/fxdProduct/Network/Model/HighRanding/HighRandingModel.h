//
//  HighRandingModel.h
//  fxdProduct
//
//  Created by admin on 2017/8/23.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface HighRandingModel : JSONModel

@property(nonatomic,strong)NSString<Optional> * userid;
@property(nonatomic,strong)NSString<Optional> * taskid;
@property(nonatomic,strong)NSString<Optional> * type;
@property(nonatomic,strong)NSString<Optional> * result;
@property(nonatomic,strong)NSString<Optional> * resultid;  //1成功2评测中3失败


@end
