//
//  DrawLotteryModel.h
//  fxdProduct
//
//  Created by sxp on 2017/11/8.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface DrawLotteryModel : JSONModel

//1 是 2 否    是否可以抽奖
@property (nonatomic, strong)NSString<Optional> *isActivety;
//H5抽奖URL
@property (nonatomic, strong)NSString<Optional> * luckDraw;


@end
