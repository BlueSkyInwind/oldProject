//
//  ReplenishViewController.h
//  fxdProduct
//
//  Created by dd on 2016/11/3.
//  Copyright © 2016年 dd. All rights reserved.
//


#import "BaseViewController.h"
@class UserStateModel;

@protocol ReplenishDoneDelegate <NSObject>

- (void)refreshUI;

@end

@interface ReplenishViewController : BaseViewController

@property (nonatomic, weak)id<ReplenishDoneDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITableView *tableview;


@property (weak, nonatomic) IBOutlet UIButton *nextBtn;


@property (nonatomic, strong) UserStateModel *userStateModel;

@end
