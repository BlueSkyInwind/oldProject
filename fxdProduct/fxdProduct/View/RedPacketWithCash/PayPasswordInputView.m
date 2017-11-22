//
//  PayPasswordInputView.m
//  fxdProduct
//
//  Created by admin on 2017/11/21.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "PayPasswordInputView.h"
#define PWD_COUNT 6
#define DOT_WIDTH 10


@interface PayPasswordInputView ()<UITextFieldDelegate>

@property(nonatomic,strong)UITextField * pwdTextField;

@end

@implementation PayPasswordInputView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self configureView];
    }
    return self;
}

-(void)configureView{
    
    dataArr = [[NSMutableArray alloc]init];
    _pwdTextField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _pwdTextField.alpha = 0;
    _pwdTextField.delegate = self;
    _pwdTextField.keyboardType = UIKeyboardTypeNumberPad;
    _pwdTextField.becomeFirstResponder;
    [self addSubview:_pwdTextField];
    
    CGFloat width = self.bounds.size.width/PWD_COUNT;
    for (int i = 0; i < PWD_COUNT; i ++) {
        UILabel *dot = [[UILabel alloc]initWithFrame:CGRectMake((width-DOT_WIDTH)/2.f + i*width, (self.bounds.size.height-DOT_WIDTH)/2.f, DOT_WIDTH, DOT_WIDTH)];
        dot.tag =  900 + i;
        if (_isEnsconce) {
            dot.backgroundColor = [UIColor blackColor];
            dot.layer.cornerRadius = DOT_WIDTH/2.;
            dot.clipsToBounds = YES;
        }else{
            dot.frame = CGRectMake(i*width + 2, 2, self.bounds.size.height - 4, self.bounds.size.height - 4);
            dot.textAlignment = NSTextAlignmentCenter;
            dot.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1];
            dot.textColor = UI_MAIN_COLOR
        }
        dot.hidden = true;
        [self addSubview:dot];
        [dataArr addObject:dot];

        UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(i*width, self.bounds.size.height - 2, width - 2, 2.0f)];
        line.backgroundColor = [UIColor blackColor];
        [self addSubview:line];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField.text.length >= PWD_COUNT && string.length) {
        //输入的字符个数大于6，则无法继续输入，返回NO表示禁止输入
        return NO;
    }
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^[0-9]*$"];
    if (![predicate evaluateWithObject:string]) {
        return NO;
    }
    NSString *totalString;
    if (string.length <= 0) {
        totalString = [textField.text substringToIndex:textField.text.length-1];
    }
    else {
        totalString = [NSString stringWithFormat:@"%@%@",textField.text,string];
    }
    [self setDotWithCount:totalString.length charStr:string];
    
    if (totalString.length == 6) {
        if (_completeHandle) {
            _completeHandle(totalString);
            [textField endEditing:true];
        }
    }
    return YES;
}

- (void)setDotWithCount:(NSInteger)count charStr:(NSString *)charStr{

    for (int i = 0; i< count; i++) {
        UILabel * dotLabel = (UILabel*)[dataArr objectAtIndex:i];
        if (dotLabel.tag  == (count-1) + 900) {
            dotLabel.hidden = NO;
            //显示的时候，赋值
            if (_isEnsconce) {
                dotLabel.text = charStr;
            }
        }
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
