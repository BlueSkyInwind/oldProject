//
//  UserDataViewModel.h
//  fxdProduct
//
//  Created by admin on 2017/8/23.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FXD_ViewModelBaseClass.h"

@interface UserDataViewModel : FXD_ViewModelBaseClass

/**
  基础信息状态
 */
-(void)obtainBasicInformationStatus;
/**
 三方信息状态
 */
-(void)obtainthirdPartCertificationStatus;

//上传活体认证信息
-(void)uploadLiveIdentiInfo:(FaceIDData *)imagesDic;
/**
 认证中心获取基础资料接口
 */
-(void)obtainBasicInformationStatusOfAuthenticationCenter;
/**
 用户联系人信息的状态
 */
-(void)obtainContactInfoStatus;

/**
 芝麻信用信息提交
 
 @param id_code 身份证id
 @param user_name 用户名
 */
-(void)SubmitZhimaCreditID_code:(NSString *)id_code user_name:(NSString *)user_name;


#pragma  mark - 社保  公积金

/**
 社保
 
 @param taskid 任务id
 */
-(void)socialSecurityInfoUpload:(NSString *)taskid;

/**
 信用卡
 
 @param taskid 任务id
 */
-(void)TheCreditCardInfoUpload:(NSString *)taskid;

/**
 网银接口
 
 @param taskid 任务id
 */
-(void)TheInternetbankUpload:(NSString *)taskid;

/**
 获取状态
 */
-(void)obtainhighRankingStatus;

/**
 用户资料认证
 */
-(void)UserDataCertification:(NSString *)product_id;

/**
 得到测评结果
 */
-(void)UserDataCertificationResult;

/**
 获取提额信息页面接口
 */
-(void)obtainUserCreditLimit;
#pragma  mark - 公共接口
/**
 获取列表数据的公共接口
 
 @param str 数据类型
 */
-(void)getCommonDictCodeListTypeStr:(NSString *)str;
/**
 获取对应城市代码
 
 @param areaNamestr 城市名
 */
-(void)getRegionCodeByAreaName:(NSString *)areaNamestr;
/**
 获取所有省市区
 */
-(void)getAllRegionList;
@end
