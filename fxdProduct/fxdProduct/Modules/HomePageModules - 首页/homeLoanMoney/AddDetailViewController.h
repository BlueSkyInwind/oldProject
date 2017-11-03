//
//  AddDetailViewController.h
//  fxdProduct
//
//  Created by zhangbaochuan on 15/12/9.
//  Copyright © 2015年 dd. All rights reserved.
//

#import "BaseViewController.h"

@protocol AddDeetailDelegate <NSObject>

-(void)setMultible:(NSString *)string1 andshi:(NSString *)string2 andQu:(NSString *)string3;

@end

@interface AddDetailViewController : BaseViewController

@property(weak, nonatomic) id<AddDeetailDelegate>delegate;

@end
