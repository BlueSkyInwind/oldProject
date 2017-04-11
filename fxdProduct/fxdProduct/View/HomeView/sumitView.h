//
//  sumitView.h
//  fxdProduct
//
//  Created by zhangbaochuan on 15/10/28.
//  Copyright © 2015年 dd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SubmitMakeSureDelegate <NSObject>

-(void)SubmitMakeSureDelegatebutton;

@end

@interface sumitView : UIView
{
    
}
@property (weak, nonatomic) IBOutlet UIView *bigBgView;
@property (weak, nonatomic) IBOutlet UIView *smallBgView;

@property (weak, nonatomic) IBOutlet UIButton *dissureBtn;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

//请确认您的信息真实有效
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

//更多还回内容
@property (weak, nonatomic) IBOutlet UILabel *loanNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *loanDataLabel;
@property (weak, nonatomic) IBOutlet UILabel *loanCostMoneylabel;
@property (weak, nonatomic) IBOutlet UILabel *loanNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *loanIDcardLabel;
@property (weak, nonatomic) IBOutlet UILabel *loanbankCardLabel;
@property (weak, nonatomic) IBOutlet UILabel *loanbankCardNumLable;

@property (weak, nonatomic) IBOutlet UILabel *loanselfbankLabel;
@property (weak, nonatomic) IBOutlet UILabel *loanselfbankNumLabel;

@property (weak, nonatomic) IBOutlet UILabel *loantelSecoryLabel;

@property(weak,nonatomic)id <SubmitMakeSureDelegate>delegate;

-(void)showww;
- (void)hide;

@end
