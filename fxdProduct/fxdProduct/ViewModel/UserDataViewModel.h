//
//  UserDataViewModel.h
//  fxdProduct
//
//  Created by admin on 2017/8/23.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewModelClass.h"

@interface UserDataViewModel : ViewModelClass

//上传活体认证信息
-(void)uploadLiveIdentiInfo:(FaceIDData *)imagesDic;
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

@end
