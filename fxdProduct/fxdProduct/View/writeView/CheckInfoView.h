//
//  CheckInfoView.h
//  fxdProduct
//
//  Created by zhangbaochuan on 16/3/7.
//  Copyright © 2016年 dd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CheckInfoView : UIView


@property (weak, nonatomic) IBOutlet UIImageView *homeImageView;
@property (weak, nonatomic) IBOutlet UILabel *lbltitle;
@property (weak, nonatomic) IBOutlet UIView *alertView;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

-(void)show;
-(void)showfist;
- (void)hide;

@end
