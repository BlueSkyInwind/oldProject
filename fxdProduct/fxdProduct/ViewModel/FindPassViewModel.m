//
//  FindPassViewModel.m
//  fxdProduct
//
//  Created by dd on 16/1/7.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "FindPassViewModel.h"
#import "ReturnMsgBaseClass.h"

@implementation FindPassViewModel

- (void)fatchFindPass:(NSDictionary *)paramDic
{
    [[FXD_NetWorkRequestManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_forget_url] parameters:paramDic finished:^(EnumServerStatus status, id object) {
        ReturnMsgBaseClass *findParse = [ReturnMsgBaseClass modelObjectWithDictionary:object];
        self.returnBlock(findParse);
    } failure:^(EnumServerStatus status, id object) {
        [self faileBlock];
    }];
}

@end
