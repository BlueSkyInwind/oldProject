//
//  EnterAgainController.h
//  fxdProduct
//
//  Created by zy on 16/5/12.
//  Copyright © 2016年 dd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "UserCardResult.h"

@interface EnterAgainController : BaseViewController
@property (nonatomic,strong) NSString *UserRealName;
@property (nonatomic,strong) NSString *CurrentCard;
@property (nonatomic,strong) UIImageView *BankImg;
@property (nonatomic,strong) NSString *BankName;

@property (nonatomic,strong) NSString *periods_;
@property (nonatomic,strong) NSString *drawing_amount_;
@property (nonatomic, strong) UserCardResult *userCardModel;
@end
