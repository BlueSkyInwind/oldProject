//
//  ApplicationViewModel.m
//  fxdProduct
//
//  Created by admin on 2017/8/31.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "ApplicationViewModel.h"

@implementation ApplicationViewModel


-(void)userCreateApplication:(NSString *)productId{
    
    NSDictionary * paramDic = @{@"productId":productId};

    [[FXDNetWorkManager sharedNetWorkManager] GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_createApplication_url] isNeedNetStatus:true parameters:paramDic finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            self.returnBlock(object);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            [self faileBlock];
        }
    }];
}


-(void)queryApplicationInfo:(NSString *)productId{

    NSDictionary * paramDic = @{@"productId":productId};

    [[FXDNetWorkManager sharedNetWorkManager] GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_ApplicationViewInfo_url] isNeedNetStatus:true parameters:paramDic finished:^(EnumServerStatus status, id object) {
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
