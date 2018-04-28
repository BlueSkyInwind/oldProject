//
//  CompQueryViewModel.h
//  fxdProduct
//
//  Created by sxp on 2018/3/28.
//  Copyright © 2018年 dd. All rights reserved.
//

#import "FXD_ViewModelBaseClass.h"

@interface CompQueryViewModel : FXD_ViewModelBaseClass

-(void)compQueryLimit:(NSString *)limit maxAmount:(NSString *)maxAmount maxDays:(NSString *)maxDays minAmount:(NSString *)minAmount minDays:(NSString *)minDays offset:(NSString *)offset order:(NSString *)order sort:(NSString *)sort moduleType:(NSString *)moduleType;

-(void)getCompLinkThirdPlatformId:(NSString *)third_platform_id;

@end
