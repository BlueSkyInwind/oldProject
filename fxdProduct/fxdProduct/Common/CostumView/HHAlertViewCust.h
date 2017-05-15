//
//  HHAlertViewCust.h
//  fxdProduct
//
//  Created by dd on 15/11/6.
//  Copyright © 2015年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HHAlertView.h"

typedef void (^ClickBlock)(NSInteger index);

@interface HHAlertViewCust : NSObject{
    
    
    
}

+ (HHAlertViewCust *)sharedHHAlertView;


- (void)showHHalertView:(HHAlertEnterMode)Entermode leaveMode:(HHAlertLeaveMode)leaveMode disPlayMode:(HHAlertViewMode)mode title:(NSString *)titleStr detail:(NSString *)detailStr cencelBtn:(NSString *)cancelStr otherBtn:(NSArray *)otherBtnArr Onview:(UIView *) view;


- (void)showHHalertView:(HHAlertEnterMode)Entermode leaveMode:(HHAlertLeaveMode)leaveMode disPlayMode:(HHAlertViewMode)mode title:(NSString *)titleStr detail:(NSString *)detailStr cencelBtn:(NSString *)cancelStr otherBtn:(NSArray *)otherBtnArr Onview:(UIView *) view compleBlock:(ClickBlock)clickIndexBlock;

@end
