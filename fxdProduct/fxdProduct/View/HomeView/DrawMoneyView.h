//
//  DrawMoneyView.h
//  fxdProduct
//
//  Created by zy on 15/12/9.
//  Copyright © 2015年 dd. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DrawMoneyMakeSureDelegate <NSObject>

-(void)DrawMoneyDelegatebutton;

@end
@interface DrawMoneyView : UIView{
    DrawMoneyView *_DrawMoneyView;
}
@property (weak, nonatomic) IBOutlet UIImageView *homeImageView;
@property (weak, nonatomic) IBOutlet UIView *alertView;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *lblMoney;
@property (weak, nonatomic) IBOutlet UILabel *lblTimes;
@property (weak, nonatomic) IBOutlet UILabel *lblRepayWeekly;
@property (weak, nonatomic) IBOutlet UILabel *lblTotalMeney;
@property (weak, nonatomic) IBOutlet UILabel *lblCardNum;
@property (nonatomic,strong) id<DrawMoneyMakeSureDelegate> delegate;
-(void)show;
- (void)hide;
@end
