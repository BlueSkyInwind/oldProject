;//
//  CheckProcessViewController.h
//  fxdProduct
//
//  Created by dd on 15/8/28.
//  Copyright (c) 2015年 dd. All rights reserved.
//

#import "BaseViewController.h"
#import "GetMoneyProcessBaseClass.h"

@protocol CheckProcessDelegate <NSObject>

-(void)GetCheckDelegate;

@end

@interface CheckProcessViewController : BaseViewController

@property(nonatomic, strong)GetMoneyProcessResult *reslutModel;

@property(nonatomic, assign)NSInteger proTag;

@property(nonatomic, weak)id<CheckProcessDelegate>delegate;

@end
