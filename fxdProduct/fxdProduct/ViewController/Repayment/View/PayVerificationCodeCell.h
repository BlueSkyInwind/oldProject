//
//  PayVerificationCodeCell.h
//  fxdProduct
//
//  Created by admin on 2017/7/19.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^UserVerfiyCode)(NSString * str,NSString * seqStr);

@interface PayVerificationCodeCell : UITableViewCell<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *verfiyCodeTextField;
@property (weak, nonatomic) IBOutlet UIButton *sendVerfiyCodeBtn;

@property (strong, nonatomic)NSString * cardNum;
@property (strong, nonatomic)NSString * phoneNum;
@property (copy, nonatomic)UserVerfiyCode  userVerfiyCode;


@end
