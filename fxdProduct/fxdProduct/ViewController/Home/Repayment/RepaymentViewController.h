//
//  RepaymentViewController.h
//  fxdProduct
//
//  Created by zy on 15/12/7.
//  Copyright © 2015年 dd. All rights reserved.
//

#import "BaseViewController.h"
#import "RepaymentViewCell.h"
#import "testView.h"
#import "JustMakeSureView.h"
#import "RepaymentHelpController.h"
#import "HomeViewModel.h"
#import "RepayMentViewModel.h"
#import "FirstRepayment.h"


@interface RepaymentViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITableView *MyTableIVew;
@property (weak, nonatomic) IBOutlet UITableView *OverTimeTableVIew;
@property (weak, nonatomic) IBOutlet UIButton *btnRepayImmed;
@property (weak, nonatomic) IBOutlet UILabel *lblTotalMoney;
@property (weak, nonatomic) IBOutlet UIScrollView *MyScroll;
@property (weak, nonatomic) IBOutlet UILabel *lblTip;
@property (weak, nonatomic) IBOutlet UIButton *btnReClean;

- (IBAction)btnRepayImmediatelyClick:(id)sender;
- (IBAction)btnRepayClean:(id)sender;
@property (nonatomic,strong) NSString *repayStateFlag;
@property (nonatomic,strong) NSString *repayDate;
@property (nonatomic, copy) NSString *apply_status;

//@property (strong, nonatomic) UserStateBaseClass *userStateParse;
@end
