//
//  MobileCell.h
//  fxdProduct
//
//  Created by dd on 2017/2/22.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MobileCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *mobileLabel;

@property (weak, nonatomic) IBOutlet UILabel *operatorLabel;

@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@property (weak, nonatomic) IBOutlet UITextField *veritifyCodeField;

@property (weak, nonatomic) IBOutlet UIView *passView;

@property (weak, nonatomic) IBOutlet UIView *smsCodeView;

@property (weak, nonatomic) IBOutlet UIButton *mobileBtn;

@property (weak, nonatomic) IBOutlet UIButton *mobileHelpBtn;
@property (weak, nonatomic) IBOutlet UIView *AgreementView;
@property (weak, nonatomic) IBOutlet UIImageView *AgreementImage;
@property (weak, nonatomic) IBOutlet UILabel *AgreementLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *agreementTopConstraint;



@end
