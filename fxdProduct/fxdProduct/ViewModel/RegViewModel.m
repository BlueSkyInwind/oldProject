//
//  RegViewModel.m
//  fxdProduct
//
//  Created by admin on 2017/5/27.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "RegViewModel.h"
#import "ReturnMsgBaseClass.h"
#import "FMDeviceManager.h"
@implementation RegViewModel


/**
 注册请求
 
 @param number 手机号
 @param password 密码
 @param verifycode 验证码
 @param invitationCode 邀请码
 @param picVerifyId 图片验证码id
 @param picVerifyCode 图片验证码id
 */
- (void)fatchRegMoblieNumber:(NSString *)number
                      password:(NSString *)password
                    verifyCode:(NSString *)verifycode
                invitationCode:(NSString*)invitationCode
                   picVerifyId:(NSString *)picVerifyId
                 picVerifyCode:(NSString *)picVerifyCode
{
    FMDeviceManager_t *manager = [FMDeviceManager sharedManager];
    NSString *blackBox = manager->getDeviceInfo();
    
    RegParamModel * regParamModel = [[RegParamModel alloc]init];
    regParamModel.mobile_phone_ = number;
    regParamModel.password_ = [DES3Util encrypt:password];;
    regParamModel.register_from_ = PLATFORM;
    regParamModel.verify_code_ = verifycode;
    regParamModel.register_ip_ = [[FXD_Tool share] getIPAddress];
    regParamModel.register_device_ = @"";
    regParamModel.pic_verify_id_ = picVerifyId;
    regParamModel.pic_verify_code_ = picVerifyCode;
    regParamModel.invitation_code = invitationCode;
    regParamModel.third_tongd_code = blackBox;

    NSDictionary  * paramDic =[regParamModel toDictionary];
    [self registerRequest:paramDic];
}

-(void)registerRequest:(NSDictionary *)paramDic {

    [[FXD_NetWorkRequestManager sharedNetWorkManager] DataRequestWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_reg_url] isNeedNetStatus:true isNeedWait:true parameters:paramDic finished:^(EnumServerStatus status, id object) {
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

-(void)obtainRegisterProtocol:(NSString *)ProtocolId ProtocolType:(NSString *)protocolType{
    
   NSDictionary * paramDic = @{@"product_id_":ProtocolId,
                     @"protocol_type_":protocolType};

    [[FXD_NetWorkRequestManager sharedNetWorkManager] GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_ProductProtocol_url] isNeedNetStatus:true isNeedWait:true parameters:paramDic finished:^(EnumServerStatus status, id object) {
        self.returnBlock(object);
    } failure:^(EnumServerStatus status, id object) {
        [self faileBlock];
    }];
}







@end
