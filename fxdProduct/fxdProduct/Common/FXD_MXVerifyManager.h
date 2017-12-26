//
//  FXD_MXVerifyManager.h
//  fxdProduct
//
//  Created by admin on 2017/12/25.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MoxieSDK.h"

typedef void(^MXVerifyResult)(NSDictionary * resultDic);
@interface FXD_MXVerifyManager : NSObject<MoxieSDKDelegate>

+ (FXD_MXVerifyManager *)sharedInteraction;

/**
 魔蝎启动

 @param vc 当前视图
 @param mxResult 结果回调
 */
-(void)configMoxieSDKViewcontroller:(UIViewController *)vc  mxResult:(MXVerifyResult)mxResult;
//网银
- (void)Internetbank;
//邮箱导入
- (void)mailImportClick;
//社保导入
-(void)securityImportClick;


@end
