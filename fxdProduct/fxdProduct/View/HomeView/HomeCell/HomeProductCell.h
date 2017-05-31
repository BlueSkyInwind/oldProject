//
//  HomeProductCell.h
//  fxdProduct
//
//  Created by dd on 2017/1/3.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HomeProductCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *rightImageView;

@property (weak, nonatomic) IBOutlet UIImageView *proLogoImage;

@property (weak, nonatomic) IBOutlet UIView *amountView;

@property (weak, nonatomic) IBOutlet UILabel *periodLabel;

@property (weak, nonatomic) IBOutlet UIImageView *specialtyImage;

@property (weak, nonatomic) IBOutlet UIImageView *helpImage;

@property (weak, nonatomic) IBOutlet UIButton *loanBtn;

@property (strong, nonatomic) YYLabel *amountLabel;

@property (strong, nonatomic) UIImageView * linesLimitImageView;

@property (weak, nonatomic) IBOutlet UIView *centerView;



@end
