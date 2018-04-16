//
//  CollectionViewModel.h
//  fxdProduct
//
//  Created by sxp on 2018/4/12.
//  Copyright © 2018年 dd. All rights reserved.
//

#import "FXD_ViewModelBaseClass.h"

@interface CollectionViewModel : FXD_ViewModelBaseClass

//获取我的收藏记录列表

//limit   条数  每页显示量
//offset  偏移量 页数
//order   排序方式    升序：ASC;降序：DESC
//sort    排序字段    默认:0:priority;1:最高借款额度;2:借款费率;3:借款速度;4借款周期

-(void)getMyCollectionListLimit:(NSString *)limit offset:(NSString *)offset order:(NSString *)order sort:(NSString *)sort;


//添加或者取消收藏记录

//collectionType   收藏类型 1:贷款、2:游戏、3:旅游）
//platformId  平台id
-(void)addMyCollectionInfocollectionType:(NSString *)collectionType platformId:(NSString *)platformId;
@end
