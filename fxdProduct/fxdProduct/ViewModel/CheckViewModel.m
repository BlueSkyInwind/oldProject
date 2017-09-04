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

    [[FXDNetWorkManager sharedNetWorkManager]POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_approvalAmount_jhtml] parameters:nil finished:^(EnumServerStatus status, id object) {
        
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
    
    [[FXDNetWorkManager sharedNetWorkManager] GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_UserDrawingInfo_url] parameters:nil finished:^(EnumServerStatus status, id object) {
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
    [[FXDNetWorkManager sharedNetWorkManager] GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_SalaryProductFee_url] parameters:paramDic finished:^(EnumServerStatus status, id object) {
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


@implementation ComplianceViewModel

-(void)getUserStatus:(NSString *)applicationId{

    NSDictionary *param = @{@"client_":@"1",@"from_case_id_":applicationId};

    [[FXDNetWorkManager sharedNetWorkManager]P2POSTWithURL:[NSString stringWithFormat:@"%@%@",_p2P_url,_qryUserStatus_url] parameters:param finished:^(EnumServerStatus status, id object) {
        
        if (self.returnBlock) {
            self.returnBlock(object);
        }
        
    } failure:^(EnumServerStatus status, id object) {
        
        if (self.faileBlock) {
            [self faileBlock];
        }
    }];
}

-(void)saveLoanCase:(NSString *)type CaseInfo:(GetCaseInfo *)caseInfo Period:(NSString *)period PurposeSelect:(NSString *)purposeSelect{

    SaveLoanCaseParamModel * saveLoanCaseParamModel = [[SaveLoanCaseParamModel alloc]init];
    saveLoanCaseParamModel.case_id_ = caseInfo.result.from_case_id_;
    saveLoanCaseParamModel.type_ = type;
    saveLoanCaseParamModel.client_ = @"1";
    saveLoanCaseParamModel.description_ = purposeSelect;
    saveLoanCaseParamModel.period_ = period;
    NSDictionary * paramDic  = [saveLoanCaseParamModel toDictionary];
    
    [[FXDNetWorkManager sharedNetWorkManager]P2POSTWithURL:[NSString stringWithFormat:@"%@%@",_p2P_url,_saveLoanCase_url] parameters:paramDic finished:^(EnumServerStatus status, id object) {
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

    [[FXDNetWorkManager sharedNetWorkManager]POSTHideHUD:[NSString stringWithFormat:@"%@%@",_ValidESB_url,_getFXDCaseInfo_url] parameters:nil finished:^(EnumServerStatus status, id object) {
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

    [[FXDNetWorkManager sharedNetWorkManager]P2POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_getBankList_url] parameters:@{@"dict_type_":@"CARD_BANK_"} finished:^(EnumServerStatus status, id object) {
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
    
    [[FXDNetWorkManager sharedNetWorkManager]P2POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_getSupportBankList_url] parameters:@{@"pay_platform_id_":platform} finished:^(EnumServerStatus status, id object) {
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

    NSParameterAssert([Utility sharedUtility].userInfo.userMobilePhone);
    [[FXDNetWorkManager sharedNetWorkManager]P2POSTWithURL:[NSString stringWithFormat:@"%@%@",_p2P_url,_queryCardInfo_url] parameters:@{@"from_mobile_":[Utility sharedUtility].userInfo.userMobilePhone} finished:^(EnumServerStatus status, id object) {
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
    
    [[FXDNetWorkManager sharedNetWorkManager]P2POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_getBankList_url] parameters:@{@"dict_type_":@"__HG_CARD_BANK_"} finished:^(EnumServerStatus status, id object) {
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
