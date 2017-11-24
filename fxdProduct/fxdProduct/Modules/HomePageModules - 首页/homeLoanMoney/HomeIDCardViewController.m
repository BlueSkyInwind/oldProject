//
//  HomeIDCardViewController.m
//  fxdProduct
//
//  Created by zhangbaochuan on 15/12/8.
//  Copyright © 2015年 dd. All rights reserved.
//

#import "HomeIDCardViewController.h"
#import "AddressViewController.h"
#import "CameraViewController.h"
#import "WintoneCardOCR.h"

typedef enum {
    IDCARD_FRONT = 0,
    IDCARD_BACK = 1
} EnumIDcardType;


@interface HomeIDCardViewController () <IDCardDelegate>
{
    NSString *_realName;
    NSString *_identityId;
    NSString *_contractingAuthority;
}

@property (assign, nonatomic) int cardType;

@property (assign, nonatomic) int resultCount;

@property (strong, nonatomic) NSString *typeName;

@property (nonatomic, assign) EnumIDcardType IDCardDirection;

@end

@implementation HomeIDCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"填写资料";
    [self addBackItem];
    
    self.cardType = 2;
    self.resultCount = 7; 
    self.typeName = @"二代证身份证";
    
    UITapGestureRecognizer *tapTop = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTopClick)];
    [self.topIdView addGestureRecognizer:tapTop];
    
    UITapGestureRecognizer *bottomTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bottomTapClick)];
    [self.botomIdView addGestureRecognizer:bottomTap];
    [self.hiddeninfoView setHidden:YES];
}


//身份证正面扫描
-(void)tapTopClick
{
    DLog(@"zhengmiam");
    self.IDCardDirection = IDCARD_FRONT;
    [self recordImage];
}
//身份证反面扫描
-(void)bottomTapClick
{
    DLog(@"反面");
    self.IDCardDirection = IDCARD_BACK;
    [self recordImage];
    [self.hiddeninfoView setHidden:NO];
}

- (void)recordImage
{
    CameraViewController *cameraVC = [[CameraViewController alloc] init];
    cameraVC.delegate = self;
    cameraVC.recogType = self.cardType;
    cameraVC.resultCount = self.resultCount;
    cameraVC.typeName = self.typeName;
    [self.navigationController pushViewController:cameraVC animated:YES];
    [self.hiddeninfoView setHidden:NO];
}

- (void)returnIDCardResult:(NSString *)resultStr
{
    NSArray *resultArr = [resultStr componentsSeparatedByString:@"\n"];
    
    if (self.IDCardDirection == IDCARD_FRONT) {
        if (resultArr.count >= 6) {
            _realName = [resultArr objectAtIndex:0];
            _identityId = [resultArr objectAtIndex:resultArr.count-2];
            self.labelName.text = [NSString stringWithFormat:@"姓名: %@",[resultArr objectAtIndex:0]];
            NSMutableAttributedString *att2=[[NSMutableAttributedString alloc] initWithString:self.labelName.text];
            [att2 addAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} range:NSMakeRange(0, 3)];
            self.labelName.attributedText=att2;
            self.labelCard.text = [NSString stringWithFormat:@"身份证号: %@",[resultArr objectAtIndex:resultArr.count-2]];
            NSMutableAttributedString *att3=[[NSMutableAttributedString alloc] initWithString:self.labelCard.text];
            [att3 addAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} range:NSMakeRange(0, 5)];
            self.labelCard.attributedText=att3;
            
        } else {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请选择正面拍照"];
        }
    }
    
    if (self.IDCardDirection == IDCARD_BACK) {
        if (resultArr.count < 6) {
            _contractingAuthority = [resultArr objectAtIndex:0];
            self.labelCompany.text = [NSString stringWithFormat:@"签发机关: %@",[resultArr objectAtIndex:0]];
            NSMutableAttributedString *att=[[NSMutableAttributedString alloc] initWithString:self.labelCompany.text];
            [att addAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} range:NSMakeRange(0, 5)];
            self.labelCompany.attributedText=att;
            
            self.labelDate.text = [NSString stringWithFormat:@"有效期限: %@-%@",[[resultArr objectAtIndex:2] stringByReplacingOccurrencesOfString:@"-" withString:@"."],[[resultArr objectAtIndex:3] stringByReplacingOccurrencesOfString:@"-" withString:@"."]];
            NSMutableAttributedString *att1=[[NSMutableAttributedString alloc] initWithString:self.labelDate.text];
            [att1 addAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} range:NSMakeRange(0, 5)];
            self.labelDate.attributedText=att1;
            
        } else {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请选择反面拍照"];
        }
    }
}

- (IBAction)sureBtn:(id)sender {
    if ([_labelName.text length]<6 || [_labelCard.text length]<23) {
        if ([_labelName.text length]<1 || [_labelCard.text length]<1){
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请选择正面拍照"];
        }else{
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请重拍正面"];
        }
    }else if ([_labelCompany.text length]<9 || [_labelDate.text length]<26){
        if ([_labelCompany.text length]<1 || [_labelDate.text length]<1)
        {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请选择反面拍照"];
        }else{
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请重拍反面"];
        }
    }else{
        [self setParamDic];
        DLog(@"%@",[Utility sharedUtility].getMoneyParam);
        AddressViewController *addressVC = [AddressViewController new];
        [self.navigationController pushViewController:addressVC animated:YES];
    }
}

- (void)setParamDic
{
    NSDictionary *dic = @{@"realName":_realName,
                          @"identityId":_identityId,
                          @"contractingAuthority":_contractingAuthority};
    [[Utility sharedUtility].getMoneyParam addEntriesFromDictionary:dic];
}

//隐藏tabbar
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

@end
