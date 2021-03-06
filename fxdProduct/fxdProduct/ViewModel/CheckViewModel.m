//
//  CheckViewModel.m
//  fxdProduct
//
//  Created by sxp on 17/6/1.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "CheckViewModel.h"
#import "SaveLoanCaseParamModel.h"
#import "HGBankListModel.h"

@implementation CheckViewModel

-(void)approvalAmount{

    [[FXD_NetWorkRequestManager sharedNetWorkManager]POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_approvalAmount_jhtml] parameters:nil finished:^(EnumServerStatus status, id object) {
        
        if (self.returnBlock) {
            self.returnBlock(object);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            [self faileBlock];
        }
    }];
}

#pragma mark - 新API
//提款信息页面
-(void)obtainDrawingInformation{
    
    [[FXD_NetWorkRequestManager sharedNetWorkManager] GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_UserDrawingInfo_url] isNeedNetStatus:true parameters:nil finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            self.returnBlock(object);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            [self faileBlock];
        }
    }];
}

-(void)obtainSalaryProductFeeOfperiod:(NSString *)periods{
    
    NSDictionary * paramDic = @{@"periods":periods};
    [[FXD_NetWorkRequestManager sharedNetWorkManager] GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_SalaryProductFee_url] isNeedNetStatus:true parameters:paramDic finished:^(EnumServerStatus status, id object) {
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


@implementation ComplianceViewModel

-(void)getUserStatus:(NSString *)applicationId{

    NSDictionary *param = @{@"client_":@"1",@"from_case_id_":applicationId};

    [[FXD_NetWorkRequestManager sharedNetWorkManager]HG_POSTWithURL:[NSString stringWithFormat:@"%@%@",_p2P_url,_qryUserStatus_url] parameters:param finished:^(EnumServerStatus status, id object) {
        
        if (self.returnBlock) {
            self.returnBlock(object);
        }
        
    } failure:^(EnumServerStatus status, id object) {
        
        if (self.faileBlock) {
            [self faileBlock];
        }
    }];
}

-(void)saveLoanCase:(NSString *)type ApplicationID:(NSString *)applicationId Period:(NSString *)period PurposeSelect:(NSString *)purposeSelect{

    SaveLoanCaseParamModel * saveLoanCaseParamModel = [[SaveLoanCaseParamModel alloc]init];
    saveLoanCaseParamModel.case_id_ = applicationId;
    saveLoanCaseParamModel.type_ = type;
    saveLoanCaseParamModel.client_ = @"1";
    saveLoanCaseParamModel.description_ = purposeSelect;
    saveLoanCaseParamModel.period_ = period;
    NSDictionary * paramDic  = [saveLoanCaseParamModel toDictionary];
    
    [[FXD_NetWorkRequestManager sharedNetWorkManager]HG_POSTWithURL:[NSString stringWithFormat:@"%@%@",_p2P_url,_saveLoanCase_url] parameters:paramDic finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            self.returnBlock(object);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            [self faileBlock];
        }
    }];
}


-(void)getFXDCaseInfo{

    [[FXD_NetWorkRequestManager sharedNetWorkManager]POSTHideHUD:[NSString stringWithFormat:@"%@%@",_ValidESB_url,_getFXDCaseInfo_url] parameters:nil finished:^(EnumServerStatus status, id object) {
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


@implementation CheckBankViewModel

-(void)getBankListInfo{

    [[FXD_NetWorkRequestManager sharedNetWorkManager]POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_getBankList_url] parameters:@{@"dict_type_":@"CARD_BANK_"} finished:^(EnumServerStatus status, id object) {
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
 支持银行卡列表

 @param platform 平台     2 - 银生宝   4 - 汇付
 */
-(void)getSupportBankListInfo:(NSString *)platform{
    
    [[FXD_NetWorkRequestManager sharedNetWorkManager]POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_getSupportBankList_url] parameters:@{@"pay_platform_id_":platform} finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            self.returnBlock(object);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            [self faileBlock];
        }
    }];
}

-(void)queryCardInfo{

    NSParameterAssert([FXD_Utility sharedUtility].userInfo.userMobilePhone);
    [[FXD_NetWorkRequestManager sharedNetWorkManager]HG_POSTWithURL:[NSString stringWithFormat:@"%@%@",_p2P_url,_queryCardInfo_url] parameters:@{@"from_mobile_":[FXD_Utility sharedUtility].userInfo.userMobilePhone} finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            self.returnBlock(object);
        }
    } failure:^(EnumServerStatus status, id object) {
        
        if (self.faileBlock) {
            [self faileBlock];
        }
    }];
}

-(void)queryCardListInfo{
    
    [[FXD_NetWorkRequestManager sharedNetWorkManager]HG_POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_getBankList_url] parameters:@{@"dict_type_":@"__HG_CARD_BANK_"} finished:^(EnumServerStatus status, id object) {
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
