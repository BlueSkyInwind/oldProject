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
    
    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_userState_url] parameters:paramDic finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            self.returnBlock(object);
        }        //        [self fetchValueSuccessWithDic:object];
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            [self faileBlock];
        }
    }];
}

-(void)fetchLoanRecord{
    
    [[FXDNetWorkManager sharedNetWorkManager] DataRequestWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_queryLoanRecord_url]  isNeedNetStatus:NO isNeedWait:NO parameters:nil finished:^(EnumServerStatus status, id object) {
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

-(void)fetchLoanProcess{
    
    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_queryLoanStatus_url] parameters:nil finished:^(EnumServerStatus status, id object) {
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
    homeParam.channel_ = PLATFORM;
    NSDictionary * paramDic = [homeParam toDictionary];
    //http://192.168.12.109:8005/apigw/client/summary?

    NSString *url = @"http://service-apigateway.test.fxds:8005";
    [[FXDNetWorkManager sharedNetWorkManager] GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_HomeState_url] parameters:paramDic finished:^(EnumServerStatus status, id object) {
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

@end

@implementation BannerViewModel

-(void)fetchBannerInfo{
    
    HomeBannerParamModel * homeBannerParamModel = [[HomeBannerParamModel alloc]init];
    homeBannerParamModel.plate_ = @"1";
    homeBannerParamModel.position_ = @"1";
    homeBannerParamModel.channel_ = PLATFORM;
    
    NSDictionary * paramDic  = [homeBannerParamModel toDictionary];
    [self postBannerParam:paramDic];
}

-(void)postBannerParam:(NSDictionary *)paramDic{
    
    [[FXDNetWorkManager sharedNetWorkManager] DataRequestWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_topBanner_url]   isNeedNetStatus:NO isNeedWait:NO parameters:paramDic finished:^(EnumServerStatus status, id object) {
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

@end


@implementation ProductListViewModel

-(void)fetchProductListInfo{
    
    NSDictionary *paramDic = @{@"juid":[Utility sharedUtility].userInfo.juid,
                               @"token":[Utility sharedUtility].userInfo.tokenStr
                               };
    [self postProductListParam:paramDic];
    
}

-(void)postProductListParam:(NSDictionary *)paramDic{
    
    [[FXDNetWorkManager sharedNetWorkManager]POSTHideHUD:[NSString stringWithFormat:@"%@%@",_main_url,_getLimitProductlist_url] parameters:paramDic finished:^(EnumServerStatus status, id object) {
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


@implementation PopViewModel

-(void)fetchPopViewInfo{
    
    HomePopParam * homePopParam = [[HomePopParam alloc]init];
    homePopParam.channel_ = PLATFORM;
    homePopParam.plate_ = @"1";
    homePopParam.redpacket_from_ = @"1";
    
    NSDictionary *paramDic =  [homePopParam toDictionary];
    [self postPopviewParam:paramDic];

}

-(void)postPopviewParam:(NSDictionary *)paramDic{
    
    [[FXDNetWorkManager sharedNetWorkManager] DataRequestWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_adv_url]    isNeedNetStatus:NO isNeedWait:NO parameters:paramDic finished:^(EnumServerStatus status, id object) {
        DLog(@"%@",object);
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



