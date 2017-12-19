//
//  RegionCodeParam.h
//  fxdProduct
//
//  Created by admin on 2017/12/7.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface RegionCodeParam : JSONModel

@property (nonatomic, strong)NSString<Optional> *provinceName;
@property (nonatomic, strong)NSString<Optional> *cityName;
@property (nonatomic, strong)NSString<Optional> *districtName;

@end
