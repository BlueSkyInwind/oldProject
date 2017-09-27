//
//  CheckSuccessView.m
//  fxdProduct
//
//  Created by zhangbaochuan on 16/1/27.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "CheckSuccessView.h"

@implementation CheckSuccessView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (void)awakeFromNib
{
    [super awakeFromNib];
    [Tool setCorner:self.sureBtn borderColor:[UIColor whiteColor]];
    [Tool setCorner:self.promote borderColor:[UIColor whiteColor]];
    [Tool setCorner:self.bankView borderColor:UI_MAIN_COLOR];
    UIImage *btnImg = [UIImage imageNamed:@"trick"];
    UIImage *selectImg = [UIImage imageNamed:@"tricked"];
    [_userCheckBtn setImage:btnImg forState:UIControlStateNormal];
    [_userCheckBtn setImage:selectImg forState:UIControlStateSelected];
    _userCheckBtn.selected = NO;
}

- (BOOL)userCheckBtnState
{
    return _userCheckBtn.selected;
}

- (YYLabel *)moneyLabel
{
    if (_moneyLabel == nil) {
        _moneyLabel = [YYLabel new];
        _moneyLabel.textVerticalAlignment = YYTextVerticalAlignmentCenter;
        _moneyLabel.numberOfLines = 0;
        _moneyLabel.font = [UIFont systemFontOfSize:20];
//        [self.displayMoneyView addSubview:_moneyLabel];
        [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@32);
            make.left.equalTo(@0);
            make.right.equalTo(@0);
            make.bottom.equalTo(@0);
        }];
    }
    return _moneyLabel;
}

- (YYLabel *)agreementLabel
{
    if (_agreementLabel == nil) {
        _agreementLabel = [YYLabel new];
        _agreementLabel.textAlignment = NSTextAlignmentLeft;
        _agreementLabel.textVerticalAlignment = YYTextVerticalAlignmentCenter;
        _agreementLabel.numberOfLines = 0;
        _agreementLabel.font = [UIFont systemFontOfSize:15];
        [self.userCheckView addSubview:_agreementLabel];
        [_agreementLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@18);
            make.left.equalTo(_userCheckBtn.mas_right).offset(5);
            make.right.equalTo(@(-10));
            make.top.equalTo(_userCheckView.mas_top).offset(0);
//            make.centerY.equalTo(_userCheckView.mas_centerY);
        }];
    }
    return _agreementLabel;
}


- (IBAction)userCheck:(UIButton *)sender {
    _userCheckBtn.selected = !_userCheckBtn.selected;
    if (self.agreementStatus) {
        self.agreementStatus(sender);
    }
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    if(_k_h == 568)
    {
        CGRect rect = _labelFirst.frame;
        rect.origin.y=rect.origin.y+5;
        _labelFirst.frame=rect;
        
        rect = _circleFirst.frame;
        rect.origin.y=rect.origin.y+5;
        _circleFirst.frame=rect;
        
        rect = _arrowFirst.frame;
        rect.origin.y = rect.origin.y+5;
        _arrowFirst.frame = rect;
        
        rect = _labelSecond.frame;
        rect.origin.y = rect.origin.y+5;
        _labelSecond.frame = rect;
        
        rect = _circleSecond.frame;
        rect.origin.y = rect.origin.y+5;
        _circleSecond.frame = rect;
        
        rect = _arrowThird.frame;
        rect.origin.y = rect.origin.y+5;
        _arrowThird.frame = rect;
        
        rect = _circleThird.frame;
        rect.origin.y = rect.origin.y+5;
        _circleThird.frame = rect;
        
        rect = _labelThird.frame;
        rect.origin.y = rect.origin.y+5;
        _labelThird.frame = rect;
        
        _weekMoney.font=[UIFont systemFontOfSize:13];
        _allMoney.font=[UIFont systemFontOfSize:13];
        _displayLabel.font = [UIFont systemFontOfSize:11];
        _feeBtn.titleLabel.font = [UIFont systemFontOfSize:11];
        [self setNeedsLayout];
    }
    
    if(UI_IS_IPHONE6P){
        
        self.displayLabelLeftCons.constant = 40;
    }
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // add subviews
    }
    return self;
}

- (IBAction)toolCancleBtn:(id)sender {
}

- (IBAction)toolSureBtn:(id)sender {
}
@end
