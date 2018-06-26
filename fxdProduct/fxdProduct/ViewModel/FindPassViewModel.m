//
//  FindPassViewModel.m
//  fxdProduct
//
//  Created by dd on 16/1/7.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "FindPassViewModel.h"
#import "LoginParamModel.h"
#import "DES3Util.h"

@implementation FindPassViewModel

- (void)fatchFindPassPhone:(NSString *)phone password:(NSString *)password verify_code:(NSString *)verify_code
{
    LoginFindParamModel * findM =  [[LoginFindParamModel alloc]init];
    findM.mobile_phone_ = phone;
    findM.password_ =  [DES3Util encrypt:password];
    findM.verify_code_ = verify_code;
    findM.service_platform_type_ = SERVICE_PLATFORM;
    NSDictionary * paramDic = [findM toDictionary];
    
    [[HF_NetWorkRequestManager sharedNetWorkManager] DataRequestWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_forget_url] isNeedNetStatus:true isNeedWait:true parameters:paramDic finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            BaseResultModel * baseResultM = [[BaseResultModel alloc]initWithDictionary:(NSDictionary *)object error:nil];
            self.returnBlock(baseResultM);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            self.faileBlock();
        }
    }];
}

@end
