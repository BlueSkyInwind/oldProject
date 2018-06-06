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

#define VERIFY_COUNT 4
#define BOX_WIDTH 40

@interface PayPasswordInputView ()<UITextFieldDelegate>

@end

@implementation PayPasswordInputView


+(id)initFrame:(CGRect)frame InputTypw:(InputType)type{
    PayPasswordInputView * inputView = [[PayPasswordInputView alloc]initWithFrame:frame];
    inputView.inputType = type;
    [inputView configureView];
    return inputView;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
//        [self configureView];
    }
    return self;
}

-(void)configureView{
    
    dataArr = [[NSMutableArray alloc]init];
    _pwdTextField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _pwdTextField.alpha = 0;
    _pwdTextField.delegate = self;
    _pwdTextField.keyboardType = UIKeyboardTypeNumberPad;
    [_pwdTextField addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    [_pwdTextField becomeFirstResponder];
    [self addSubview:_pwdTextField];
    CGFloat count = 0.0;
    CGFloat intputWidth = 0.0;
    if (self.inputType == UnderlineTypeInput) {
        count = PWD_COUNT;
        intputWidth = DOT_WIDTH;
    }else if (self.inputType == BoxTypeInput) {
        count = VERIFY_COUNT;
        intputWidth = BOX_WIDTH;
    }
    CGFloat width = self.bounds.size.width/count;
    for (int i = 0; i < count; i ++) {
        UILabel *dot = [[UILabel alloc]initWithFrame:CGRectMake((width-intputWidth)/2.f + i*width, (self.bounds.size.height-intputWidth)/2.f, intputWidth, intputWidth)];
        dot.userInteractionEnabled = true;
        dot.tag =  900 + i;
        dot.frame = CGRectMake(i*width + 2, 2, self.bounds.size.height - 4, self.bounds.size.height - 4);
        dot.textAlignment = NSTextAlignmentCenter;
        dot.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1];
        dot.textColor = UI_MAIN_COLOR;
        dot.font = [UIFont yx_systemFontOfSize:30];
        if (self.inputType == UnderlineTypeInput) {
            dot.hidden = true;
            UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(i*width + 5, self.bounds.size.height - 2, width - 10, 2.0f)];
            line.backgroundColor = [UIColor blackColor];
            [self addSubview:line];
        }else if (self.inputType == BoxTypeInput) {
            dot.backgroundColor = [UIColor whiteColor];
            dot.layer.borderColor = kUIColorFromRGB(0x808080).CGColor;
            dot.layer.borderWidth = 1;
            dot.layer.cornerRadius = 5;
        }
        [self addSubview:dot];
        [dataArr addObject:dot];
    }
}

-(CGFloat)obtainInputCount{
    CGFloat count = 0.0;
    if (self.inputType == UnderlineTypeInput) {
        count = PWD_COUNT;
    }else if (self.inputType == BoxTypeInput) {
        count = VERIFY_COUNT;
    }
    return count;
}

/**
  监测密码输入框值得变化

 @param textField 输入框
 */
-(void)textFieldChanged:(UITextField *)textField{
    //满足6位结果回调
    if (textField.text.length == [self obtainInputCount]) {
        if (_completeHandle) {
            _completeHandle(textField.text);
        }
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField.text.length >= [self obtainInputCount] && string.length) {
        //输入的字符个数大于6，则无法继续输入，返回NO表示禁止输入
        return NO;
    }
    //限制为数字输入
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^[0-9]*$"];
    if (![predicate evaluateWithObject:string]) {
        return NO;
    }
    NSString *totalString;
    if (string.length <= 0) {
        totalString = [textField.text substringToIndex:textField.text.length-1];
    }else {
        totalString = [NSString stringWithFormat:@"%@%@",textField.text,string];
    }
    //刷新显示视图
    [self setDotWithCount:totalString.length charStr:string];
    return YES;
}

- (void)setDotWithCount:(NSInteger)count charStr:(NSString *)charStr{

    //删除隐藏
    if ([charStr isEqualToString:@""]) {
        for (UILabel * dotLabel in dataArr) {
            if ( dotLabel.tag == count + 900) {
                dotLabel.text = @"";
                if (self.inputType == underline) {
                    dotLabel.hidden = true;
                }
                continue;
            }
        }
        return;
    };
    //增加
    for (int i = 0; i< count; i++) {
        UILabel * dotLabel = (UILabel*)[dataArr objectAtIndex:i];
        if (dotLabel.tag  == (count-1) + 900) {
            if (self.inputType == underline) {
                dotLabel.hidden = NO;
            }
            //显示的时候，赋值
            if (_isEnsconce) {
                dotLabel.text = charStr;
            }else{
                dotLabel.text = @"*";
            }
        }
    }
}

/**
 清理数据
 */
-(void)cleanUpTheData{
    self.pwdTextField.text = @"";
    for (UILabel * dotLabel in dataArr) {
        dotLabel.text = @"";
        if (self.inputType == underline) {
            dotLabel.hidden = true;
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
