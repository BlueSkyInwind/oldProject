//
//  FXD_AlertViewCust.h
//  fxdProduct
//
//  Created by admin on 17/12/24.
//  Copyright © 2015年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ActivityHomePopView.h"

typedef void (^ClickBlock)(NSInteger index);

@interface FXD_AlertViewCust : NSObject{
    
}

+ (FXD_AlertViewCust *)sharedHHAlertView;

-(void)showAppVersionUpdate:(NSString *)content isForce:(BOOL)isForce compleBlock:(ClickBlock)clickIndexBlock;
-(void)homeActivityPopLoadImageUrl:(NSString *)urlStr ParentVC:(UIViewController*)vc  compleBlock:(ClickBlock)clickIndexBlock;

-(void)showFXDAlertViewTitle:(NSString *)title
                     content:(NSString *)content
                 cancelTitle:(NSString *)cancelTitle
                   sureTitle:(NSString *)sureTitle
                 compleBlock:(ClickBlock)clickIndexBlock;
/**
 提示弹窗

 @param title 标题
 @param contentAttri 内容
 @param attributeDic 样式
 @param TextAlignment 文字位置 （可选、样式为空）
 @param cancelTitle 取消按钮
 @param sureTitle 确定按钮
 @param clickIndexBlock 点击事件
 */
-(void)showFXDAlertViewTitle:(NSString *)title
                     content:(NSString *)contentAttri
                attributeDic:(NSDictionary<NSAttributedStringKey,id> *)attributeDic
               TextAlignment:(NSTextAlignment)textAlignment
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


/**
 首页逾期弹窗

 @param title 标题
 @param twotitle 二级标题
 @param contentAttri 内容
 @param deditTitle 逾期
 @param deditAmount 逾期费用
 @param defaultInterestLabel 罚息
 @param defaultInterestTitle 罚息
 @param sureTitle 按钮标题
 @param clickIndexBlock 点击触发
 */
-(void)showFXDOverdueViewAlertViewTitle:(NSString *)title
                               TwoTitle:(NSString *)twotitle
                                content:(NSString *)contentAttri
                            deditAmount:(NSString *)deditAmount
                             deditTitle:(NSString *)deditTitle
                   defaultInterestLabel:(NSString *)defaultInterestLabel
                   defaultInterestTitle:(NSString *)defaultInterestTitle
                              sureTitle:(NSString *)sureTitle
                            compleBlock:(ClickBlock)clickIndexBlock;



@end
