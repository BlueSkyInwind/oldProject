//
//  LoanMoneyViewModel.m
//  fxdProduct
//
//  Created by sxp on 17/6/9.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "LoanMoneyViewModel.h"
#import "ProductProtocolParamModel.h"
@implementation LoanMoneyViewModel

-(void)getProductProtocol:(NSArray *)paramArray{

    ProductProtocolParamModel *productProtocolParamModel = [[ProductProtocolParamModel alloc]init];
    if (paramArray.count==5) {
        
        productProtocolParamModel.apply_id_ = paramArray[0];
        productProtocolParamModel.product_id_ = paramArray[1];
        productProtocolParamModel.protocol_type_ = paramArray[2];
        productProtocolParamModel.card_no_ = paramArray[3];
        productProtocolParamModel.card_bank_ = paramArray[4];
        
    }else{
    
        productProtocolParamModel.apply_id_ = paramArray[0];
        productProtocolParamModel.product_id_ = paramArray[1];
        productProtocolParamModel.protocol_type_ = paramArray[2];
        productProtocolParamModel.periods_ = paramArray[3];
    }
    NSDictionary *paramDic = [productProtocolParamModel toDictionary];
    
    [[FXDNetWorkManager sharedNetWorkManager]POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_productProtocol_url] parameters:paramDic finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            self.returnBlock(object);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            [self faileBlock];
        }
    }];
}


-(void)getContractList:(NSString *)bid_id{

    NSDictionary *paramDic = @{@"bid_id_":bid_id};
    [[FXDNetWorkManager sharedNetWorkManager]P2POSTWithURL:[NSString stringWithFormat:@"%@%@",_p2P_url,_contractList_url] parameters:paramDic finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            self.returnBlock(object);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            [self faileBlock];
        }
    }];
}

-(void)getApprovalAmount{

    [[FXDNetWorkManager sharedNetWorkManager]POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_approvalAmount_jhtml] parameters:nil finished:^(EnumServerStatus status, id object) {
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
