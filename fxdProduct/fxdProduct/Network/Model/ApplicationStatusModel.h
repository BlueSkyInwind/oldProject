//
//  ApplicationStatusModel.h
//  fxdProduct
//
//  Created by sxp on 2017/9/2.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol InfoListModel <NSObject>


@end

@interface ApplicationStatusModel : JSONModel

//进件平台类型
@property(nonatomic,strong)NSString<Optional> * platformType;
//状态 1 进行中 2 成功 3失败 4 第三方未受理
@property(nonatomic,strong)NSString<Optional> * status;
//合规用户状态
@property(nonatomic,strong)NSString<Optional> * userStatus;
//展示数据
@property(nonatomic,strong)NSArray<InfoListModel> * infoList;

@end

@interface InfoListModel : JSONModel

//序号
@property(nonatomic,strong)NSString<Optional> * index;
//上边标题
@property(nonatomic,strong)NSString<Optional> * label;
//数值的单位
@property(nonatomic,strong)NSString<Optional> * unit;
//下边对应值
@property(nonatomic,strong)NSString<Optional> * value;

@end
