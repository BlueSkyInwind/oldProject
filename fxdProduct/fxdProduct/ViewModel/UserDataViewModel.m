//
//  UserDataViewModel.m
//  fxdProduct
//
//  Created by admin on 2017/8/22.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "UserDataViewModel.h"
#import "FaceIDLiveModel.h"

@implementation UserDataViewModel


-(void)uploadLiveIdentiInfo:(FaceIDData *)imagesDic{
    
    NSDictionary *paramDic = @{@"api_key":FaceIDAppKey,
                               @"api_secret":FaceIDAppSecret,
                               @"comparison_type":@1,
                               @"face_image_type":@"meglive",
                               @"idcard_name":[Utility sharedUtility].userInfo.realName,
                               @"idcard_number":[Utility sharedUtility].userInfo.userIDNumber,
                               @"delta":imagesDic.delta};
    
    [[FXDNetWorkManager sharedNetWorkManager] POSTUpLoadImage:_verifyLive_url FilePath:imagesDic.images parameters:paramDic finished:^(EnumServerStatus status, id object) {
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
        //        NSError *error = object;
        //
        //        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:[NSString stringWithFormat:@"Error-%ld",(long)error.code]];
    }];
}


- (void)uploadLiveInfo:(NSString *)resultJSONStr isSuccess:(void(^)(id object))success
{
    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_detectInfo_url] parameters:@{@"records":resultJSONStr} finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            self.returnBlock(object);
        }
        success(object);
    } failure:^(EnumServerStatus status, id object) {
        
    }];
}




@end
