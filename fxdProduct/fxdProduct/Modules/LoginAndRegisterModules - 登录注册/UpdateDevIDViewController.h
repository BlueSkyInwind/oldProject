//
//  UpdateDevIDViewController.h
//  fxdProduct
//
//  Created by dd on 15/10/13.
//  Copyright © 2015年 dd. All rights reserved.
//
@protocol DismissDelegate <NSObject>

-(void)disspassWordView;

@end
#import "BaseIndexViewController.h"

typedef enum {
    ///push
    Push_Dis = 0,
    ///present
    Present_Dis
} DisplayWay;

@interface UpdateDevIDViewController : BaseViewController

@property (strong, nonatomic) IBOutlet UITextField *phoneNumText;

@property (strong, nonatomic) IBOutlet UITextField *verCodeText;

@property (strong, nonatomic) IBOutlet UIButton *sendCodeButton;

@property (weak, nonatomic) IBOutlet UIButton *updateBtn;
@property (strong, nonatomic) NSString *phoneStr;

@property (strong, nonatomic) NSString *passStr;

@property (assign ,nonatomic) DisplayWay state;

@property (strong,nonatomic)  NSString *pushWayFlag;

@property (strong,nonatomic)  id<DismissDelegate> delegate;

@end
