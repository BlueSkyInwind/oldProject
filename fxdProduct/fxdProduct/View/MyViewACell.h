//
//  MyViewACell.h
//  fxdProduct
//
//  Created by dd on 15/8/19.
//  Copyright (c) 2015年 dd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyViewACell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UIImageView *mineBackGround;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;

@property (strong, nonatomic) IBOutlet UILabel *weekRepayLabel;



@end
