//
//  UserDataViewModel.m
//  fxdProduct
//
//  Created by admin on 2017/8/23.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "UserDataViewModel.h"
#import "FaceIDLiveModel.h"
#import "RegionCodeParam.h"
#import "IDCardUploadParam.h"

@implementation UserDataViewModel

-(void)obtainBasicInformationStatus{
    
    [[HF_NetWorkRequestManager sharedNetWorkManager] GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_UserBasicInformation_url] isNeedNetStatus:true  isNeedWait:true parameters:nil finished:^(EnumServerStatus status, id object) {
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

    [[HF_NetWorkRequestManager sharedNetWorkManager] GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_UserThirdPartCertification_url] isNeedNetStatus:true isNeedWait:true parameters:nil finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            self.returnBlock(object);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            [self faileBlock];
        }
    }];
}


-(void)obtainContactInfoStatus{
    [[HF_NetWorkRequestManager sharedNetWorkManager] GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_UserContactInfo_url] isNeedNetStatus:true  isNeedWait:true parameters:nil finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            self.returnBlock(object);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            [self faileBlock];
        }
    }];
}
/*
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
    }];
}
*/
- (void)uploadLiveInfo:(NSString *)resultJSONStr isSuccess:(void(^)(id object))success
{
    
    NSDictionary * paramDic = @{@"records":resultJSONStr};
    [[HF_NetWorkRequestManager sharedNetWorkManager] DataRequestWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_detectInfo_url] isNeedNetStatus:true isNeedWait:true parameters:paramDic finished:^(EnumServerStatus status, id object) {
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

/**
芝麻信用信息提交

 @param id_code 身份证idr
 @param user_name 用户名
 */
-(void)SubmitZhimaCreditID_code:(NSString *)id_code user_name:(NSString *)user_name{
    
    CustomerSesameCreditModel * customerCM = [[CustomerSesameCreditModel alloc]init];
    customerCM.id_code_ = id_code;
    customerCM.user_name_ = user_name;
    NSDictionary * paramDic = [customerCM toDictionary];
    
    [[HF_NetWorkRequestManager sharedNetWorkManager] DataRequestWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_submitZhimaCredit_url] isNeedNetStatus:true isNeedWait:true parameters:paramDic finished:^(EnumServerStatus status, id object) {
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

#pragma  mark - 社保  公积金
/**
 社保
 @param taskid 任务id
 */
-(void)socialSecurityInfoUpload:(NSString *)taskid{
    
    NSDictionary * paramDic = @{@"task_id":taskid};
    
    [[HF_NetWorkRequestManager sharedNetWorkManager] GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_shebaoupload_url]  isNeedNetStatus:true isNeedWait:true parameters:paramDic finished:^(EnumServerStatus status, id object) {
        
    } failure:^(EnumServerStatus status, id object) {
        
    }];
}
/**
 信用卡
 
 @param taskid 任务id
 */
-(void)TheCreditCardInfoUpload:(NSString *)taskid{
    
    NSDictionary * paramDic = @{@"task_id":taskid};
    
    [[HF_NetWorkRequestManager sharedNetWorkManager] GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_TheCreditCardupload_url]  isNeedNetStatus:true isNeedWait:true parameters:paramDic finished:^(EnumServerStatus status, id object) {
        NSLog(@"%@",object);
    } failure:^(EnumServerStatus status, id object) {
        
    }];
}
/**
 网银接口

 @param taskid 任务id
 */
-(void)TheInternetbankUpload:(NSString *)taskid{
    NSDictionary * paramDic = @{@"task_id_":taskid};
    [[HF_NetWorkRequestManager sharedNetWorkManager] GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_TheInternetbank_url]  isNeedNetStatus:true isNeedWait:true parameters:paramDic finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            self.returnBlock(object);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            [self faileBlock];
        }
    }];
}

-(void)obtainhighRankingStatus{

    [[HF_NetWorkRequestManager sharedNetWorkManager] GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_HighRankingStatus_url]  isNeedNetStatus:true isNeedWait:true parameters:nil finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            self.returnBlock(object);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            [self faileBlock];
        }
    }];
}

-(void)UserDataCertification:(NSString *)product_id{

    UserDataMeatureParam * userDataMeatureP = [[UserDataMeatureParam alloc]init];
    userDataMeatureP.product_id = product_id;
    userDataMeatureP.service_platform_flag = @"4040";

    NSDictionary * paramDic = [userDataMeatureP toDictionary];

    [[HF_NetWorkRequestManager sharedNetWorkManager]DataRequestWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_UserDataCertification_url] isNeedNetStatus:true isNeedWait:true parameters:paramDic finished:^(EnumServerStatus status, id object) {
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

    [[HF_NetWorkRequestManager sharedNetWorkManager]GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_UserDataCertificationResult_url] isNeedNetStatus:YES isNeedWait:true parameters:nil finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            self.returnBlock(object);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            self.faileBlock();
        }
    }];
}

