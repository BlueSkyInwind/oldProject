//
//  HomeViewModel.m
//  fxdProduct
//
//  Created by dd on 15/12/25.
//  Copyright © 2015年 dd. All rights reserved.
//

#import "HomeViewModel.h"
#import "HomeParam.h"
@implementation HomeViewModel

-(void)homeDataRequest{
    
    HomeParam * homeParam = [[HomeParam alloc]init];
//    homeParam.channel = PLATFORM;
    NSDictionary * paramDic = [homeParam toDictionary];
    //http://192.168.12.109:8005/summary?
    [[FXD_NetWorkRequestManager sharedNetWorkManager] GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_HomeState_url] isNeedNetStatus:false parameters:paramDic finished:^(EnumServerStatus status, id object) {
        DLog(@"%@",object);
        if (self.returnBlock) {
            self.returnBlock(object);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            self.faileBlock();
        }
    }];
}

/**
 获取导流链接
 */
-(void)obtainDiversionUrl{
    [[FXD_NetWorkRequestManager sharedNetWorkManager] GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_liangzihuzhu_url] isNeedNetStatus:true parameters:nil finished:^(EnumServerStatus status, id object) {
        DLog(@"%@",object);
        if (self.returnBlock) {
            self.returnBlock(object);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            self.faileBlock();
        }
    }];
}

/**
 统计三方导流

 @param productId 产品id
 */
-(void)statisticsDiversionPro:(NSString *)productId{
    
    NSDictionary * dic  = @{@"productId":productId};
    
    [[FXD_NetWorkRequestManager sharedNetWorkManager] GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_DiversionProStatics_url] isNeedNetStatus:false parameters:dic finished:^(EnumServerStatus status, id object) {
        DLog(@"%@",object);
        if (self.returnBlock) {
            self.returnBlock(object);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            self.faileBlock();
        }
    }];
}

@end


@implementation ProductListViewModel



@end








