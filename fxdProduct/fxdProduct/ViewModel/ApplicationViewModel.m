//
//  ApplicationViewModel.m
//  fxdProduct
//
//  Created by admin on 2017/8/31.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "ApplicationViewModel.h"
#import "CapitalLoanParam.h"

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
@param displayType 类型 1 、提额处 2、个人中心处
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




@end
