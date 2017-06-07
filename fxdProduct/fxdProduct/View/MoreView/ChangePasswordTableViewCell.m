//
//  ChangePasswordTableViewCell.m
//  fxdProduct
//
//  Created by admin on 2017/6/2.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "ChangePasswordTableViewCell.h"

@implementation ChangePasswordTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        [self configureView];
    }
    return self;
}


-(void)configureView{
    
    self.backView = [[UIView alloc]init];
    [Tool setCorner:self.backView borderColor:UI_MAIN_COLOR];
    [self.contentView addSubview:self.backView];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(17);
        make.right.equalTo(self.contentView.mas_right).with.offset(-17);
        make.top.equalTo(self.contentView.mas_top).with.offset(5);
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-5);
    }];
   
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.font = [UIFont systemFontOfSize:17];
    self.titleLabel.textColor = UI_MAIN_COLOR;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.backView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView.mas_left).with.offset(8);
        make.height.equalTo(@30);
        make.centerY.equalTo(self.backView.mas_centerY);
        make.width.equalTo(@100);
    }];
    
    self.lineView  = [[UIView alloc]init];
    self.lineView.backgroundColor = UI_MAIN_COLOR;
    [self.backView addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right).with.offset(5);
        make.width.equalTo(@1);
        make.height.equalTo(@30);
        make.centerY.equalTo(self.backView.mas_centerY);
    }];
    
    self.contentTextField = [[UITextField alloc]init];
    self.contentTextField.font = [UIFont systemFontOfSize:15];
    self.contentTextField.secureTextEntry = YES;
    self.contentTextField.clearsOnBeginEditing = YES;
    self.contentTextField.delegate =self;
    [self.backView addSubview:self.contentTextField];
    [self.contentTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.lineView.mas_right).with.offset(5);
        make.right.equalTo(self.contentView.mas_right).with.offset(10);
        make.centerY.equalTo(self.backView.mas_centerY);
        make.height.equalTo(@30);
        
    }];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:KCharacterNumber] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL canChange = [string isEqualToString:filtered];
    
    NSString *stringLength=[NSString stringWithFormat:@"%@%@",self.contentTextField.text,string];
    if ([stringLength length]>11) {
        return NO;
    }else{
        if (canChange) {
            return YES;
        }
        return NO;
    }
    
    return YES;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
