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
    [[FXD_NetWorkRequestManager sharedNetWorkManager] GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_checkVersion_jhtml] isNeedNetStatus:false isNeedWait:true parameters:paramDic finished:^(EnumServerStatus status, id object) {
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

-(void)obtainProductProtocolType:(NSString *)Type_id typeCode:(NSString *)typeCode apply_id:(NSString *)apply_id periods:(NSString *)periods{
    ProtocolParamModel * protocolM = [[ProtocolParamModel alloc]init];
    protocolM.productId  = Type_id;
    protocolM.protocolType  = typeCode;
    protocolM.applicationId  = apply_id;
    protocolM.periods = periods;
    
    NSDictionary *paramDic = [protocolM toDictionary];

    [[FXD_NetWorkRequestManager sharedNetWorkManager] GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_newproductProtocolH5_url] isNeedNetStatus:true isNeedWait:true parameters:paramDic finished:^(EnumServerStatus status, id object) {
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

-(void)obtainTransferAuthProtocolType:(NSString *)Type_id typeCode:(NSString *)typeCode cardBankCode:(NSString *)cardBankCode cardNo:(NSString *)cardNo{
    ProtocolParamModel * protocolM = [[ProtocolParamModel alloc]init];
    protocolM.productId  = Type_id;
    protocolM.protocolType  = typeCode;
    protocolM.cardBank = cardBankCode;
    protocolM.cardNo = cardNo;

    NSDictionary *paramDic = [protocolM toDictionary];
    
    [[FXD_NetWorkRequestManager sharedNetWorkManager] GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_newproductProtocolH5_url] isNeedNetStatus:true isNeedWait:true parameters:paramDic finished:^(EnumServerStatus status, id object) {
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
