//
//  CompQueryViewModel.m
//  fxdProduct
//
//  Created by sxp on 2018/3/28.
//  Copyright © 2018年 dd. All rights reserved.
//

#import "CompQueryViewModel.h"
#import "CompQueryParamModel.h"

@implementation CompQueryViewModel

-(void)compQueryLimit:(NSString *)limit maxAmount:(NSString *)maxAmount maxDays:(NSString *)maxDays minAmount:(NSString *)minAmount minDays:(NSString *)minDays offset:(NSString *)offset order:(NSString *)order sort:(NSString *)sort moduleType:(NSString *)moduleType location:(NSString *)location{
    
    CompQueryParamModel *paramModel = [[CompQueryParamModel alloc]init];
    paramModel.limit = limit;
    paramModel.maxAmount = maxAmount;
    paramModel.maxDays = maxDays;
    paramModel.minAmount = minAmount;
    paramModel.minDays = minDays;
    paramModel.offset = offset;
    paramModel.order = order;
    paramModel.sort = sort;
    paramModel.moduleType = moduleType;
    paramModel.location = location;
    
    NSDictionary *paramDic = [paramModel toDictionary];
    
    [[HF_NetWorkRequestManager sharedNetWorkManager]DataRequestWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_compQuery_url] isNeedNetStatus:true isNeedWait:true parameters:paramDic finished:^(EnumServerStatus status, id object) {
        
        if (self.returnBlock) {
            self.returnBlock(object);
        }
        
    } failure:^(EnumServerStatus status, id object) {
        
        if (self.faileBlock) {
            [self faileBlock];
        }
        
    }];
    
}

-(void)getCompLinkThirdPlatformId:(NSString *)third_platform_id location:(NSString *)location{
    
    //[[NSUUID UUID] UUIDString]
    //1-首页贷款入口；3-发现（热门推荐）；4-发现（我的使用）；5-发现（列表）；6-首页热门推荐；7-首页热门推荐（更多））
    NSDictionary *paramDic = @{@"third_platform_id":third_platform_id,
                               @"deviceId":[[NSUUID UUID] UUIDString],
                               @"location":location
                               };
    [[HF_NetWorkRequestManager sharedNetWorkManager]DataRequestWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_getCompLink_url] isNeedNetStatus:true isNeedWait:true parameters:paramDic finished:^(EnumServerStatus status, id object) {
        
        if (self.returnBlock) {
            self.returnBlock(object);
        }
        
    } failure:^(EnumServerStatus status, id object) {
        
        if (self.faileBlock) {
            [self faileBlock];
        }
        
    }];
}
@end
