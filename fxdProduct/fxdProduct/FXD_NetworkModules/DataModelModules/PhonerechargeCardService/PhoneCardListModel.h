//
//  PhoneCardListModel.h
//  fxdProduct
//
//  Created by admin on 2018/6/7.
//  Copyright © 2018年 dd. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface PhoneCardListModel : JSONModel

@property (nonatomic,strong)NSString<Optional> * cardid;
@property (nonatomic,strong)NSString<Optional> * displayCardName;
@property (nonatomic,strong)NSString<Optional> * createTime;
@property (nonatomic,strong)NSString<Optional> * inStock;    //库存
@property (nonatomic,strong)NSString<Optional> * ofpayProductNumber;
@property (nonatomic,strong)NSString<Optional> * perValue;   //面值
@property (nonatomic,strong)NSString<Optional> * sellingPrice;   //售价
@property (nonatomic,strong)NSString<Optional> * smallIconUrl;
@property (nonatomic,strong)NSString<Optional> * status;   //上架状态  1、未上架 0、已上架
@property (nonatomic,strong)NSString<Optional> * bigIconUrl;
@property (nonatomic,strong)NSString<Optional> * operators;  //0：电信，1：移动，2：联通

@end
