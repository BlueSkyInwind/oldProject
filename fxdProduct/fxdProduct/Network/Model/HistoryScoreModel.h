//
//  HistoryScoreModel.h
//  fxdProduct
//
//  Created by zhangbaochuan on 15/10/23.
//  Copyright © 2015年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HistoryScoreModel : NSObject

@property(nonatomic,copy)NSString *result;
@property(nonatomic,copy)NSString *flag;
@property(nonatomic,copy)NSString *msg;

@end

@interface resultModel : NSObject

@property(nonatomic,strong)NSArray *CapitalFlowList;
@property(nonatomic,copy)NSString *capitalFlowCount;

@end

@interface CapitalFlowListModel : NSObject

@property(nonatomic,copy)NSString *createDate;
@property(nonatomic,copy)NSString *status;
@property(nonatomic,assign)double amount;

@end