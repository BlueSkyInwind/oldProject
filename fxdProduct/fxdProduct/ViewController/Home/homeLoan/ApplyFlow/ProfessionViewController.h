//
//  ProfessionViewController.h
//  fxdProduct
//
//  Created by dd on 2017/2/22.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "BaseViewController.h"
@class CustomerCareerBaseClass,CareerParse;

@protocol ProfessionDataDelegate <NSObject>

- (void)setProfessRule:(CareerParse *)careerParse;

@end

@interface ProfessionViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property (weak, nonatomic) IBOutlet UIToolbar *toolbarCancelDone;

@property (nonatomic, copy) NSString *product_id;

@property (nonatomic, strong) CustomerCareerBaseClass *careerInfo;

@property (nonatomic, weak)id <ProfessionDataDelegate>delegate;

@end
