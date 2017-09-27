//
//  FXDWebViewController.h
//  fxdProduct
//
//  Created by dd on 2016/11/25.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "BaseViewController.h"

@interface FXDWebViewController : BaseViewController

@property (nonatomic, copy)NSString * urlStr;

@property (nonatomic, copy) NSString * loadContent;

@property (nonatomic,assign)BOOL isZhima;

@property (nonatomic, copy)NSString * payType;  // 1、还款   2、续期


@end
