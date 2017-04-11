//
//  BasicInfoViewController.h
//  fxdProduct
//
//  Created by dd on 16/1/25.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "BaseViewController.h"

@interface BasicInfoViewController : BaseViewController

@property (strong, nonatomic) IBOutlet UITableView *myTable;

@property (strong, nonatomic) IBOutlet UIButton *saveBtn;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbarCancelDone;
- (IBAction)cancleBtn:(id)sender;
- (IBAction)donebtn:(id)sender;

@end
