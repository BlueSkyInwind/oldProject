//
//  UserContactsViewController.h
//  fxdProduct
//
//  Created by dd on 2017/2/22.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "BaseViewController.h"
@class Custom_BaseInfo;

@interface UserPhoneContactsVCModules : BaseViewController


@property (weak, nonatomic) IBOutlet UIToolbar *toolbarCancelDone;

@property (nonatomic, strong)Custom_BaseInfo *custom_baseInfo;

@end
