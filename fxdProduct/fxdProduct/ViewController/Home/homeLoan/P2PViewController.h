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

@property (nonatomic, assign) NSString *purposeSelect;

@property (nonatomic,assign)NSMutableArray *dataArray;

@property (nonatomic,copy)NSString *bankCodeNUm;
@property (nonatomic,copy)NSString *product_id;
@property (nonatomic,copy)NSString *drawAmount;
@property (nonatomic,assign)NSInteger periodSelect;

@property (nonatomic,assign)BOOL isCheck;
@property (nonatomic,assign)BOOL isOpenAccount;
@property (nonatomic,assign)BOOL isRepay;
@property (nonatomic, assign) NSString *applicationId;

@end
