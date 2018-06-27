//
//  CollectionViewModel.m
//  fxdProduct
//
//  Created by sxp on 2018/4/12.
//  Copyright © 2018年 dd. All rights reserved.
//

#import "CollectionViewModel.h"

@implementation CollectionViewModel

-(void)getMyCollectionListLimit:(NSString *)limit offset:(NSString *)offset order:(NSString *)order sort:(NSString *)sort{
    
    NSDictionary *paramDic = @{@"limit":limit,
                               @"offset":offset,
                               @"order":order,
                               @"sort":sort
                               };
    
    [[HF_NetWorkRequestManager sharedNetWorkManager]DataRequestWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_getMyCollectionList_url] isNeedNetStatus:true isNeedWait:true parameters:paramDic finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            self.returnBlock(object);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            [self faileBlock];
        }
    }];
}

-(void)addMyCollectionInfocollectionType:(NSString *)collectionType platformId:(NSString *)platformId{
    
    NSDictionary *paramDic = @{@"collectionType":collectionType,
                               @"platformId":platformId
                               };
    
    [[HF_NetWorkRequestManager sharedNetWorkManager]GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_addMyCollectionInfo_url] isNeedNetStatus:true isNeedWait:true parameters:paramDic finished:^(EnumServerStatus status, id object) {
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
