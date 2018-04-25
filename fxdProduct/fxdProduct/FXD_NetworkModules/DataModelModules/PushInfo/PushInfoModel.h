//
//  PushInfoModel.h
//  fxdProduct
//
//  Created by admin on 2018/4/24.
//  Copyright © 2018年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PushInfoModel : JSONModel

@property(nonatomic,strong)NSString<Optional> * type;
@property(nonatomic,strong)NSString<Optional> * url;
@property(nonatomic,strong)NSString<Optional> * messageID;


@end
