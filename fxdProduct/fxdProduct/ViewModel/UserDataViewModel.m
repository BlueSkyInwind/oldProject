//
//  UserDataViewModel.m
//  fxdProduct
//
//  Created by admin on 2017/8/23.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "UserDataViewModel.h"

@implementation UserDataViewModel
#pragma  mark - 社保  公积金

/**
 社保
 
 @param taskid 任务id
 */
-(void)socialSecurityInfoUpload:(NSString *)taskid{
    
    NSDictionary * paramDic = @{@"task_id":taskid,@"user_id":[Utility sharedUtility].userInfo.juid};
    
    [[FXDNetWorkManager sharedNetWorkManager] GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_shebaoupload_url] parameters:paramDic finished:^(EnumServerStatus status, id object) {
        
    } failure:^(EnumServerStatus status, id object) {
        
    }];
    
}
/**
 信用卡
 
 @param taskid 任务id
 */
-(void)TheCreditCardInfoUpload:(NSString *)taskid{
    
    NSDictionary * paramDic = @{@"task_id":taskid,@"user_id":[Utility sharedUtility].userInfo.juid};
    
    [[FXDNetWorkManager sharedNetWorkManager] GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_TheCreditCardupload_url] parameters:paramDic finished:^(EnumServerStatus status, id object) {
        NSLog(@"%@",object);
    } failure:^(EnumServerStatus status, id object) {
        
    }];
    
}

-(void)obtainhighRankingStatus{
    
    NSDictionary * paramDic = @{@"user_id":[Utility sharedUtility].userInfo.juid};

    [[FXDNetWorkManager sharedNetWorkManager] GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_HighRankingStatus_url] parameters:paramDic finished:^(EnumServerStatus status, id object) {
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
