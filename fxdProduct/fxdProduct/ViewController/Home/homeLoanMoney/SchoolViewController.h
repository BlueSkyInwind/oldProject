//
//  SchoolViewController.h
//  fxdProduct
//
//  Created by dd on 15/12/15.
//  Copyright © 2015年 dd. All rights reserved.
//

#import "BaseViewController.h"
@protocol SchoolSelectDelegate <NSObject>

- (void)setSelectSchool:(NSString *)school;

@end

@interface SchoolViewController : BaseViewController

@property (nonatomic,weak) id <SchoolSelectDelegate>delegate;

@end
