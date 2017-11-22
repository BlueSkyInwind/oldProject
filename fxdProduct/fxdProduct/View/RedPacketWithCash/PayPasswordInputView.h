//
//  PayPasswordInputView.h
//  fxdProduct
//
//  Created by admin on 2017/11/21.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PayPasswordInputView : UIView{
    
    NSMutableArray * dataArr;
    
    
}

@property (nonatomic,assign) BOOL isEnsconce;

@property (nonatomic,copy) void (^completeHandle)(NSString *inputPwd);


@end



