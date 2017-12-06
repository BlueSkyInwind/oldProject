//
//  GetCareerInfoViewModel.m
//  fxdProduct
//
//  Created by dd on 16/4/12.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "GetCareerInfoViewModel.h"
#import "CustomerCareerBaseClass.h"

@implementation GetCareerInfoViewModel

- (void)fatchCareerInfo:(NSDictionary *)paramDic
{
//    [[FXD_NetWorkRequestManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_getCustomerCarrer_jhtml] parameters:paramDic finished:^(EnumServerStatus status, id object) {
//        CustomerCareerBaseClass *returnModel = [CustomerCareerBaseClass modelObjectWithDictionary:object];
//        self.returnBlock(returnModel);
//    } failure:^(EnumServerStatus status, id object) {
//        [self faileBlock];
//    }];
    
    [[FXD_NetWorkRequestManager sharedNetWorkManager] GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_getCustomerCarrer_jhtml] isNeedNetStatus:true parameters:paramDic finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            BaseResultModel * baseVM = [[BaseResultModel alloc]initWithDictionary:(NSDictionary *)object error:nil];
            self.returnBlock(baseVM);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            self.faileBlock();
        }
    }];
}

@end
