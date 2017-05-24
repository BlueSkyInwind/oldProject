//
//  ChangeBankCardViewController.h
//  fxdProduct
//
//  Created by sxp on 17/5/24.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "BaseViewController.h"

@interface ChangeBankCardViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITableView *changTab;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@property (nonatomic,strong)NSString *ordsms_ext_;

@end
