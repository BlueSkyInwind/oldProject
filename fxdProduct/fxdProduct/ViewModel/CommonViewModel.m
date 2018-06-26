//
//  CommonViewModel.m
//  fxdProduct
//
//  Created by admin on 2017/12/13.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "CommonViewModel.h"
#import "ProtocolParamModel.h"

@implementation CommonViewModel

/**
 版本检测
 */
-(void)appVersionChecker{
    NSString *app_Version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSDictionary *paramDic = @{@"platform_type_":PLATFORM,
                               @"app_version_":app_Version,
                               @"service_platform_type_":@"0"
                               };
    [[HF_NetWorkRequestManager sharedNetWorkManager] GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_checkVersion_jhtml] isNeedNetStatus:false isNeedWait:true parameters:paramDic finished:^(EnumServerStatus status, id object) {
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

-(void)obtainProductProtocolType:(NSString *)Type_id typeCode:(NSString *)typeCode apply_id:(NSString *)apply_id periods:(NSString *)periods stagingType:(NSString *)stagingType{
    ProtocolParamModel * protocolM = [[ProtocolParamModel alloc]init];
    protocolM.productId  = Type_id;
    protocolM.protocolType  = typeCode;
    protocolM.applicationId  = apply_id;
    protocolM.periods = periods;
    protocolM.stagingType = stagingType;
    NSDictionary *paramDic = [protocolM toDictionary];

    [[HF_NetWorkRequestManager sharedNetWorkManager] GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_newproductProtocolH5_url] isNeedNetStatus:true isNeedWait:true parameters:paramDic finished:^(EnumServerStatus status, id object) {
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

-(void)obtainTransferAuthProtocolType:(NSString *)Type_id typeCode:(NSString *)typeCode cardBankCode:(NSString *)cardBankCode cardNo:(NSString *)cardNo stagingType:(NSString *)stagingType applicationId:(NSString *)applicationId{
    ProtocolParamModel * protocolM = [[ProtocolParamModel alloc]init];
    protocolM.productId  = Type_id;
    protocolM.protocolType  = typeCode;
    protocolM.cardBank = cardBankCode;
    protocolM.cardNo = cardNo;
    protocolM.stagingType = stagingType;
    protocolM.applicationId = applicationId;
    
    NSDictionary *paramDic = [protocolM toDictionary];
    
    [[HF_NetWorkRequestManager sharedNetWorkManager] GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_newproductProtocolH5_url] isNeedNetStatus:true isNeedWait:true parameters:paramDic finished:^(EnumServerStatus status, id object) {
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

-(void)obtainPhoneCardProtocolType:(NSString *)productId totalPrice:(NSString *)totalPrice applicationId:(NSString *)applicationId{
    ProtocolParamModel * protocolM = [[ProtocolParamModel alloc]init];
    protocolM.productId  = productId;
    protocolM.protocolType  = @"21";
    protocolM.applicationId = applicationId;
    protocolM.amountOfSale = totalPrice;
    protocolM.periods = @"1";
    protocolM.stagingType = @"2";
    NSDictionary *paramDic = [protocolM toDictionary];
    
    [[HF_NetWorkRequestManager sharedNetWorkManager] GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_newproductProtocolH5_url] isNeedNetStatus:true isNeedWait:true parameters:paramDic finished:^(EnumServerStatus status, id object) {
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


-(void)obtainTransferAuthProtocolType:(NSString *)Type_id typeCode:(NSString *)typeCode cardBankCode:(NSString *)cardBankCode cardNo:(NSString *)cardNo stagingType:(NSString *)stagingType applicationId:(NSString *)applicationId phoneModel:(NSString *)phoneModel amountOfSale:(NSString *)amountOfSale{
    ProtocolParamModel * protocolM = [[ProtocolParamModel alloc]init];
    protocolM.productId  = Type_id;
    protocolM.protocolType  = typeCode;
    protocolM.cardBank = cardBankCode;
    protocolM.cardNo = cardNo;
    protocolM.stagingType = stagingType;
    protocolM.applicationId = applicationId;
    protocolM.amountOfSale = amountOfSale;
    protocolM.phoneModel = phoneModel;
    
    NSDictionary *paramDic = [protocolM toDictionary];
    
    [[HF_NetWorkRequestManager sharedNetWorkManager] GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_newproductProtocolH5_url] isNeedNetStatus:true isNeedWait:true parameters:paramDic finished:^(EnumServerStatus status, id object) {
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
