//
//  HelpViewController.h
//  fxdProduct
//
//  Created by zhangbaochuan on 15/10/9.
//  Copyright © 2015年 dd. All rights reserved.
//

#import "BaseViewController.h"

@interface AboutViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITableView *tableview;
- (IBAction)telephoneBtn:(id)sender;
- (IBAction)ideaBtn:(id)sender;

@end
