//
//  P2PViewController.h
//  fxdProduct
//
//  Created by dd on 2016/9/27.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "BaseViewController.h"

@interface P2PViewController : BaseViewController

@property (nonatomic, copy) NSString *urlStr;

@property (nonatomic, assign) NSNumber *userSelectNum;

@property (nonatomic, strong) NSDictionary * uploadP2PUserInfo;

@property (nonatomic, assign) NSString *purposeSelect;

@end
