//
//  CreaditCardViewModel.m
//  fxdProduct
//
//  Created by admin on 2018/6/21.
//  Copyright © 2018年 dd. All rights reserved.
//

#import "CreaditCardViewModel.h"

@implementation CreaditCardViewModel

/**
 获取信用卡列表
 */
-(void)obtainCreaditCardListInfoRequest{
//    NSDictionary *dic = @{@"cardHighlightsLen":@"255"};
    [[HF_NetWorkRequestManager sharedNetWorkManager]GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_creaditCardListInfo_url] isNeedNetStatus:true isNeedWait:true parameters:nil finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            BaseResultModel *baseRM = [[BaseResultModel alloc]initWithDictionary:(NSDictionary *)object error:nil];
            self.returnBlock(baseRM);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            self.faileBlock();
        }
    }];
}


/**
 信用卡筛选条件

 @param banktype 银行类型
 @param cardType 卡类型
 @param sort 倒序正序
 */
-(void)obtainCreaditCardListConditionRequest:(NSString *)banktype cardType:(NSString *)cardType sort:(BOOL)sort{
    CreaditCardConditionParam * param = [[CreaditCardConditionParam alloc]init];
    if (![banktype isEqualToString:@"-1"]) {
        param.bankInfoId = banktype;
    }
    if (![cardType isEqualToString:@"-1"]) {
        param.cardLevel = cardType;
    }
    if (sort) {
        param.sort = @"ASC";
    }else{
        param.sort = @"DESC";
    }

    NSDictionary * dic = [param toDictionary];
    
    [[HF_NetWorkRequestManager sharedNetWorkManager]GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_conditionScreening_url] isNeedNetStatus:true isNeedWait:true parameters:dic finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            BaseResultModel *baseRM = [[BaseResultModel alloc]initWithDictionary:(NSDictionary *)object error:nil];
            self.returnBlock(baseRM);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            self.faileBlock();
        }
    }];
}

/**
 提交信用卡跳转记录

 @param third_platform_id 三方id
 */
-(void)submitReaditCardRecord:(NSString *)third_platform_id{
    
    NSDictionary * dic = @{@"third_platform_id":third_platform_id};
 
    [[HF_NetWorkRequestManager sharedNetWorkManager]GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_creaditcardRecord_url] isNeedNetStatus:true isNeedWait:true parameters:dic finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            BaseResultModel *baseRM = [[BaseResultModel alloc]initWithDictionary:(NSDictionary *)object error:nil];
            self.returnBlock(baseRM);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            self.faileBlock();
        }
    }];
}
    




@end
