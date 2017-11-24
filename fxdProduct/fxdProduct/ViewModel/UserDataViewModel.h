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
 查询用户资料的录入进度

 @param product_id_ 产品
 */
-(void)obtainCustomerAuthInfoProgress:(NSString *)product_id_;

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
 获取收款信息
 */
-(void)obtainGatheringInformation;


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
 获取状态
 */
-(void)obtainhighRankingStatus;

/**
 用户资料认证
 */
-(void)UserDataCertification;

/**
 得到测评结果
 */

-(void)UserDataCertificationResult;

@end
