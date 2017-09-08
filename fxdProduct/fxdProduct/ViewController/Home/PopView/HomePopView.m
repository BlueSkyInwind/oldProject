//
//  HomePopView.m
//  fxdProduct
//
//  Created by dd on 16/9/1.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "HomePopView.h"
#import "LewPopupViewAnimationSpring.h"
#import "UIViewController+LewPopupViewController.h"

@implementation HomePopView

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
        frame.size.width = 375;
        frame.size.height = 660;
        
        if (UI_IS_IPHONE5) {
            frame.size.width = 300;
            frame.size.height = 500;
        }
        if (UI_IS_IPHONE) {
            frame.size.width = 355;
            frame.size.height = 600;
        }
        self.frame = frame;
//        _innerView.frame = frame;
//        [self addSubview:_innerView];
        self.imageView.userInteractionEnabled = true;
//        self.imageView.contentMode = UIViewContentModeScaleToFill;
        UITapGestureRecognizer *tapImage = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTap)];
        tapImage.numberOfTapsRequired = 1;
        tapImage.numberOfTouchesRequired = 1;
        [self.imageView addGestureRecognizer:tapImage];
        
    }
    return self;
}

- (void)imageTap
{
    [self.delegate imageTap];
}

- (IBAction)closeBtn:(UIButton *)sender {
    [_parentVC lew_dismissPopupViewWithanimation:[LewPopupViewAnimationSpring new]];
}

+ (instancetype)defaultPopupView{
    
    return [[HomePopView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];;
}

@end
