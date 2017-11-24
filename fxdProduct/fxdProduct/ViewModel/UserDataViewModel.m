//
//  UserDataViewModel.m
//  fxdProduct
//
//  Created by admin on 2017/8/23.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "UserDataViewModel.h"
#import "FaceIDLiveModel.h"
#import "UserCardResult.h"
@implementation UserDataViewModel

-(void)obtainCustomerAuthInfoProgress:(NSString *)product_id_{
    
    NSDictionary *paramDic = @{@"product_id_":product_id_,};
    [[FXD_NetWorkRequestManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_customerAuthInfo_url] parameters:paramDic finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            self.returnBlock(object);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            [self faileBlock];
        }
    }];
}

-(void)obtainBasicInformationStatus{
    
//    NSDictionary *paramDic = @{@"userId":[FXD_Utility sharedUtility].userInfo.juid,};
    [[FXD_NetWorkRequestManager sharedNetWorkManager] GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_UserBasicInformation_url] isNeedNetStatus:true  parameters:nil finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            self.returnBlock(object);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            [self faileBlock];
        }
    }];
}
-(void)obtainthirdPartCertificationStatus{
    
//    NSDictionary *paramDic = @{@"userId":[FXD_Utility sharedUtility].userInfo.juid,};
    [[FXD_NetWorkRequestManager sharedNetWorkManager] GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_UserThirdPartCertification_url] isNeedNetStatus:true parameters:nil finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            self.returnBlock(object);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            [self faileBlock];
        }
    }];
}

-(void)obtainBasicInformationStatusOfAuthenticationCenter{
    
    [[FXD_NetWorkRequestManager sharedNetWorkManager] GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_AuthenticationCenterBasicInformation_url] isNeedNetStatus:true parameters:nil finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            self.returnBlock(object);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            self.faileBlock();
        }
    }];
}
-(void)obtainContactInfoStatus{
    [[FXD_NetWorkRequestManager sharedNetWorkManager] GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_UserContactInfo_url] isNeedNetStatus:true  parameters:nil finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            self.returnBlock(object);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            [self faileBlock];
        }
    }];
}

-(void)obtainGatheringInformation{
    [[FXD_NetWorkRequestManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_cardList_url] parameters:nil finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            self.returnBlock(object);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            [self faileBlock];
        }
    }];
}

-(void)uploadLiveIdentiInfo:(FaceIDData *)imagesDic{
    
    NSDictionary *paramDic = @{@"api_key":FaceIDAppKey,
                               @"api_secret":FaceIDAppSecret,
                               @"comparison_type":@"1",
                               @"face_image_type":@"meglive",
                               @"idcard_name":[FXD_Utility sharedUtility].userInfo.realName,
                               @"idcard_number":[FXD_Utility sharedUtility].userInfo.userIDNumber,
                               @"delta":imagesDic.delta};
    
    [[FXD_NetWorkRequestManager sharedNetWorkManager] POSTUpLoadImage:_verifyLive_url FilePath:imagesDic.images parameters:paramDic finished:^(EnumServerStatus status, id object) {
        DLog(@"%@",object);
        FaceIDLiveModel *faceIDLiveParse = [FaceIDLiveModel yy_modelWithJSON:object];
        if (!faceIDLiveParse.error_message) {
            NSDictionary *dic = [NSDictionary dictionaryWithDictionary:object];
            NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
            NSString *jsonStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            __weak typeof(self) weakSelf = self;
            [self uploadLiveInfo:jsonStr isSuccess:^(id object) {
  
            }];
        } else {
            [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:faceIDLiveParse.error_message];
        }
    } failure:^(EnumServerStatus status, id object) {
        NSError * error  = (NSError *)object;
        NSDictionary *erroInfo = error.userInfo;
        NSData *data = [erroInfo valueForKey:@"com.alamofire.serialization.response.error.data"];
        NSString *errorString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@", errorString);
        [self uploadLiveInfo:@"" isSuccess:^(id object) {
            
        }];
        //        NSError *error = object;
        //        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:[NSString stringWithFormat:@"Error-%ld",(long)error.code]];
    }];
}

- (void)uploadLiveInfo:(NSString *)resultJSONStr isSuccess:(void(^)(id object))success
{
    [[FXD_NetWorkRequestManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_detectInfo_url] parameters:@{@"records":resultJSONStr} finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            self.returnBlock(object);
        }
        success(object);
    } failure:^(EnumServerStatus status, id object) {
        
    }];
}
#pragma  mark - 社保  公积金
/**
 社保
 @param taskid 任务id
 */
-(void)socialSecurityInfoUpload:(NSString *)taskid{
    
    NSDictionary * paramDic = @{@"task_id":taskid};
    
    [[FXD_NetWorkRequestManager sharedNetWorkManager] GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_shebaoupload_url]  isNeedNetStatus:true parameters:paramDic finished:^(EnumServerStatus status, id object) {
        
    } failure:^(EnumServerStatus status, id object) {
        
    }];
}
/**
 信用卡
 
 @param taskid 任务id
 */
-(void)TheCreditCardInfoUpload:(NSString *)taskid{
    
    NSDictionary * paramDic = @{@"task_id":taskid};
    
    [[FXD_NetWorkRequestManager sharedNetWorkManager] GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_TheCreditCardupload_url]  isNeedNetStatus:true parameters:paramDic finished:^(EnumServerStatus status, id object) {
        NSLog(@"%@",object);
    } failure:^(EnumServerStatus status, id object) {
        
    }];
}

-(void)obtainhighRankingStatus{
    
//    NSDictionary * paramDic = @{@"user_id":[Utility sharedUtility].userInfo.juid};

    [[FXD_NetWorkRequestManager sharedNetWorkManager] GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_HighRankingStatus_url]  isNeedNetStatus:true parameters:nil finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            self.returnBlock(object);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            [self faileBlock];
        }
    }];
}

-(void)UserDataCertification{
    [[FXD_NetWorkRequestManager sharedNetWorkManager] DataRequestWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_UserDataCertification_url] isNeedNetStatus:true isNeedWait:true parameters:nil finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            self.returnBlock(object);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            self.faileBlock();
        }
    }];
}


-(void)UserDataCertificationResult{

    [[FXD_NetWorkRequestManager sharedNetWorkManager]GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_UserDataCertificationResult_url] isNeedNetStatus:YES parameters:nil finished:^(EnumServerStatus status, id object) {
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
