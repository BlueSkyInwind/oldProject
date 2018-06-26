//
//  MessageViewModel.m
//  fxdProduct
//
//  Created by sxp on 2017/12/6.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "MessageViewModel.h"

@implementation MessageViewModel

-(void)countStationLetterMsg{
    
    NSDictionary *paramDic = @{@"appType":@"2"};
    [[HF_NetWorkRequestManager sharedNetWorkManager]GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_CountStationLetterMsg_url] isNeedNetStatus:false isNeedWait:true parameters:paramDic finished:^(EnumServerStatus status, id object) {
        
        if (self.returnBlock) {
            self.returnBlock(object);
        }
        
    } failure:^(EnumServerStatus status, id object) {
        
        if (self.faileBlock) {
            [self faileBlock];
        }
        
    }];
}


-(void)showMsgPreviewPageNum:(NSString *)pageNum pageSize:(NSString *)pageSize{
    NSDictionary *paramDic = @{@"pageNum":pageNum,@"pageSize":pageSize,@"appType":@"2"};
    [[HF_NetWorkRequestManager sharedNetWorkManager]GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_ShowMsgPreview_url] isNeedNetStatus:true isNeedWait:true parameters:paramDic finished:^(EnumServerStatus status, id object) {
        
        if (self.returnBlock) {
            self.returnBlock(object);
        }
        
    } failure:^(EnumServerStatus status, id object) {
        
        if (self.faileBlock) {
            [self faileBlock];
        }
        
    }];
}

-(void)delMsgDelType:(NSString *)delType operUserMassgeId:(NSString *)operUserMassgeId{
    
    NSDictionary *paramDic = @{@"delType":delType,@"operUserMassgeId":operUserMassgeId};
    [[HF_NetWorkRequestManager sharedNetWorkManager]GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_delMsg_url] isNeedNetStatus:true isNeedWait:true parameters:paramDic finished:^(EnumServerStatus status, id object) {
        
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
