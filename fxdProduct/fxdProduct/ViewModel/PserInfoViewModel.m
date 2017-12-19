//
//  PserInfoViewModel.m
//  fxdProduct
//
//  Created by sxp on 17/6/7.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "PserInfoViewModel.h"
#import "CustomerIDInfo.h"

@implementation PserInfoViewModel

/**
 保存身份证识别信息

 @param image 图片
 @param side 前后
 @param result 三方识别结果
 */
-(void)saveUserIDCardImage:(UIImage *)image carSide:(NSString *)side faceResult:(id)result{
    
    NSData *data = UIImageJPEGRepresentation(image, 0.2);
    NSString *cardStr = [GTMBase64 stringByEncodingData:data];
    
    NSDictionary *dic = [NSDictionary dictionaryWithDictionary:result];
    NSData *resultData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonStr = [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
    
    CustomerIDInfoParam * customerIDInfoP = [[CustomerIDInfoParam alloc]init];
    customerIDInfoP.idCardSelf = cardStr;
    customerIDInfoP.records = jsonStr;
    customerIDInfoP.side = side;
    NSDictionary * paramDic = [customerIDInfoP toDictionary];
    [[FXD_NetWorkRequestManager sharedNetWorkManager] DataRequestWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_saveIDInfo_url] isNeedNetStatus:true isNeedWait:true parameters:paramDic finished:^(EnumServerStatus status, id object) {
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
