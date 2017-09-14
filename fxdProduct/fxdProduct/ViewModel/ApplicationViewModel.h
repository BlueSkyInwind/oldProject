//
//  ApplicationViewModel.h
//  fxdProduct
//
//  Created by admin on 2017/8/31.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "ViewModelClass.h"

@interface ApplicationViewModel : ViewModelClass


/**
 用户创建进件
 */
-(void)userCreateApplication:(NSString *)productId;


/**
 申请确认页信息
 */
-(void)queryApplicationInfo:(NSString *)productId;


@end
