//
//  GesturesPasswordCell.h
//  fxdProduct
//
//  Created by zy on 15/12/23.
//  Copyright © 2015年 dd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GesturesPasswordCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

@property (strong, nonatomic) IBOutlet UISwitch *passwordSwitch;

@end
