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
    
    [[FXD_NetWorkRequestManager sharedNetWorkManager]GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_CountStationLetterMsg_url] isNeedNetStatus:false parameters:nil finished:^(EnumServerStatus status, id object) {
        
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
    NSDictionary *paramDic = @{@"pageNum":pageNum,@"pageSize":pageSize};
    [[FXD_NetWorkRequestManager sharedNetWorkManager]GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_ShowMsgPreview_url] isNeedNetStatus:true parameters:paramDic finished:^(EnumServerStatus status, id object) {
        
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
