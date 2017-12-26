//
//  ApplicationViewModel.m
//  fxdProduct
//
//  Created by admin on 2017/8/31.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "ApplicationViewModel.h"
#import "CapitalLoanParam.h"
#import "DiscountTicketParam.h"
@implementation ApplicationViewModel


-(void)userCreateApplication:(NSString *)productId platformCode:(NSString *)platformCode baseId:(NSString *)baseId{
    
    NSDictionary * paramDic = @{@"productId":productId,
                                @"platformCode":platformCode,
                                @"baseId":baseId
                                };

    [[FXD_NetWorkRequestManager sharedNetWorkManager] GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_createApplication_url] isNeedNetStatus:true parameters:paramDic finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            self.returnBlock(object);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            [self faileBlock];
        }
    }];
}


-(void)queryApplicationInfo:(NSString *)productId{

    NSDictionary * paramDic = @{@"productId":productId};

    [[FXD_NetWorkRequestManager sharedNetWorkManager] GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_ApplicationViewInfo_url] isNeedNetStatus:true parameters:paramDic finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            self.returnBlock(object);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            [self faileBlock];
        }
    }];
}

-(void)capitalList:(NSString *)productId approvalAmount:(NSString *)approvalAmount{
    
    NSDictionary * paramDic = @{@"productId":productId,
                                @"approvalAmount":approvalAmount
                                };
    
    [[FXD_NetWorkRequestManager sharedNetWorkManager] GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_CapitalList_url] isNeedNetStatus:true parameters:paramDic finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            self.returnBlock(object);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            [self faileBlock];
        }
    }];
    
}

-(void)capitalLoan:(NSString *)cardId loanfor:(NSString *)loanfor periods:(NSString *)periods{
    
    CapitalLoanParam *param = [[CapitalLoanParam alloc]init];
    param.cardId = cardId;
    param.loanfor = loanfor;
    param.periods = periods;
    NSDictionary *paramDic = [param toDictionary];
    
    [[FXD_NetWorkRequestManager sharedNetWorkManager] GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_CapitalLoan_url] isNeedNetStatus:true parameters:paramDic finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            self.returnBlock(object);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            [self faileBlock];
        }
    }];
}


-(void)capitalLoanFail{
    [[FXD_NetWorkRequestManager sharedNetWorkManager]GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_CapitalLoanFail_url] isNeedNetStatus:true parameters:nil finished:^(EnumServerStatus status, id object) {
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
 优惠券及现金红包接口
@param type 类型 1 、优惠券 2、现金红包
@param displayType 类型 1 、提额处 2、个人中心处 3、
 */
-(void)obtainUserDiscountTicketList:(NSString *)type displayType:(NSString *)displayType{
    NSDictionary * paramDic = @{@"activityType":type,@"displayType":displayType};
    [[FXD_NetWorkRequestManager sharedNetWorkManager]GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_DiscountTicketList_url] isNeedNetStatus:true parameters:paramDic finished:^(EnumServerStatus status, id object) {
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
    
    [[FXD_NetWorkRequestManager sharedNetWorkManager] GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_newApplicationViewInfo_url] isNeedNetStatus:true parameters:paramDic finished:^(EnumServerStatus status, id object) {
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
