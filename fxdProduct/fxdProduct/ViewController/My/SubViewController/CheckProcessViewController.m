//
//  CheckProcessViewController.m
//  fxdProduct
//
//  Created by dd on 15/8/28.
//  Copyright (c) 2015年 dd. All rights reserved.
//

#import "CheckProcessViewController.h"

@interface CheckProcessViewController (){
    NSArray *_dataArray;
    NSArray *_dataInfoArray;
    NSMutableArray *_dataNumList;

}
@property (weak, nonatomic) IBOutlet UILabel *loanCreditLabel;
//时间label
@property (weak, nonatomic) IBOutlet UILabel *submitLabel;
@property (weak, nonatomic) IBOutlet UILabel *checkLable;
@property (weak, nonatomic) IBOutlet UILabel *successLabel;

@property (weak, nonatomic) IBOutlet UIImageView *progressImageview;

@property (weak, nonatomic) IBOutlet UILabel *cardMessageLabel;
@property (weak, nonatomic) IBOutlet UILabel *borrowDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *middleLabel;

@end

@implementation CheckProcessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataNumList=[NSMutableArray new];
    
    [self addBackItem1];
    self.title=@"进度审核";
//    [self postUrlMessage];
    [self createCheckProgressUI];
}
- (void)addBackItem1
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    
    UIImage *img = [[UIImage imageNamed:@"back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [btn setImage:img forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 0, 45, 44);
    [btn addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    
    //    修改距离,距离边缘的
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width = -15;
    
    self.navigationItem.leftBarButtonItems = @[spaceItem,item];
}

- (void)popBack
{
    
    if ([self.delegate respondsToSelector:@selector(GetCheckDelegate)]) {
        [self.delegate GetCheckDelegate];
    }
    [self.navigationController popViewControllerAnimated:YES];
}


//创建UI
-(void)createCheckProgressUI{
    _dataArray=@[@"中国工商银行",@"中国农业银行",@"中国银行",@"中国建设银行",@"交通银行",@"中信银行",@"中国光大银行",@"华夏银行",@"中国民生银行",@"广东发展银行",@"招商银行",@"兴业银行",@"上海浦东发展银行",@"中国邮政储蓄银行"];
    _dataInfoArray=@[@"ICBC",@"ABC",@"BOC",@"CCB",
                     @"COMM",@"CITIC",@"CEB",@"HXB",
                     @"CMBC",@"GDB",@"CMB",@"CIB",
                     @"SPDB",@"PSBC"];
//    self.progressImageview.image=[UIImage imageNamed:@"check_fore_prograssbar"];
//    self.progressImageview.image=[UIImage imageNamed:@"check_bg_prograssbar"];
//    CheckProcess/
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //            NSString *dat=@"2015-10-2901: 02: 032015-11-03 14:15:25";
    NSDate *date1=[dateFormatter dateFromString:_reslutModel.submitDate];
    NSDate *date2=[dateFormatter dateFromString:_reslutModel.createDate];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *dstring=[dateFormatter stringFromDate:date1];
    NSString *dstring2=[dateFormatter stringFromDate:date2];
    NSString *nowData=[dateFormatter stringFromDate:[NSDate date]];
    self.submitLabel.text=dstring;
    self.checkLable.text=nowData;
//    self.successLabel.text=[_reslutModel.createDate substringToIndex:16];
    self.borrowDateLabel.text=dstring2;
    self.loanCreditLabel.text=[NSString stringWithFormat:@"%.0f",_reslutModel.applyAmount];
    for (NSInteger i=0; i<_dataInfoArray.count; i++) {
        if ([_reslutModel.userBean.debitBankName isEqualToString: _dataInfoArray[i]]) {
            [_dataNumList addObject:_dataArray[i]];
        }
    }
//    self.cardMessageLabel.text=[NSString stringWithFormat:@"%@ (尾号%@)",_dataNumList[0],[_reslutModel.userBean.debitCardNo substringFromIndex:[_reslutModel.userBean.debitCardNo length]-4]];
    self.cardMessageLabel.text=[NSString stringWithFormat:@"%@ (尾号%@)",_reslutModel.userBean.debitBankName,[_reslutModel.userBean.bankNo substringFromIndex:[_reslutModel.userBean.bankNo length]-4]];
    
    if (_proTag == 100) {
        self.middleLabel.text=@"审核中";
        self.checkLable.hidden = YES;
    }else{
        self.middleLabel.text=@"审核成功";
        self.checkLable.hidden = NO;
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//隐藏与现实tabbar
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}


@end
