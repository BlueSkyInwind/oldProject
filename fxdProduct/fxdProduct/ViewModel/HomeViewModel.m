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


- (void)fetchUserState:(NSString *)productId
{
    
//    NSParameterAssert(productId);

    NSDictionary *dicParam = @{@"product_id_":productId};
    [self postUserStateParam:dicParam];

}

-(void)postUserStateParam:(NSDictionary *)paramDic{
    
    [[FXD_NetWorkRequestManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_userState_url] parameters:paramDic finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            self.returnBlock(object);
        }        //        [self fetchValueSuccessWithDic:object];
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            [self faileBlock];
        }
    }];
}



-(void)fetchLoanProcess{
    
    [[FXD_NetWorkRequestManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_queryLoanStatus_url] parameters:nil finished:^(EnumServerStatus status, id object) {
        DLog(@"%@",object);
        if (self.returnBlock) {
            self.returnBlock(object);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            [self faileBlock];
        }
    }];
}

-(void)homeDataRequest{
    
    HomeParam * homeParam = [[HomeParam alloc]init];
//    homeParam.channel = PLATFORM;
    NSDictionary * paramDic = [homeParam toDictionary];
    //http://192.168.12.109:8005/apigw/client/summary?
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





@end


@implementation ProductListViewModel

-(void)fetchProductListInfo{
    
    NSDictionary *paramDic = @{@"juid":[FXD_Utility sharedUtility].userInfo.juid,
                               @"token":[FXD_Utility sharedUtility].userInfo.tokenStr
                               };
    [self postProductListParam:paramDic];
    
}

-(void)postProductListParam:(NSDictionary *)paramDic{
    
    [[FXD_NetWorkRequestManager sharedNetWorkManager]POSTHideHUD:[NSString stringWithFormat:@"%@%@",_main_url,_getLimitProductlist_url] parameters:paramDic finished:^(EnumServerStatus status, id object) {
        DLog(@"=========%@",object);
        if (self.returnBlock) {
            self.returnBlock(object);
        }
    } failure:^(EnumServerStatus status, id object) {
        DLog(@"%@",object);
        if (self.faileBlock) {
            [self faileBlock];
        }
    }];
}

@end








