//
//  DetailRepayHeader.m
//  fxdProduct
//
//  Created by dd on 16/9/1.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "DetailRepayHeader.h"

@implementation DetailRepayHeader

-(void)awakeFromNib{
    [super awakeFromNib];
    
    if (UI_IS_IPHONE5) {
        self.repaymentViewLeftCon.constant  = 0;
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end