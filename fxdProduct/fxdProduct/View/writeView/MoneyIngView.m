//
//  MoneyIngView.m
//  fxdProduct
//
//  Created by zhangbaochuan on 16/1/28.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "MoneyIngView.h"

@implementation MoneyIngView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (YYLabel *)agreeMentLabel{
    if (_agreeMentLabel == nil) {
        _agreeMentLabel = [YYLabel new];
        _agreeMentLabel.textVerticalAlignment = YYTextVerticalAlignmentCenter;
        _agreeMentLabel.numberOfLines = 0;
        _agreeMentLabel.font = [UIFont systemFontOfSize:12];
        [self.agreeMentView addSubview:_agreeMentLabel];
        [_agreeMentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(_agreeMentView.mas_height);
            make.left.equalTo(@0);
            make.right.equalTo(@0);
            make.bottom.equalTo(@0);
        }];
    }
    return _agreeMentLabel;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    if(!UI_IS_IPHONE5){
        CGRect rect = _overdueFeeLabel.frame;
        rect.origin.y=rect.origin.y-10;
        _overdueFeeLabel.frame=rect;
        
        CGRect rect1 = _agreementBtn.frame;
        rect1.origin.y=rect1.origin.y+10;
        _agreementBtn.frame=rect1;
        
        CGRect rect2 = _agreeMentView.frame;
        rect2.origin.y=rect2.origin.y+10;
        _agreeMentView.frame=rect2;
        
        [self setNeedsLayout];
    }
}


@end
