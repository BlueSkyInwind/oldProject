//
//  UnbundlingBankCardViewController.h
//  fxdProduct
//
//  Created by sxp on 17/5/23.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "BaseViewController.h"
#import "QueryCardInfo.h"
@interface UnbundlingBankCardViewController : BaseViewController

@property (nonatomic,copy)NSString *bankNo;
@property (nonatomic,copy)NSString *bankNum;
@property (nonatomic,copy)NSString *mobile;
@property (weak, nonatomic) IBOutlet UITableView *bankTable;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (nonatomic,strong)QueryCardInfo *queryCardInfo;
@end
