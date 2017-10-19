//
//  LapseDiscountTicketViewController.h
//  fxdProduct
//
//  Created by admin on 2017/10/19.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LapseDiscountTicketViewController : BaseViewController
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray * invalidTicketArr;

- (void)setInvailsValues:(DiscountTicketDetailModel *)discountTicketDetailM;

@end
