//
//  CheckSuccessView.h
//  fxdProduct
//
//  Created by zhangbaochuan on 16/1/27.
//  Copyright © 2016年 dd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYText.h"

@interface CheckSuccessView : UIView

- (id)initWithFrame:(CGRect)frame;

@property (weak, nonatomic) IBOutlet UITextField *textFiledWeek;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@property (weak, nonatomic) IBOutlet UIButton *promote;

@property (weak, nonatomic) IBOutlet UIButton *weekBtn;
@property (weak, nonatomic) IBOutlet UIPickerView *pickweek;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *toolCancleBtn;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *toolsureBtn;
@property (weak, nonatomic) IBOutlet UILabel *loadMoney;
@property (weak, nonatomic) IBOutlet UIView *bankView;
@property (weak, nonatomic) IBOutlet UITextField *bankTextField;
@property (weak, nonatomic) IBOutlet UIButton *bankButton;

@property (weak, nonatomic) IBOutlet UIView *displayMoneyView;

@property (weak, nonatomic) IBOutlet UIPickerView *purposePicker;

@property (weak, nonatomic) IBOutlet UILabel *weekMoney;
@property (weak, nonatomic) IBOutlet UILabel *allMoney;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIView *purposeView;
@property (weak, nonatomic) IBOutlet UIButton *purposeBtn;
@property (weak, nonatomic) IBOutlet UITextField *purposeTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UIImageView *agreementImage;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *surBtnLeadRight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *surBtnLeadRightForSuper;

@property (weak, nonatomic) IBOutlet UIImageView *circleFirst;

@property (weak, nonatomic) IBOutlet UILabel *labelFirst;

@property (weak, nonatomic) IBOutlet UIImageView *arrowFirst;

@property (weak, nonatomic) IBOutlet UIImageView *circleSecond;

@property (weak, nonatomic) IBOutlet UILabel *labelSecond;

@property (weak, nonatomic) IBOutlet UIImageView *arrowThird;

@property (weak, nonatomic) IBOutlet UIImageView *circleThird;

@property (weak, nonatomic) IBOutlet UILabel *labelThird;

@property (weak, nonatomic) IBOutlet UIView *bottomBtnView;

@property (nonatomic, strong) YYLabel *moneyLabel;

@property (weak, nonatomic) IBOutlet UIView *userCheckView;

@property (weak, nonatomic) IBOutlet UIButton *userCheckBtn;

@property (nonatomic, strong) YYLabel *agreementLabel;

@property (nonatomic, assign)BOOL userCheckBtnState;
@property (weak, nonatomic) IBOutlet UIButton *firstAgreemwntBtn;
@property (weak, nonatomic) IBOutlet UIButton *secondAgreemwntBtn;

@property (weak, nonatomic) IBOutlet UIView *agreementView;
@property (weak, nonatomic) IBOutlet UILabel *agreementDescLabel;
@property (weak, nonatomic) IBOutlet UIView *agreementsView;

@end
