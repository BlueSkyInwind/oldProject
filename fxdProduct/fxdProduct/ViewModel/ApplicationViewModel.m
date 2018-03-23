//
//  ApplicationViewModel.m
//  fxdProduct
//
//  Created by admin on 2017/8/31.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "ApplicationViewModel.h"
#import "DiscountTicketParam.h"
@implementation ApplicationViewModel

-(void)newUserCreateApplication:(NSString *)productId
                   platformCode:(NSString *)platformCode
                         baseId:(NSString *)baseId
                        loanFor:(NSString *)loanFor
                    stagingType:(NSString *)stagingType
                        periods:(NSString *)periods
                     loanAmount:(NSString *)loanAmount{
    
    ApplicaitonModel * applicationM = [[ApplicaitonModel alloc]init];
    applicationM.baseId= baseId;
    applicationM.productId= productId;
    applicationM.loanFor= loanFor;
    applicationM.periods= periods;
    applicationM.loanAmount= loanAmount;
    applicationM.platformCode= platformCode;
    applicationM.stagingType = stagingType;
    NSDictionary * paramDic = [applicationM toDictionary];
    
    [[FXD_NetWorkRequestManager sharedNetWorkManager] DataRequestWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_new_CreateApplication_url] isNeedNetStatus:true isNeedWait:true parameters:paramDic finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            BaseResultModel * baseRM = [[BaseResultModel alloc]initWithDictionary:(NSDictionary *)object error:nil];
            self.returnBlock(baseRM);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            self.faileBlock();
        }
    }];
}


-(void)capitalLoanFail{
    [[FXD_NetWorkRequestManager sharedNetWorkManager]GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_CapitalLoanFail_url] isNeedNetStatus:true isNeedWait:true parameters:nil finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            self.returnBlock(object);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            [self faileBlock];
        }
    }];
}

/**
 获取优惠券

 @param type 类型
 @param displayType 用处
 @param pageNum 页数
 @param pageSize 每页数量
 @param product_id 产品id
 */
-(void)new_obtainUserDiscountTicketListDisplayType:(NSString *)displayType product_id:(NSString *)product_id pageNum:(NSString *)pageNum pageSize:(NSString *)pageSize{
    
    DiscountTicketParam * discountTP = [[DiscountTicketParam alloc]init];
    discountTP.displayType = displayType;
    discountTP.pageNum = pageNum;
    discountTP.pageSize = pageSize;
    discountTP.product_id = product_id;
    NSDictionary * paramDic = [discountTP toDictionary];
    
    [[FXD_NetWorkRequestManager sharedNetWorkManager] DataRequestWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_New_DiscountTicket_url] isNeedNetStatus:true isNeedWait:true parameters:paramDic finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            self.returnBlock(object);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            self.faileBlock(object);
        }
    }];

}

-(void)obtainNewApplicationInfo:(NSString *)productId{
    
    NSDictionary * paramDic = @{@"productId":productId};
    
    [[FXD_NetWorkRequestManager sharedNetWorkManager] GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_newApplicationViewInfo_url] isNeedNetStatus:true isNeedWait:true parameters:paramDic finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            self.returnBlock(object);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            self.faileBlock();
        }
    }];

}
-(void)obtainapplicationInfoCalculate:(NSString *)loanAmount stagingType:(NSString *)stagingType periods:(NSString *)periods productId:(NSString *)productId voucherAmount:(NSString *)voucherAmount{
    
    ApplicaitonCalculateParamModel *  applicaitonCalculatePM = [[ApplicaitonCalculateParamModel alloc]init];
    applicaitonCalculatePM.loanAmount = loanAmount;
    applicaitonCalculatePM.periods = periods;
    applicaitonCalculatePM.productId = productId;
    applicaitonCalculatePM.voucherAmount = voucherAmount;
    applicaitonCalculatePM.stagingType = stagingType;

    NSDictionary * paramDic = [applicaitonCalculatePM toDictionary];
    
    [[FXD_NetWorkRequestManager sharedNetWorkManager] DataRequestWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_calculateApplicationInfo_url] isNeedNetStatus:true isNeedWait:true parameters:paramDic finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            BaseResultModel * baseRM = [[BaseResultModel alloc]initWithDictionary:(NSDictionary *)object error:nil];
            self.returnBlock(baseRM);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            self.faileBlock();
        }
    }];
    

}

@end
