//
//  LunchViewController.h
//  Lunch
//
//  Created by dd on 16/3/15.
//  Copyright © 2016年 dd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LunchVCModules : UIViewController

+ (instancetype)newLunchVCWithModels:(NSArray *)models enterBlock:(void(^)())enterBlock;

+ (BOOL)canShowNewFeature;

@end
