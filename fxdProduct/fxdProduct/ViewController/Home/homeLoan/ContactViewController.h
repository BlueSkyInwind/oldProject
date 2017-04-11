//
//  ContactViewController.h
//  zbczbcDemo
//
//  Created by zhangbaochuan on 16/3/23.
//  Copyright © 2016年 zhangbaochuan. All rights reserved.
//

#import "BaseViewController.h"

@protocol ContactViewControllerDelegate <NSObject>

-(void)GetContactName:(NSString *)name TelPhone:(NSString *)telph andFlagTure:(NSInteger )flagInteger;

@end

@interface ContactViewController : BaseViewController

@property (nonatomic, strong) NSArray *listArray;

@property (nonatomic, weak) id<ContactViewControllerDelegate>delegate;

@property (nonatomic, assign) NSInteger tagFlage;

@property (nonatomic, assign ) BOOL upload;

@end
