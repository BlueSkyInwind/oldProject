//
//  SubmitImageCell.h
//  fxdProduct
//
//  Created by zhangbaochuan on 15/12/15.
//  Copyright © 2015年 dd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubmitImageCell : UIView
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIView *alertView;

-(void)show;

-(void)hide;

@end
