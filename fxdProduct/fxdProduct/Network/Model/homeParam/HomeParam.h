//
//  HomeParam.h
//  fxdProduct
//
//  Created by admin on 2017/8/17.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeParam : JSONModel

@property(nonatomic,strong)NSString<Optional> * platformType;
@property(nonatomic,strong)NSString<Optional> * channel_;
@property(nonatomic,strong)NSString<Optional> * position_;
@property(nonatomic,strong)NSString<Optional> * juid;
@property(nonatomic,strong)NSString<Optional> * token;

@end
