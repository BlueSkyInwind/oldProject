//
//  LoanProcessViewController.h
//  fxdProduct
//
//  Created by dd on 2017/2/7.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "BaseViewController.h"
@class LoanProcessModel,UserStateModel;

@interface LoanProcessViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) LoanProcessModel *loanProcessParse;

@end
