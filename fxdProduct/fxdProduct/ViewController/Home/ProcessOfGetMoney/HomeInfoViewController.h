//
//  HomeInfoViewController.h
//  fxdProduct
//
//  Created by zhangbaochuan on 15/10/30.
//  Copyright © 2015年 dd. All rights reserved.
//

#import "BaseViewController.h"

@protocol HomeBackRefauseDelegate <NSObject>

-(void)GetHomeBackRefause;

@end

@interface HomeInfoViewController : BaseViewController


@property(weak, nonatomic)id<HomeBackRefauseDelegate>delegate;

@end
