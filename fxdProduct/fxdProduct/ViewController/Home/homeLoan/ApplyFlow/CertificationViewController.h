//
//  CertificationViewController.h
//  fxdProduct
//
//  Created by dd on 2017/2/22.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "BaseViewController.h"

@interface CertificationViewController : BaseViewController

@property (nonatomic, assign) BOOL showAll;

@property (nonatomic, assign) NSString  * resultCode;

@property (nonatomic, assign) BOOL liveEnabel;

@property (nonatomic, copy) NSString *isMobileAuth;

@property (nonatomic, copy) NSString *verifyStatus;

@property (nonatomic, copy) NSString *phoneAuthChannel;

@end
