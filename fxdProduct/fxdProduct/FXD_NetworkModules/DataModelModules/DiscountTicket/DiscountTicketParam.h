//
//  DiscountTicketParam.h
//  fxdProduct
//
//  Created by admin on 2017/11/15.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface DiscountTicketParam : JSONModel


@property(nonatomic,strong)NSString<Optional> * displayType;
@property(nonatomic,strong)NSString<Optional> * pageNum;
@property(nonatomic,strong)NSString<Optional> * pageSize;
@property(nonatomic,strong)NSString<Optional> * product_id;



@end
