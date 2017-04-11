//
//  LabelCell.h
//  fxdProduct
//
//  Created by zhangbaochuan on 16/1/21.
//  Copyright © 2016年 dd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LabelCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UIButton *btnSecory;

@end
