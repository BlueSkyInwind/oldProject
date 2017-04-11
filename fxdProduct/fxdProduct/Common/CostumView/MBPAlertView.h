//
//  MBPAlertView.h
//  fxdProduct
//
//  Created by dd on 15/11/9.
//  Copyright © 2015年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBPAlertView : NSObject

+ (MBPAlertView *)sharedMBPTextView;

//- (void)presentViewController:(UIViewController *)viewControllerToPresent animated: (BOOL)flag completion:(void (^ __nullable)(void))completion

- (void) showTextOnly:(UIView *)view message: (NSString *)message;


@end
