//
//  HomeIDCardViewController.h
//  fxdProduct
//
//  Created by zhangbaochuan on 15/12/8.
//  Copyright © 2015年 dd. All rights reserved.
//

#import "BaseViewController.h"

@interface HomeIDCardViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIView *topIdView;
@property (weak, nonatomic) IBOutlet UIView *botomIdView;

@property (weak, nonatomic) IBOutlet UIView *hiddeninfoView;
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelCard;
@property (weak, nonatomic) IBOutlet UILabel *labelCompany;
@property (weak, nonatomic) IBOutlet UILabel *labelDate;

@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
- (IBAction)sureBtn:(id)sender;
@end
