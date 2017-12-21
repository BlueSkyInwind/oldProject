//
//  MineViewModel.m
//  fxdProduct
//
//  Created by sxp on 2017/12/21.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "MineViewModel.h"

@implementation MineViewModel

-(void)getExperienceValueGrad{
    
    [[FXD_NetWorkRequestManager sharedNetWorkManager] GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_ExperienceValue_url] isNeedNetStatus:true parameters:nil finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            BaseResultModel *baseRM = [[BaseResultModel alloc]initWithDictionary:(NSDictionary *)object error:nil];
            self.returnBlock(baseRM);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            [self faileBlock];
        }
    }];
    
}
@end
