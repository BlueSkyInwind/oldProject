//
//  PayPasswordInputView.h
//  fxdProduct
//
//  Created by admin on 2017/11/21.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,InputType) {
    BoxTypeInput = 1001,
    UnderlineTypeInput,
};

@interface PayPasswordInputView : UIView{
    NSMutableArray * dataArr;
    
}

@property (nonatomic,assign) BOOL isEnsconce;
@property (nonatomic,assign) InputType inputType;
@property (nonatomic,copy) void (^completeHandle)(NSString *inputPwd);
@property(nonatomic,strong)UITextField * pwdTextField;

+(id)initFrame:(CGRect)frame InputTypw:(InputType)type;
/**
 清理数据
 */
-(void)cleanUpTheData;

@end



