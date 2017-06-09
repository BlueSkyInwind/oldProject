//
//  RepayWeeklyRecordViewModel.m
//  fxdProduct
//
//  Created by sxp on 17/6/9.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "RepayWeeklyRecordViewModel.h"

@implementation RepayWeeklyRecordViewModel

-(void)getRepayHistoryList{

    [[FXDNetWorkManager sharedNetWorkManager]POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_getRepayHistory_url] parameters:nil finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            self.returnBlock(object);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            [self faileBlock];
        }
    }];
}

-(void)getMoneyHistoryList{

    [[FXDNetWorkManager sharedNetWorkManager]POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_getMoneyHistory_url] parameters:nil finished:^(EnumServerStatus status, id object) {
        
        if (self.returnBlock) {
            self.returnBlock(object);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            [self faileBlock];
        }
    }];
}

-(void)getUserRedpacketList{

    [[FXDNetWorkManager sharedNetWorkManager]POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_getUserRedpacket_url] parameters:nil finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            self.returnBlock(object);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            [self faileBlock];
        }
    }];
}

-(void)bankCardList{

    [[FXDNetWorkManager sharedNetWorkManager]POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_cardList_url] parameters:nil finished:^(EnumServerStatus status, id object) {
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
