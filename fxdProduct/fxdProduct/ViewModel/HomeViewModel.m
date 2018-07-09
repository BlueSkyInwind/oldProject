//
//  HomeViewModel.m
//  fxdProduct
//
//  Created by dd on 15/12/25.
//  Copyright © 2015年 dd. All rights reserved.
//

#import "HomeViewModel.h"
#import "BannerParamModel.h"

@implementation HomeViewModel

-(void)homeDataRequest{
    
    //http://192.168.12.109:8005/summary?
    [[HF_NetWorkRequestManager sharedNetWorkManager] GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_handataSummary_url] isNeedNetStatus:false isNeedWait:true parameters:nil finished:^(EnumServerStatus status, id object) {
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
    
    [[HF_NetWorkRequestManager sharedNetWorkManager] GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_liangzihuzhu_url] isNeedNetStatus:true isNeedWait:true parameters:nil finished:^(EnumServerStatus status, id object) {
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
    
    [[HF_NetWorkRequestManager sharedNetWorkManager] GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_DiversionProStatics_url] isNeedNetStatus:false isNeedWait:true parameters:dic finished:^(EnumServerStatus status, id object) {
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


-(void)paidcenterQbbWithDrawCapitalPlatform:(NSString *)capitalPlatform{
    
    NSDictionary * dic  = @{@"capitalPlatform":capitalPlatform};
    [[HF_NetWorkRequestManager sharedNetWorkManager]GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_paidcenter_url] isNeedNetStatus:true isNeedWait:true parameters:dic finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            self.returnBlock(object);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            self.faileBlock();
        }
    }];
}

-(void)obtainParamAddress:(NSString *)urlStr linkType:(NSString *)linkType{
    
    BannerParamModel * model = [[BannerParamModel alloc]init];
    model.url = urlStr;
    model.linkType = linkType;
    model.mobile =  [FXD_Utility sharedUtility].userInfo.userMobilePhone;
    NSDictionary * paramDic = [model toDictionary];
    
    [[HF_NetWorkRequestManager sharedNetWorkManager]GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_Banner_url] isNeedNetStatus:true isNeedWait:true parameters:paramDic finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            BaseResultModel * basemodel = [[BaseResultModel alloc]initWithDictionary:object error:nil];
            self.returnBlock(basemodel);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            self.faileBlock();
        }
    }];
}




@end










