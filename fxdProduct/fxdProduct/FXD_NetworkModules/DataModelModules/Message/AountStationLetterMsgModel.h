//
//  AountStationLetterMsgModel.h
//  fxdProduct
//
//  Created by sxp on 2017/12/6.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface AountStationLetterMsgModel : JSONModel

//站内信统计数量
@property (nonatomic, strong)NSString<Optional> *countNum;
//当没有未读站内信时不展示红点
@property (nonatomic, strong)NSString<Optional> * isDisplay;

@end
