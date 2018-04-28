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

-(void)compQueryLimit:(NSString *)limit maxAmount:(NSString *)maxAmount maxDays:(NSString *)maxDays minAmount:(NSString *)minAmount minDays:(NSString *)minDays offset:(NSString *)offset order:(NSString *)order sort:(NSString *)sort moduleType:(NSString *)moduleType{
    
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
    
    NSDictionary *paramDic = [paramModel toDictionary];
    
    [[FXD_NetWorkRequestManager sharedNetWorkManager]DataRequestWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_compQuery_url] isNeedNetStatus:true isNeedWait:true parameters:paramDic finished:^(EnumServerStatus status, id object) {
        
        if (self.returnBlock) {
            self.returnBlock(object);
        }
        
    } failure:^(EnumServerStatus status, id object) {
        
        if (self.faileBlock) {
            [self faileBlock];
        }
        
    }];
    
}

-(void)getCompLinkThirdPlatformId:(NSString *)third_platform_id{
    
    //[[NSUUID UUID] UUIDString]
    NSDictionary *paramDic = @{@"third_platform_id":third_platform_id,
                               @"deviceId":[[NSUUID UUID] UUIDString]
                               };
    [[FXD_NetWorkRequestManager sharedNetWorkManager]DataRequestWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_getCompLink_url] isNeedNetStatus:true isNeedWait:true parameters:paramDic finished:^(EnumServerStatus status, id object) {
        
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
