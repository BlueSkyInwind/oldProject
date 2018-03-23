//
//  FXD_AlertViewCust.m
//  fxdProduct
//
//  Created by dd on 15/11/6.
//  Copyright © 2015年 dd. All rights reserved.
//

#import "FXD_AlertViewCust.h"
#import "LewPopupViewController.h"

@interface FXD_AlertViewCust (){
    
}

@property (nonatomic,strong) FXD_VersionUpdatepop * versionUpdate;
@property (nonatomic,strong) FXDAlertView * fxdAlertView;
@property (nonatomic,strong) ActivityHomePopView * popView;

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

-(void)popOverCenter:(PopViewType)type info:(id)info{
    
    id result = info;
    PopViewType popType = type;
    
//    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:info,[NSNumber numberWithInteger:type], nil];
//    [[FXD_Utility sharedUtility].popArray addObject:dic];
//    NSDictionary * resultDic = [FXD_Utility sharedUtility].popArray.firstObject;
//    NSNumber * index = resultDic.allKeys.firstObject;
//    popType = index.integerValue;
//    result = [resultDic objectForKey:index];
    
    if ([FXD_Utility sharedUtility].userInfo.isUpdate) {
        if (self.fxdAlertView != nil) {
            [self.fxdAlertView dismiss];
            self.fxdAlertView = nil;
        }
        if (self.popView != nil) {
//            [self.popView lew_dismissPopupViewWithanimation:[LewPopupViewAnimationSpring new]];
            self.popView = nil;
        }

    }
        
    switch (popType) {
        case VersionUpdate:{
            NSString * msg = result;
            [self showAppVersionUpdate:msg isForce:[FXD_Utility sharedUtility].userInfo.isUpdate compleBlock:^(NSInteger index) {
                if (index == 1) {
                    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/id1089086853"]];
                }
            }];
        }
            break;
        case Activities:{
            
        }
            break;

        default:
            break;
    }
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

-(void)homeActivityPopLoadImageUrl:(NSString *)urlStr ParentVC:(UIViewController*)vc  compleBlock:(ClickBlock)clickIndexBlock{
    if (self.popView) {
        return;
    }
    self.popView = [ActivityHomePopView defaultPopupView];
    self.popView.closeBtn.hidden = YES;
    [self.popView.imageView sd_setImageWithURL:[NSURL URLWithString:urlStr]];
    self.popView.parentVC = vc;
    __weak typeof (self) weakSelf = self;
    self.popView.activityTap = ^(NSInteger index) {
        clickIndexBlock(index);
        [vc lew_dismissPopupViewWithanimation:[LewPopupViewAnimationSpring new]];
        weakSelf.popView = nil;
    };
    [vc lew_presentPopupView:_popView animation:[LewPopupViewAnimationSpring new] backgroundClickable:NO dismissed:^{
    }];
    [self performSelector:@selector(homeActivitiesPopupsClose) withObject:self afterDelay:2];
}
/**
 首页活动弹窗关闭
 */
- (void)homeActivitiesPopupsClose
{
    self.popView.closeBtn.hidden = false;
}

-(void)showFXDAlertViewTitle:(NSString *)title
                     content:(NSString *)content
                 cancelTitle:(NSString *)cancelTitle
                   sureTitle:(NSString *)sureTitle
                 compleBlock:(ClickBlock)clickIndexBlock{
    
    if (self.fxdAlertView) {
        return;
    }

    self.fxdAlertView = [[FXDAlertView alloc]init:title content:content cancelTitle:cancelTitle sureTitle:sureTitle];
    [self.fxdAlertView show];
    __weak typeof (self) weakSelf = self;
    self.fxdAlertView.clickButtonIndex = ^(NSInteger index) {
        clickIndexBlock(index);
        [weakSelf.fxdAlertView dismiss];
        weakSelf.fxdAlertView = nil;
    };
}

-(void)showFXDAlertViewTitle:(NSString *)title
                     content:(NSString *)contentAttri
                attributeDic:(NSDictionary<NSAttributedStringKey,id> *)attributeDic
               TextAlignment:(NSTextAlignment)textAlignment
                     cancelTitle:(NSString *)cancelTitle
                     sureTitle:(NSString *)sureTitle
                 compleBlock:(ClickBlock)clickIndexBlock{
    
    if (self.fxdAlertView) {
        return;
    }
    if (attributeDic == nil) {
        NSMutableParagraphStyle *ornamentParagraph = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        //设置text文字垂直居中
        ornamentParagraph.alignment = textAlignment;
        attributeDic =@{NSFontAttributeName:[UIFont yx_systemFontOfSize:13],NSForegroundColorAttributeName:kUIColorFromRGB(0x808080),NSParagraphStyleAttributeName:ornamentParagraph};
    }
    self.fxdAlertView = [[FXDAlertView alloc]init:title content:contentAttri attributes:attributeDic cancelTitle:cancelTitle sureTitle:sureTitle];
    [self.fxdAlertView show];
    __weak typeof (self) weakSelf = self;
    self.fxdAlertView.clickButtonIndex = ^(NSInteger index) {
        clickIndexBlock(index);
        [weakSelf.fxdAlertView dismiss];
        weakSelf.fxdAlertView = nil;
    };
}

-(void)dismissFXDAlertView{
    [self.fxdAlertView dismiss];
    self.fxdAlertView = nil;
}



-(void)showIdentiFXDAlertViewTitle:(NSString *)title
                     content:(NSString *)content
                 cancelTitle:(NSString *)cancelTitle
                   sureTitle:(NSString *)sureTitle
                 compleBlock:(ClickBlock)clickIndexBlock{
    
    NSRange range = [content rangeOfString:@"\n" options:NSBackwardsSearch];
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineSpacing = 8;
    paraStyle.alignment = NSTextAlignmentLeft;
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

-(void)showFXDOverdueViewAlertViewTitle:(NSString *)title
                                  TwoTitle:(NSString *)twotitle
                     content:(NSString *)contentAttri
                deditAmount:(NSString *)deditAmount
                     deditTitle:(NSString *)deditTitle
                 defaultInterestLabel:(NSString *)defaultInterestLabel
                   defaultInterestTitle:(NSString *)defaultInterestTitle
                   sureTitle:(NSString *)sureTitle
                 compleBlock:(ClickBlock)clickIndexBlock{
    
    if (self.fxdAlertView) {
        return;
    }
    NSMutableParagraphStyle *ornamentParagraph = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    NSDictionary * attributeDic =@{NSFontAttributeName:[UIFont yx_systemFontOfSize:14],NSForegroundColorAttributeName:kUIColorFromRGB(0x808080),NSParagraphStyleAttributeName:ornamentParagraph};
    self.fxdAlertView = [[FXDAlertView alloc]init:title titleStrTwo:twotitle content:contentAttri attributes:attributeDic deditTitle:deditTitle deditAmount:deditAmount defaultInterestTitle:defaultInterestTitle defaultInterestLabel:defaultInterestLabel btnTitle:sureTitle];
    [self.fxdAlertView show];
    __weak typeof (self) weakSelf = self;
    self.fxdAlertView.clickButtonIndex = ^(NSInteger index) {
        clickIndexBlock(index);
        [weakSelf.fxdAlertView dismiss];
        weakSelf.fxdAlertView = nil;
    };
}







@end