-(void)obtainUserCreditLimit{
    
    [[HF_NetWorkRequestManager sharedNetWorkManager]GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_creditLimitInfo_url] isNeedNetStatus:YES isNeedWait:true parameters:nil finished:^(EnumServerStatus status, id object) {
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
-(void)userToImproveAmount:(NSString *)productId{

    UserDataMeatureParam * userDataMeatureP = [[UserDataMeatureParam alloc]init];
    userDataMeatureP.product_id = productId;
    userDataMeatureP.service_platform_flag = @"2020";

    NSDictionary * paramDic = [userDataMeatureP toDictionary];

    [[HF_NetWorkRequestManager sharedNetWorkManager]GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_increaseAmount_url] isNeedNetStatus:true isNeedWait:true parameters:nil finished:^(EnumServerStatus status, id object) {
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


#pragma  mark - 公共接口
/**
 获取列表数据的公共接口

 @param str 数据类型
 */
-(void)getCommonDictCodeListTypeStr:(NSString *)str{
    
    NSDictionary * paramDic = @{@"dict_type_":str};
    
    [[HF_NetWorkRequestManager sharedNetWorkManager]GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_getDicCode_url] isNeedNetStatus:YES isNeedWait:true parameters:paramDic finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            BaseResultModel * baseVM  = [[BaseResultModel alloc]initWithDictionary:(NSDictionary *)object error:nil];
            self.returnBlock(baseVM);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            self.faileBlock();
        }
    }];
}

/**
 获取对应城市代码

 @param areaNamestr 城市名
 */
-(void)getRegionCodeByAreaName:(NSString *)areaNamestr{
    
    //获取省市区代码
    NSArray *cityArray = [areaNamestr componentsSeparatedByString:@"/"];
    NSString *city0 = @"";
    NSString *city1 = @"";
    NSString *city2 = @"";
    if (cityArray.count > 2) {
        city0 = cityArray[0];
        city1 = cityArray[1];
        city2 = cityArray[2];
    }
    RegionCodeParam * regionCodeP = [[RegionCodeParam alloc]init];
    regionCodeP.provinceName =city0;
    regionCodeP.cityName = city1;
    regionCodeP.districtName = city2;

    NSDictionary * paramDic = [regionCodeP toDictionary];
    
    [[HF_NetWorkRequestManager sharedNetWorkManager]  GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_getRegionCodeByName_jhtml] isNeedNetStatus:true isNeedWait:true parameters:paramDic finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            BaseResultModel * baseVM  = [[BaseResultModel alloc]initWithDictionary:(NSDictionary *)object error:nil];
            self.returnBlock(baseVM);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            self.faileBlock();
        }
    }];
}

/**
 获取所有省市区
 */
-(void)getAllRegionList{
    
    [[HF_NetWorkRequestManager sharedNetWorkManager]  GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_getAllRegionList_url] isNeedNetStatus:true isNeedWait:true parameters:nil finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            BaseResultModel * baseVM  = [[BaseResultModel alloc]initWithDictionary:(NSDictionary *)object error:nil];
            self.returnBlock(baseVM);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            self.faileBlock();
        }
    }];
}

#pragma  mark - 视频认证相关
-(void)obtainVideoVerifyContent{
    [[HF_NetWorkRequestManager sharedNetWorkManager]  GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_VideoVerify_url] isNeedNetStatus:true isNeedWait:true parameters:nil finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            BaseResultModel * baseVM  = [[BaseResultModel alloc]initWithDictionary:(NSDictionary *)object error:nil];
            self.returnBlock(baseVM);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            self.faileBlock();
        }
    }];
}

-(void)uploadVerifyVideo:(NSString *)videoBase64Str {
    
    NSDictionary * paramDic = @{@"b64video":videoBase64Str};
    [[HF_NetWorkRequestManager sharedNetWorkManager]DataRequestWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_uploadVideoVideo_url] isNeedNetStatus:true isNeedWait:false parameters:paramDic finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            BaseResultModel * baseVM  = [[BaseResultModel alloc]initWithDictionary:(NSDictionary *)object error:nil];
            self.returnBlock(baseVM);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            self.faileBlock();
        }
    }];
    

}

#pragma mark - 用户身份证上传
/**
 身份证图片上传

 @param imageBase64Str  图片的base64
 @param frontOfBack 正面或者反面
 @param imageType 图片后缀名
 */
-(void)userIDCardUpload:(NSString *)imageBase64Str frontOfBack:(NSString *)frontOfBack imageType:(NSString *)imageType{
    
    IDCardUploadParam * param = [[IDCardUploadParam alloc]init];
    param.idCardSelf = imageBase64Str;
    param.side = frontOfBack;
    param.suffix = imageType;
    NSDictionary * dic = [param toDictionary];
    
    [[HF_NetWorkRequestManager sharedNetWorkManager]DataRequestWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_UserIDCardUpload_url] isNeedNetStatus:true isNeedWait:true parameters:dic finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            BaseResultModel * baseVM  = [[BaseResultModel alloc]initWithDictionary:(NSDictionary *)object error:nil];
            self.returnBlock(baseVM);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            self.faileBlock();
        }
    }];
}









@end
