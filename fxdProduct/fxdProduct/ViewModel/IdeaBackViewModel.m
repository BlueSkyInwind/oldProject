//
//  IdeaBackViewModel.m
//  fxdProduct
//
//  Created by sxp on 17/6/6.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "IdeaBackViewModel.h"
#import "IdeaBackParamModel.h"
@implementation IdeaBackViewModel

-(void)saveFeedBackContent:(NSString *)content{

    IdeaBackParamModel *ideaBackParamModel = [[IdeaBackParamModel alloc]init];
    ideaBackParamModel.content_ = content;
    ideaBackParamModel.feedback_way_ = PLATFORM;
    
    NSDictionary * paramDic  = [ideaBackParamModel toDictionary];
    
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
