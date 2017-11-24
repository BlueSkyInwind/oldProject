//
//  HomeLoanViewController.h
//  fxdProduct
//
//  Created by zhangbaochuan on 15/12/8.
//  Copyright © 2015年 dd. All rights reserved.
//

#import "BaseViewController.h"

@interface HomeLoanViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITextField *moneyTextField;
@property (weak, nonatomic) IBOutlet UISwitch *switchThird;
@property (weak, nonatomic) IBOutlet UISwitch *switchFirth;
- (IBAction)switchThird:(id)sender;
- (IBAction)switchFirth:(id)sender;


@property (weak, nonatomic) IBOutlet UILabel *labelWeek;
@property (weak, nonatomic) IBOutlet UILabel *labelTotalMoney;

- (IBAction)sureBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

- (IBAction)BtnIdea:(id)sender;


//传值
@property (strong, nonatomic) NSString *totalMoney;
@property (assign, nonatomic) BOOL weekSel;
@end
