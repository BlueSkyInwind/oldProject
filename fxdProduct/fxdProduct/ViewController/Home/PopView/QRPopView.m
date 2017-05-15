//
//  QRPopView.m
//  fxdProduct
//
//  Created by dd on 2017/2/7.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "QRPopView.h"
#import "LewPopupViewAnimationSpring.h"
#import "UIViewController+LewPopupViewController.h"

@implementation QRPopView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:[[self class] description] owner:self options:nil].lastObject;
        [Tool setCorner:self.wxCopyBtn borderColor:[UIColor clearColor]];
        [Tool setCorner:self.saveImageBtn borderColor:[UIColor clearColor]];
        NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:@"公众号:急速发薪"];
        [attriStr addAttribute:NSForegroundColorAttributeName value:rgb(53, 166, 255) range:NSMakeRange(attriStr.length-4,4)];
        _publicWXLabel.attributedText = attriStr;
    }
    return self;
}

- (IBAction)closeClick:(UIButton *)sender {
    [_parentVC lew_dismissPopupViewWithanimation:[LewPopupViewAnimationSpring new]];
}

- (IBAction)wxCopyClick:(UIButton *)sender {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = @"急速发薪";
    [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:@"复制微信公众号成功，请在微信中搜索关注"];
}

- (IBAction)saveImageClick:(UIButton *)sender {
    [self loadImageFinished:[UIImage imageNamed:@"icon_qr_wxQR_icon"]];
}

- (void)loadImageFinished:(UIImage *)image
{
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    
    DLog(@"image = %@, error = %@, contextInfo = %@", image, error, contextInfo);
    if (!error) {
        [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:@"保存成功"];
    }else {
        [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:@"请开启相册访问权限"];
    }
}

+ (instancetype)defaultQRPopView
{
    if (UI_IS_IPHONE6P) {
        return [[QRPopView alloc]initWithFrame:CGRectMake(0, 0, 300, 450)];
    } else {
        return [[QRPopView alloc]initWithFrame:CGRectMake(0, 0, 300, 400)];
    }
    
}

@end
