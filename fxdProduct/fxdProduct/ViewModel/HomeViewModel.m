//
//  HomeViewModel.m
//  fxdProduct
//
//  Created by dd on 15/12/25.
//  Copyright © 2015年 dd. All rights reserved.
//

#import "HomeViewModel.h"

@implementation HomeViewModel





- (void)fetchUserState:(NSDictionary *)paramDic
{
//    NSDictionary *dicParam = @{@"token":[Utility sharedUtility].userInfo.tokenStr};
    
    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_userState_url] parameters:paramDic finished:^(EnumServerStatus status, id object) {
        self.returnBlock(object);
//        [self fetchValueSuccessWithDic:object];
    } failure:^(EnumServerStatus status, id object) {
        [self faileBlock];
    }];
}



@end
