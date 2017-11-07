//
//  MainProgressViewController.h
//  fxdProduct
//
//  Created by zy on 15/12/8.
//  Copyright © 2015年 dd. All rights reserved.
//

#import "BaseViewController.h"

@interface MainProgressViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,assign) NSInteger stateFlag;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblDetailText;
@property (weak, nonatomic) IBOutlet UILabel *lblTipText;
- (IBAction)submitBtnClick:(id)sender;
@end
