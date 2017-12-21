//
//  MyCardCell.h
//  fxdProduct
//
//  Created by zhangbaochuan on 15/12/28.
//  Copyright © 2015年 dd. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^editBlock)(int  flag) ;
@interface MyCardCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *bankCompanyLabel;
@property (weak, nonatomic) IBOutlet UILabel *banklist;
@property (weak, nonatomic) IBOutlet UILabel *bankNum;
@property (strong,nonatomic) editBlock myBlock;
@property (assign,nonatomic) int cardTypeFlag;
- (IBAction)btnEditInfo:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnEdit;

@property (weak, nonatomic) IBOutlet UILabel *defaultFlag;


@end
