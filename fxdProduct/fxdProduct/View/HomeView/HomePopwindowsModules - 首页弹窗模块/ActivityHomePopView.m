//
//  HomePopView.m
//  fxdProduct
//
//  Created by dd on 16/9/1.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "ActivityHomePopView.h"
#import "LewPopupViewAnimationSpring.h"
#import "UIViewController+LewPopupViewController.h"

@implementation ActivityHomePopView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self = [[NSBundle mainBundle] loadNibNamed:[[self class] description] owner:self options:nil].lastObject;
        CGRect frame = self.frame;
        
        frame.size.width = 355;
        frame.size.height = 600;
        
        if (UI_IS_IPHONE5) {
            frame.size.width = 300;
            frame.size.height = 534;
        }
        if (UI_IS_IPHONE6P) {
            frame.size.width = 375;
            frame.size.height = 660;
        }
        
        if (UI_IS_IPHONE4) {
            frame.size.width = 300;
            frame.size.height = 430;
        }
        self.frame = frame;
//        _innerView.frame = frame;
//        [self addSubview:_innerView];
        self.imageView.userInteractionEnabled = true;
//        self.imageView.contentMode = UIViewContentModeScaleToFill;
        UITapGestureRecognizer *tapImage = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(homeActivityPictureClick)];
        tapImage.numberOfTapsRequired = 1;
        tapImage.numberOfTouchesRequired = 1;
        [self.imageView addGestureRecognizer:tapImage];
        
    }
    return self;
}

- (void)homeActivityPictureClick
{
    if (self.activityTap != nil) {
        self.activityTap(1);
    }
//    [self.delegate homeActivityPictureClick];
}

- (IBAction)closeBtn:(UIButton *)sender {
    if (self.activityTap != nil) {
        self.activityTap(0);
    }
}

+ (instancetype)defaultPopupView{
    return [[ActivityHomePopView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];;
}

@end
