//
//  TicketDetailController.h
//  fxdProduct
//
//  Created by zy on 16/2/16.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "BaseViewController.h"
#import "RedpacketResult.h"

@interface TicketDetailController : BaseViewController
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic, strong) RedpacketResult *redPacketModel;
@end
