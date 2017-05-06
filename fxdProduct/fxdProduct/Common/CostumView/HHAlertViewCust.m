//
//  HHAlertViewCust.m
//  fxdProduct
//
//  Created by dd on 15/11/6.
//  Copyright © 2015年 dd. All rights reserved.
//

#import "HHAlertViewCust.h"

@implementation HHAlertViewCust

+ (HHAlertViewCust *)sharedHHAlertView
{
    static HHAlertViewCust *sharedHHAlertInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedHHAlertInstance = [[self alloc] init];
    });
    return sharedHHAlertInstance;
}


- (void)showHHalertView:(HHAlertEnterMode)Entermode leaveMode:(HHAlertLeaveMode)leaveMode disPlayMode:(HHAlertViewMode)mode title:(NSString *)titleStr detail:(NSString *)detailStr cencelBtn:(NSString *)cancelStr otherBtn:(NSArray *)otherBtnArr Onview:(UIView *) view
{
    HHAlertView *alertview = [[HHAlertView alloc] initWithTitle:titleStr detailText:detailStr cancelButtonTitle:cancelStr otherButtonTitles:otherBtnArr];
    alertview.mode = mode;
    [alertview setEnterMode:Entermode];
    [alertview setLeaveMode:leaveMode];
    [view addSubview:alertview];
    [alertview show];
}

- (void)showHHalertView:(HHAlertEnterMode)Entermode leaveMode:(HHAlertLeaveMode)leaveMode disPlayMode:(HHAlertViewMode)mode title:(NSString *)titleStr detail:(NSString *)detailStr cencelBtn:(NSString *)cancelStr otherBtn:(NSArray *)otherBtnArr Onview:(UIView *) view compleBlock:(ClickBlock)clickIndexBlock
{
    HHAlertView *alertview = [[HHAlertView alloc] initWithTitle:titleStr detailText:detailStr cancelButtonTitle:cancelStr otherButtonTitles:otherBtnArr];
    alertview.mode = mode;
    [alertview setEnterMode:Entermode];
    [alertview setLeaveMode:leaveMode];
    [view addSubview:alertview];
    [alertview showWithBlock:^(NSInteger index) {
        clickIndexBlock(index);
    }];
}

@end
