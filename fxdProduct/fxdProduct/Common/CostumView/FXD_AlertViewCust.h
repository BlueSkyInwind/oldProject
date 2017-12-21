//
//  FXD_AlertViewCust.h
//  fxdProduct
//
//  Created by dd on 15/11/6.
//  Copyright © 2015年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "HHAlertView.h"

typedef void (^ClickBlock)(NSInteger index);

@interface FXD_AlertViewCust : NSObject{
    HHAlertView *alertview;
}

+ (FXD_AlertViewCust *)sharedHHAlertView;

- (void)showHHalertView:(HHAlertEnterMode)Entermode leaveMode:(HHAlertLeaveMode)leaveMode disPlayMode:(HHAlertViewMode)mode title:(NSString *)titleStr detail:(NSString *)detailStr cencelBtn:(NSString *)cancelStr otherBtn:(NSArray *)otherBtnArr Onview:(UIView *) view;

- (void)showHHalertView:(HHAlertEnterMode)Entermode leaveMode:(HHAlertLeaveMode)leaveMode disPlayMode:(HHAlertViewMode)mode title:(NSString *)titleStr detail:(NSString *)detailStr cencelBtn:(NSString *)cancelStr otherBtn:(NSArray *)otherBtnArr Onview:(UIView *) view compleBlock:(ClickBlock)clickIndexBlock;

-(void)removeAlertView;

-(void)showAppVersionUpdate:(NSString *)content isForce:(BOOL)isForce compleBlock:(ClickBlock)clickIndexBlock;

/**
 提示弹窗

 @param title 标题
 @param contentAttri 内容
 @param attributeDic 样式
 @param cancelTitle 取消按钮
 @param sureTitle 确定按钮
 @param clickIndexBlock 点击事件
 */
-(void)showFXDAlertViewTitle:(NSString *)title
                     content:(NSString *)contentAttri
                attributeDic:(NSDictionary<NSAttributedStringKey,id> *)attributeDic
                 cancelTitle:(NSString *)cancelTitle
                   sureTitle:(NSString *)sureTitle
                 compleBlock:(ClickBlock)clickIndexBlock;


/**
 身份证认证结果提示处理

 @param title 标题
 @param content 内容
 @param cancelTitle 取消按钮
 @param sureTitle 确定按钮
 @param clickIndexBlock 点击事件
 */
-(void)showIdentiFXDAlertViewTitle:(NSString *)title
                     content:(NSString *)content
                 cancelTitle:(NSString *)cancelTitle
                   sureTitle:(NSString *)sureTitle
                 compleBlock:(ClickBlock)clickIndexBlock;

@end
