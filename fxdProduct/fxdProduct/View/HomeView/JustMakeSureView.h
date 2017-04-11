//
//  JustMakeSureView.h
//  fxdProduct
//
//  Created by zy on 15/12/7.
//  Copyright © 2015年 dd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JustMakeSureBtnDelegate <NSObject>

-(void)JustMakeSureBtn:(NSInteger)tag;

@end
@interface JustMakeSureView : UIView
{
    JustMakeSureView *_JustMakeSureView;
}
@property (weak, nonatomic) IBOutlet UIImageView *homeImageView;
@property (weak, nonatomic) IBOutlet UILabel *lbltitle;
@property (weak, nonatomic) IBOutlet UIView *alertView;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (nonatomic,strong) id<JustMakeSureBtnDelegate> delegate;
-(void)show;
-(void)showfist;
- (void)hide;
@property(assign,nonatomic)NSInteger num;
@end
