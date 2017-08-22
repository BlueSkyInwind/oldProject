//
//  UnfoldTableViewCell.h
//  fxdProduct
//
//  Created by admin on 2017/8/21.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^UnfoldBtnClick)();

@interface UnfoldTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImageView;

@property (weak, nonatomic) IBOutlet UIView *tapView;
@property(copy,nonatomic)UnfoldBtnClick  unfoldBtnClick;
@end
