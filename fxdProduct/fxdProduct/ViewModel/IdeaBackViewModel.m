//
//  IdeaBackViewModel.m
//  fxdProduct
//
//  Created by sxp on 17/6/6.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "IdeaBackViewModel.h"

@implementation IdeaBackViewModel

-(void)saveFeedBackContent:(NSString *)content{

    NSDictionary *paramDic = @{
                               @"content_":content,
                               @"feedback_way_":PLATFORM,
                               };
    
    [[FXDNetWorkManager sharedNetWorkManager]POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_feedBack_url] parameters:paramDic finished:^(EnumServerStatus status, id object) {
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
