//
//  PserInfoViewModel.h
//  fxdProduct
//
//  Created by sxp on 17/6/7.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "FXD_ViewModelBaseClass.h"

@interface PserInfoViewModel : FXD_ViewModelBaseClass



/**
 保存身份证识别信息
 
 @param image 图片
 @param side 前后
 @param result 三方识别结果
 */
-(void)saveUserIDCardImage:(UIImage *)image carSide:(NSString *)side faceResult:(id)result;


@end
