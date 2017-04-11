//
//  IdentityCell.h
//  fxdProduct
//
//  Created by dd on 2017/2/22.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IdentityCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *bgView;


@property (weak, nonatomic) IBOutlet UILabel *identityLabel;

@property (weak, nonatomic) IBOutlet UIButton *identityUpBtn;

@property (weak, nonatomic) IBOutlet UIButton *identityBackBtn;

@end
