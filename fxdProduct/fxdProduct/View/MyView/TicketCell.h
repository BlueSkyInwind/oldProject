//
//  TicketCell.h
//  fxdProduct
//
//  Created by zy on 16/5/23.
//  Copyright © 2016年 dd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RedpacketBaseClass.h"
#import "DiscountTicketModel.h"
@interface TicketCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *TicketImgView;
@property (nonatomic,strong) UILabel *lblTitle;
@property (nonatomic,strong) UILabel *lblPrice;
@property (nonatomic,strong) UILabel *lblTip;
@property (nonatomic,strong) UILabel *lblName;
@property (nonatomic,strong) UILabel *lblOverTime;
@property (nonatomic,strong) UIImageView *lblOverTimeImageView;

-(void)setValues:(RedpacketResult *)redPacketModel;
- (void)setInvailsValues:(DiscountTicketDetailModel *)discountTicketDetailM;

@end
