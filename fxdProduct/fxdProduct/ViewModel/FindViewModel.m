//
//  FindViewModel.m
//  fxdProduct
//
//  Created by sxp on 2018/4/11.
//  Copyright © 2018年 dd. All rights reserved.
//

#import "FindViewModel.h"

@implementation FindViewModel


-(void)hotRecommend{
    
    [[FXD_NetWorkRequestManager sharedNetWorkManager]GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_hotRecommend_url] isNeedNetStatus:true isNeedWait:true parameters:nil finished:^(EnumServerStatus status, id object) {
        
        if (self.returnBlock) {
            self.returnBlock(object);
        }
        
    } failure:^(EnumServerStatus status, id object) {
        
        if (self.faileBlock) {
            [self faileBlock];
        }
        
    }];
}


-(void)recent{
    
    [[FXD_NetWorkRequestManager sharedNetWorkManager]GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_recent_url] isNeedNetStatus:true isNeedWait:true parameters:nil finished:^(EnumServerStatus status, id object) {
        
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
