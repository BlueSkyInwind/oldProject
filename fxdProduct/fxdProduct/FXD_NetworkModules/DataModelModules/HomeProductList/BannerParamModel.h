//
//  BannerParamModel.h
//  fxdProduct
//
//  Created by admin on 2018/7/9.
//  Copyright © 2018年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BannerParamModel : JSONModel


@property (nonatomic, strong)NSString<Optional> *mobile;

@property (nonatomic, strong)NSString<Optional> *url;

@property (nonatomic, strong)NSString<Optional> *linkType;  //来自于接口返回的 isPlatformLinks字段

@end
