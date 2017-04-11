//
//  WriteInfoViewController.h
//  fxdProduct
//
//  Created by zhangbaochuan on 16/1/20.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "BaseViewController.h"

/**
 认证照片标识
 */
typedef enum {
    ///身份证正面
    Card_Font = 0,
    ///身份证反面
    Card_Back = 1,
    ///持证自拍
    Card_Self = 2
} CaydType;

@interface WriteInfoViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;
- (IBAction)segment:(id)sender;

@property (weak, nonatomic) IBOutlet UIToolbar *toolbarCancelDone;

//小额产品 用户请求借款额度
@property (nonatomic, copy) NSString *req_loan_amt;

- (IBAction)cancelAction:(id)sender;
- (IBAction)doneAction:(id)sender;

@end
