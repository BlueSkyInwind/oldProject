//
//  LoanMoneyViewModel.m
//  fxdProduct
//
//  Created by sxp on 17/6/9.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "LoanMoneyViewModel.h"
#import "ProductProtocolParamModel.h"
#import "P2PContactContenParam.h"

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

-(void)getContactCon:(NSString *)pact_no_  Bid_id_:(NSString *)bid_id_  Debt_id_:(NSString *)debt_id_{
    
    P2PContactContenParam * p2PContactContenParam = [[P2PContactContenParam alloc]init];
    p2PContactContenParam.pact_no_ = pact_no_;
    p2PContactContenParam.bid_id_ = bid_id_;
    p2PContactContenParam.debt_id_ = debt_id_;
    p2PContactContenParam.status_ = @"2";
    NSDictionary *paramDic = [p2PContactContenParam toDictionary];
    
    [[FXDNetWorkManager sharedNetWorkManager] P2POSTWithURL:[NSString stringWithFormat:@"%@%@",_p2P_url,_contractStr_url] parameters:paramDic finished:^(EnumServerStatus status, id object) {
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


-(void)getApplicationStatus:(NSString *)flag{

    NSDictionary *paramDic = @{@"flag":flag};
    
    [[FXDNetWorkManager sharedNetWorkManager]GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_ApplicationStatus_url] parameters:paramDic finished:^(EnumServerStatus status, id object) {
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
