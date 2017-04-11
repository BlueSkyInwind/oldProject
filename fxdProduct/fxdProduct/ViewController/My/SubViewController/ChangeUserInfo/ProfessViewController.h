//
//  ProfessViewController.h
//  fxdProduct
//
//  Created by dd on 16/1/25.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "BaseViewController.h"

@interface ProfessViewController : BaseViewController

@property (strong, nonatomic) IBOutlet UITableView *myTable;

@property (strong, nonatomic) IBOutlet UIButton *saveBtn;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *cancleBtn;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *doneBtn;

@property (strong, nonatomic) IBOutlet UIToolbar *toolBarView;

@end
