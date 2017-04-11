//
//  FirstRepayment.h
//  fxdProduct
//
//  Created by zy on 16/3/9.
//  Copyright © 2016年 dd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstRepayment : UIView
@property (weak, nonatomic) IBOutlet UIImageView *homeImageView;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIView *alertView;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet UILabel *lbltitle;

-(void)show;
-(void)showfist;
- (void)hide;
@end
