//
//  QRPopView.h
//  fxdProduct
//
//  Created by dd on 2017/2/7.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QRCodePopView : UIView

@property (nonatomic, weak) UIViewController *parentVC;

@property (weak, nonatomic) IBOutlet UIButton *closeBtn;

@property (weak, nonatomic) IBOutlet UIButton *wxCopyBtn;

@property (weak, nonatomic) IBOutlet UIButton *saveImageBtn;

@property (weak, nonatomic) IBOutlet UILabel *publicWXLabel;

+ (instancetype)defaultQRPopView;

@end
