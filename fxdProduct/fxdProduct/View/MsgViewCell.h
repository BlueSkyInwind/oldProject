//
//  MsgViewCell.h
//  fxdProduct
//
//  Created by zy on 15/11/6.
//  Copyright © 2015年 dd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MsgViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblContent;
@property (weak, nonatomic) IBOutlet UIImageView *backImage;
@property (weak, nonatomic) IBOutlet UIImageView *titleImage;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblDate;
@end
