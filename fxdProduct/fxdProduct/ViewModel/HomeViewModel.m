//
//  HomeViewModel.m
//  fxdProduct
//
//  Created by dd on 15/12/25.
//  Copyright © 2015年 dd. All rights reserved.
//

#import "HomeViewModel.h"

@implementation HomeViewModel


- (void)fetchUserState:(NSString *)productId
{
    
<<<<<<< HEAD
//    NSParameterAssert(productId);
=======
>>>>>>> 805276d7275e3bf52f014647e6cb1a9b2bd1b88b
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
    
    [[FXDNetWorkManager sharedNetWorkManager] POSTHideHUD:[NSString stringWithFormat:@"%@%@",_main_url,_queryLoanRecord_url] parameters:nil finished:^(EnumServerStatus status, id object) {
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
    
    [[FXDNetWorkManager sharedNetWorkManager] POSTHideHUD:[NSString stringWithFormat:@"%@%@",_main_url,_topBanner_url] parameters:paramDic finished:^(EnumServerStatus status, id object) {
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
    
    [[FXDNetWorkManager sharedNetWorkManager] POSTHideHUD:[NSString stringWithFormat:@"%@%@",_main_url,_adv_url] parameters:paramDic finished:^(EnumServerStatus status, id object) {
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



