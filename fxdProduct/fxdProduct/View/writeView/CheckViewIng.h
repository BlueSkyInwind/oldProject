//
//  CheckViewIng.h
//  fxdProduct
//
//  Created by zhangbaochuan on 16/1/27.
//  Copyright © 2016年 dd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CheckViewIng : UIView


@property (weak, nonatomic) IBOutlet UILabel *promptLabel;

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@property (weak, nonatomic) IBOutlet UIButton *receiveImmediatelyBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerViewHeader;

@end
