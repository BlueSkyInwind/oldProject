//
//  ChangePasswordTableViewCell.h
//  fxdProduct
//
//  Created by admin on 2017/6/2.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangePasswordTableViewCell : UITableViewCell<UITextFieldDelegate>

@property (nonatomic,strong)UIView * backView;
@property (nonatomic,strong)UILabel * titleLabel;
@property (nonatomic,strong)UIView * lineView;
@property (nonatomic,strong)UITextField * contentTextField;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier;

-(void)updateTitleWidth:(NSString *_Nullable)title;


@end
