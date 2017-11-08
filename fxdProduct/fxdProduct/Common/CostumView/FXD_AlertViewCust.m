//
//  FXD_AlertViewCust.m
//  fxdProduct
//
//  Created by dd on 15/11/6.
//  Copyright © 2015年 dd. All rights reserved.
//

#import "FXD_AlertViewCust.h"

@implementation FXD_AlertViewCust

+ (FXD_AlertViewCust *)sharedHHAlertView
{
    static FXD_AlertViewCust *sharedHHAlertInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedHHAlertInstance = [[self alloc] init];
    });
    return sharedHHAlertInstance;
}

- (void)showHHalertView:(HHAlertEnterMode)Entermode leaveMode:(HHAlertLeaveMode)leaveMode disPlayMode:(HHAlertViewMode)mode title:(NSString *)titleStr detail:(NSString *)detailStr cencelBtn:(NSString *)cancelStr otherBtn:(NSArray *)otherBtnArr Onview:(UIView *) view
{
    if (alertview) {
        return;
    }
    alertview = [[HHAlertView alloc] initWithTitle:titleStr detailText:detailStr cancelButtonTitle:cancelStr otherButtonTitles:otherBtnArr];
    alertview.mode = mode;
    [alertview setEnterMode:Entermode];
    [alertview setLeaveMode:leaveMode];
    [view addSubview:alertview];
    [alertview show];
}

- (void)showHHalertView:(HHAlertEnterMode)Entermode leaveMode:(HHAlertLeaveMode)leaveMode disPlayMode:(HHAlertViewMode)mode title:(NSString *)titleStr detail:(NSString *)detailStr cencelBtn:(NSString *)cancelStr otherBtn:(NSArray *)otherBtnArr Onview:(UIView *) view compleBlock:(ClickBlock)clickIndexBlock
{
    if (alertview) {
        return;
    }
    alertview = [[HHAlertView alloc] initWithTitle:titleStr detailText:detailStr cancelButtonTitle:cancelStr otherButtonTitles:otherBtnArr];
    alertview.mode = mode;
    [alertview setEnterMode:Entermode];
    [alertview setLeaveMode:leaveMode];
    [view addSubview:alertview];
    __weak typeof (self) weakSelf = self;
    [alertview showWithBlock:^(NSInteger index) {
        clickIndexBlock(index);
        [weakSelf removeAlertView];
    }];
}

-(void)removeAlertView{
    
    [alertview removeFromSuperViewOnHide];
    alertview = nil;
}

-(void)showAppVersionUpdate:(NSString *)content isForce:(BOOL)isForce compleBlock:(ClickBlock)clickIndexBlock{
    __block FXD_VersionUpdatepop * versionUpdate = [[FXD_VersionUpdatepop alloc] initWithContent:@"1、4.0.6版本界面大改版，流程优化； 2、全新的首页界面，更加清晰的展示当前状态；3、新增产品 ：30天急速贷；" isFroce:isForce];
    [versionUpdate show];
    versionUpdate.updateClick = ^(NSInteger index) {
        clickIndexBlock(index);
        [versionUpdate dismiss];
        versionUpdate = nil;
    };
}






@end
