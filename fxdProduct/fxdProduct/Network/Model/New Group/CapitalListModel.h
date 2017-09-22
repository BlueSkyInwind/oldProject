//
//  CapitalListModel.h
//  fxdProduct
//
//  Created by sxp on 2017/9/22.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface CapitalListModel : JSONModel

//平台标识  前后台传输的唯一标识
@property (nonatomic, strong)NSString<Optional> *platformCode;
//平台图标（暂时没用）
@property (nonatomic, strong)NSString<Optional> * platformIcon;
//平台名称
@property (nonatomic, strong)NSString<Optional> * platformName;

@end
