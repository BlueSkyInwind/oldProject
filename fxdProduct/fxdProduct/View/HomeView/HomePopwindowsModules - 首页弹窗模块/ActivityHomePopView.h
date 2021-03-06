//
//  HomePopView.h
//  fxdProduct
//
//  Created by dd on 16/9/1.
//  Copyright © 2016年 dd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PopViewDelegate <NSObject>

- (void)homeActivityPictureClick;

@end

@interface ActivityHomePopView : UIView

@property (nonatomic, weak)id<PopViewDelegate> delegate;

@property (nonatomic, weak)UIViewController *parentVC;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UIButton *closeBtn;


+ (instancetype)defaultPopupView;
@end
