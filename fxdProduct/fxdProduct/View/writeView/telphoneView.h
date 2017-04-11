//
//  telphoneView.h
//  fxdProduct
//
//  Created by zhangbaochuan on 16/1/25.
//  Copyright © 2016年 dd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface telphoneView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *homeImageView;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIView *alertView;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet UILabel *lbltitle;

-(void)show;
-(void)showfist;
- (void)hide;


@end
