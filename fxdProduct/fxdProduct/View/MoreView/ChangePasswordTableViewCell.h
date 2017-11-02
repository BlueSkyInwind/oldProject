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
//左边的标题
@property (nonatomic,strong)UILabel * titleLabel;
//底部的线
@property (nonatomic,strong)UIView * lineView;
//右边的内容
@property (nonatomic,strong)UITextField * contentTextField;
//顶部的线
@property (nonatomic,strong)UIView * topLineView;


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier;

-(void)updateTitleWidth:(NSString *_Nullable)title;


@end
