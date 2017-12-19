//
//  ShowMsgPreviewModel.h
//  fxdProduct
//
//  Created by sxp on 2017/12/6.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol OperUserMassgeModel <NSObject>


@end

@interface ShowMsgPreviewModel : JSONModel

//翻页数
@property (nonatomic, strong)NSString<Optional> *limit;
//当前页
@property (nonatomic, strong)NSString<Optional> * offset;
//消息总条数
@property (nonatomic, strong)NSString<Optional> *pageCount;
//用户ID
@property (nonatomic, strong)NSString<Optional> * userId;
//详细展示URL需拼接msgId
@property (nonatomic, strong)NSString<Optional> * requestUrl;
//用户站内信
@property(nonatomic,strong)NSArray<OperUserMassgeModel,Optional> * operUserMassge;

@end

@interface OperUserMassgeModel : JSONModel

//创建日期
@property (nonatomic, strong)NSString<Optional> *createDate;
//站内信ID
@property (nonatomic, strong)NSString<Optional> * id_;
//是否已读 1未读 2 已读
@property (nonatomic, strong)NSString<Optional> *isRead;
//消息名称
@property (nonatomic, strong)NSString<Optional> * msgName;
//消息文案
@property (nonatomic, strong)NSString<Optional> * msgText;

@end
