//
//  ScratchAwardView.h
//  fxdProduct
//
//  Created by sxp on 2017/11/8.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScratchAwardView : UIView

@property (nonatomic,copy)NSString *linkUrl;

+ (instancetype)defaultPopView;
-(void)loadData;
@end
