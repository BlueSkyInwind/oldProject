//
//  FXD_AlertViewCust.m
//  fxdProduct
//
//  Created by dd on 15/11/6.
//  Copyright © 2015年 dd. All rights reserved.
//

#import "FXD_AlertViewCust.h"

@interface FXD_AlertViewCust (){
    
}
@property (nonatomic,strong) FXD_VersionUpdatepop * versionUpdate;
@property (nonatomic,strong) FXDAlertView * fxdAlertView;

@end

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


-(void)showAppVersionUpdate:(NSString *)content isForce:(BOOL)isForce compleBlock:(ClickBlock)clickIndexBlock{
    if (self.versionUpdate) {
        return;
    }
    self.versionUpdate = [[FXD_VersionUpdatepop alloc] initWithContent:content isFroce:isForce];
    [self.versionUpdate show];
    __weak typeof (self) weakSelf = self;
    self.versionUpdate.updateClick = ^(NSInteger index) {
        clickIndexBlock(index);
        [weakSelf.versionUpdate dismiss];
       weakSelf.versionUpdate = nil;
    };
}

-(void)showFXDAlertViewTitle:(NSString *)title
                     content:(NSString *)contentAttri
                attributeDic:(NSDictionary<NSAttributedStringKey,id> *)attributeDic
                     cancelTitle:(NSString *)cancelTitle
                     sureTitle:(NSString *)sureTitle
                 compleBlock:(ClickBlock)clickIndexBlock{
    
    if (self.fxdAlertView) {
        return;
    }
    if (attributeDic == nil) {
        attributeDic =@{NSFontAttributeName:[UIFont yx_systemFontOfSize:14],NSForegroundColorAttributeName:kUIColorFromRGB(0x808080)};
    }
    self.fxdAlertView = [[FXDAlertView alloc]init:title content:contentAttri attributes:attributeDic cancelTitle:cancelTitle sureTitle:sureTitle];
    [self.fxdAlertView show];
    __weak typeof (self) weakSelf = self;
    self.fxdAlertView.clickButtonIndex = ^(NSInteger index) {
        clickIndexBlock(index);
        [weakSelf.fxdAlertView dismiss];
        weakSelf.fxdAlertView = nil;
    };
//    CGSize attSize = [attriStr boundingRectWithSize:CGSizeMake(220, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
//    CGSize attSize2 = [alertContent boundingRectWithSize:CGSizeMake(220, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:nil context:nil].size;
}

-(void)showIdentiFXDAlertViewTitle:(NSString *)title
                     content:(NSString *)content
                 cancelTitle:(NSString *)cancelTitle
                   sureTitle:(NSString *)sureTitle
                 compleBlock:(ClickBlock)clickIndexBlock{
    
    NSRange range = [content rangeOfString:@"\n" options:NSBackwardsSearch];
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineSpacing = 8;
    NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:content];
    [attriStr addAttribute:NSParagraphStyleAttributeName value:paraStyle range:NSMakeRange(0,range.location)];
    [attriStr addAttribute:NSFontAttributeName value:[UIFont yx_systemFontOfSize:14] range:NSMakeRange(0,range.location)];
    [attriStr addAttribute:NSForegroundColorAttributeName value:kUIColorFromRGB(0x808080) range:NSMakeRange(0,range.location)];
    [attriStr addAttribute:NSForegroundColorAttributeName value:kUIColorFromRGB(0xfc8282) range:NSMakeRange(range.location,attriStr.length-range.location)];
    [attriStr addAttribute:NSFontAttributeName value:[UIFont yx_systemFontOfSize:12] range:NSMakeRange(range.location,attriStr.length-range.location)];
   __block FXDAlertView  * idenAlertView = [[FXDAlertView alloc]init:title contentAttri:attriStr cancelTitle:cancelTitle sureTitle:sureTitle];
    [idenAlertView show];
    idenAlertView.clickButtonIndex = ^(NSInteger index) {
        clickIndexBlock(index);
        [idenAlertView dismiss];
        idenAlertView = nil;
    };
}









@end
