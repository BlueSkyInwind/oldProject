//
//  ChangeBankCardViewController.h
//  fxdProduct
//
//  Created by sxp on 17/5/23.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "BaseViewController.h"

@interface ChangeBankCardViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet UITableView *changTab;

@property (nonatomic,copy)NSString *ordsms_ext_;

@end
