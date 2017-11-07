//
//  CheckSuccessView.h
//  fxdProduct
//
//  Created by zhangbaochuan on 16/1/27.
//  Copyright © 2016年 dd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYText.h"

typedef void(^AgreementClickStatus)(UIButton * button);

@interface CheckSuccessView : UIView

- (id)initWithFrame:(CGRect)frame;

//借款周期textfield
@property (weak, nonatomic) IBOutlet UITextField *textFiledWeek;
//提款按钮
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
//提额按钮
@property (weak, nonatomic) IBOutlet UIButton *promote;
//借款周期右边按钮
@property (weak, nonatomic) IBOutlet UIButton *weekBtn;
//借款周期选择弹窗
@property (weak, nonatomic) IBOutlet UIPickerView *pickweek;
//弹窗顶部视图
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;
//弹窗取消按钮
@property (weak, nonatomic) IBOutlet UIBarButtonItem *toolCancleBtn;
//弹窗确认按钮
@property (weak, nonatomic) IBOutlet UIBarButtonItem *toolsureBtn;
//进件状态文字描述
@property (weak, nonatomic) IBOutlet UILabel *loadMoney;
//收款方式View
@property (weak, nonatomic) IBOutlet UIView *bankView;
//收款方式textfield
@property (weak, nonatomic) IBOutlet UITextField *bankTextField;
//收款方式右边btn
@property (weak, nonatomic) IBOutlet UIButton *bankButton;
@property (weak, nonatomic) IBOutlet UIButton *feeBtn;
//进件详细描述
@property (weak, nonatomic) IBOutlet UILabel *displayLabel;
//借款用途选择弹窗
@property (weak, nonatomic) IBOutlet UIPickerView *purposePicker;
//实际到账描述
@property (weak, nonatomic) IBOutlet UILabel *weekMoney;
@property (weak, nonatomic) IBOutlet UILabel *allMoney;
//借款周期View
@property (weak, nonatomic) IBOutlet UIView *bgView;
//借款用途View
@property (weak, nonatomic) IBOutlet UIView *purposeView;
//借款用途右边按钮
@property (weak, nonatomic) IBOutlet UIButton *purposeBtn;
//借款用途textField
@property (weak, nonatomic) IBOutlet UITextField *purposeTextField;
//底部文字提示
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
//协议展开、收起的图表
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
//底部按钮View
@property (weak, nonatomic) IBOutlet UIView *bottomBtnView;

@property (nonatomic, strong) YYLabel *moneyLabel;
//协议整体View
@property (weak, nonatomic) IBOutlet UIView *userCheckView;
//协议勾选框
@property (weak, nonatomic) IBOutlet UIButton *userCheckBtn;

@property (nonatomic, strong) YYLabel *agreementLabel;

@property (nonatomic, assign)BOOL userCheckBtnState;
//下方第一个协议btn
@property (weak, nonatomic) IBOutlet UIButton *firstAgreemwntBtn;
//下方第二个协议btn
@property (weak, nonatomic) IBOutlet UIButton *secondAgreemwntBtn;
//协议View
@property (weak, nonatomic) IBOutlet UIView *agreementView;
//协议展开、收起的文字描述
@property (weak, nonatomic) IBOutlet UILabel *agreementDescLabel;
//下方协议View
@property (weak, nonatomic) IBOutlet UIView *agreementsView;
//急速贷描述View
@property (weak, nonatomic) IBOutlet UIView *jsdDescView;
//急速贷借款期限label
@property (weak, nonatomic) IBOutlet UILabel *termLabel;
//急速贷到期还款label
@property (weak, nonatomic) IBOutlet UILabel *jsdMonayLabel;

@property (copy,nonatomic)AgreementClickStatus agreementStatus;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *displayLabelLeftCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerViewHeader;

@end
