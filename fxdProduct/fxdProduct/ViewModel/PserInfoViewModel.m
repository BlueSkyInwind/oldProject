//
//  PserInfoViewModel.m
//  fxdProduct
//
//  Created by sxp on 17/6/7.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "PserInfoViewModel.h"

@implementation PserInfoViewModel

-(void)getAllRegionList{

    [[FXDNetWorkManager sharedNetWorkManager]POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_getAllRegionList_url] parameters:nil finished:^(EnumServerStatus status, id object) {
        
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
