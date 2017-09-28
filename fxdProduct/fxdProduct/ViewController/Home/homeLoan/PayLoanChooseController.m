//
//  PayLoanChooseController.m
//  fxdProduct
//
//  Created by dd on 2017/2/6.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "PayLoanChooseController.h"
#import "SumCell.h"
#import "DaysCell.h"
#import "MoneyPlanCell.h"
#import "UserStateModel.h"
#import "LoanSureSecondViewController.h"
#import "UserDataViewController.h"
#import "RateModel.h"
#import "LoanSureFirstViewController.h"

@interface PayLoanChooseController ()<UITableViewDelegate,UITableViewDataSource>
{
    BOOL _lowBtnSelect;
    BOOL _middleBtnSelect;
    BOOL _heighBtnSelect;
    NSString *_user_req_amt;
    NSString *operatorText;
    NSString *serverText;
    NSString *finalText;
    NSString *repayText;
    NSInteger isFirst;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation PayLoanChooseController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"选择金额";
    [self addBackItem];
    
    if (UI_IS_IPHONE5) {
        self.automaticallyAdjustsScrollViewInsets = false;
    } else {
        self.automaticallyAdjustsScrollViewInsets = true;
    }
    NSString *device = [[UIDevice currentDevice] systemVersion];
    if (device.floatValue>10) {
        self.automaticallyAdjustsScrollViewInsets = true;
    }else{
    
        self.automaticallyAdjustsScrollViewInsets = false;
    }
    isFirst = 0;
    
    operatorText = @"0元";
    serverText = @"0元";
    finalText = @"0元";
    repayText = @"0元";
    
    _lowBtnSelect = false;
    _middleBtnSelect = false;
    _heighBtnSelect = false;
    
    [self setUpTableview];
}


- (void)setUpTableview
{
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SumCell class]) bundle:nil] forCellReuseIdentifier:@"SumCell"];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DaysCell class]) bundle:nil] forCellReuseIdentifier:@"DaysCell"];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MoneyPlanCell class]) bundle:nil] forCellReuseIdentifier:@"MoneyPlanCell"];
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _k_w, 100)];
//    footView.backgroundColor = [UIColor blackColor];
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [nextBtn setBackgroundColor:UI_MAIN_COLOR];
    [Tool setCorner:nextBtn borderColor:[UIColor clearColor]];
    [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [footView addSubview:nextBtn];
    [nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.right.equalTo(@(-20));
        make.bottom.equalTo(@0);
        make.top.equalTo(@50);
    }];
    self.tableView.tableFooterView = footView;
}

- (void)nextBtnClick
{
    if (_lowBtnSelect) {
        _user_req_amt = @"500";
    }
    if (_middleBtnSelect) {
        _user_req_amt = @"800";
    }
    if (_heighBtnSelect) {
        _user_req_amt = @"1000";
    }
    if (_user_req_amt) {
        if ([_userState.applyFlag isEqualToString:@"0005"]) {
            LoanSureSecondViewController *loanSecondVC = [[LoanSureSecondViewController alloc] init];
            loanSecondVC.model = _userState;
            loanSecondVC.productId = _product_id;
            loanSecondVC.req_loan_amt = _user_req_amt;
            [self.navigationController pushViewController:loanSecondVC animated:true];
        }else{
//            LoanSureFirstViewController *loanFirstVC = [[LoanSureFirstViewController alloc] init];
//            loanFirstVC.productId = _product_id;
//            loanFirstVC.if_family_know = _is_know;
//            loanFirstVC.resultCode = _resultcode;
//            loanFirstVC.rulesId = _rulesid;
//            loanFirstVC.model = _userState;
//            if ([_product_id isEqualToString:@"P001004"]) {
//                loanFirstVC.req_loan_amt = _user_req_amt;
//            }
//            [self.navigationController pushViewController:loanFirstVC animated:true];
            UserDataViewController *userDataVC = [[UserDataViewController alloc] init];
            userDataVC.req_loan_amt = _user_req_amt;
            userDataVC.product_id = _product_id;
            [self.navigationController pushViewController:userDataVC animated:true];

        }
        
    } else {
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请选择借款金额"];
    }
    
}

#pragma mark - TableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row % 2 == 0) {
        return 30.f;
    } else {
        return 100.f;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        cell.backgroundColor = rgb(242, 242, 242);
        cell.textLabel.textColor = rgb(118, 118, 118);
        cell.textLabel.font = [UIFont systemFontOfSize:13.f];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.row == 0) {
        cell.textLabel.text = @"请选择借款金额";
        return cell;
    }
    if (indexPath.row == 1) {
        SumCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SumCell"];
        [cell.lowBtn setTitle:@"500元" forState:UIControlStateNormal];
        [cell.middleBtn setTitle:@"800元" forState:UIControlStateNormal];
        [cell.heighBtn setTitle:@"1000元" forState:UIControlStateNormal];
        cell.lowBtn.selected = _lowBtnSelect;
        cell.middleBtn.selected = _middleBtnSelect;
        cell.heighBtn.selected = _heighBtnSelect;
        cell.lowBtn.tag = 100;
        cell.middleBtn.tag = 101;
        cell.heighBtn.tag = 102;
        if (cell.lowBtn.selected) {
            [cell.lowBtn setBackgroundColor:UI_MAIN_COLOR];
            cell.lowBtn.layer.borderColor = [UIColor clearColor].CGColor;
        }else {
            [cell.lowBtn setBackgroundColor:[UIColor whiteColor]];
            cell.lowBtn.layer.borderColor = [UIColor blackColor].CGColor;
        }
        if (cell.middleBtn.selected) {
            [cell.middleBtn setBackgroundColor:UI_MAIN_COLOR];
            cell.middleBtn.layer.borderColor = [UIColor clearColor].CGColor;
        }else {
            [cell.middleBtn setBackgroundColor:[UIColor whiteColor]];
            cell.middleBtn.layer.borderColor = [UIColor blackColor].CGColor;
        }
        if (cell.heighBtn.selected) {
            [cell.heighBtn setBackgroundColor:UI_MAIN_COLOR];
            cell.heighBtn.layer.borderColor = [UIColor clearColor].CGColor;
        }else {
            [cell.heighBtn setBackgroundColor:[UIColor whiteColor]];
            cell.heighBtn.layer.borderColor = [UIColor blackColor].CGColor;
        }
        [cell.lowBtn addTarget:self action:@selector(chooseMoney:) forControlEvents:UIControlEventTouchUpInside];
        if (isFirst == 0) {
            [self chooseMoney:cell.lowBtn];
        }
        
        [cell.middleBtn addTarget:self action:@selector(chooseMoney:) forControlEvents:UIControlEventTouchUpInside];
        [cell.heighBtn addTarget:self action:@selector(chooseMoney:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    if (indexPath.row == 2) {
        cell.textLabel.text = @"请选择借款期限";
        return cell;
    }
    if (indexPath.row == 3) {
        DaysCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DaysCell"];
        cell.dayLabel.text =  [Utility sharedUtility].rateParse.result.ext_attr_.period_desc_;
        return cell;
    }
    if (indexPath.row == 4) {
        cell.textLabel.text = @"费用预计";
        return cell;
    }
    if (indexPath.row == 5) {
        MoneyPlanCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MoneyPlanCell"];
        cell.operatorFeeLabel.text = operatorText;
        cell.sercerFee.text = serverText;
        cell.finalAmountLabel.text = finalText;
        cell.repayAmountLabel.text = repayText;
        return cell;
    }
    return cell;
}



//100 101 102
- (void)chooseMoney:(UIButton *)sender
{
    DLog(@"%ld----%d",sender.tag,sender.selected);
    isFirst++;
    if (!sender.selected) {
        switch (sender.tag) {
            case 100: {
                _lowBtnSelect = true;
                _middleBtnSelect = false;
                _heighBtnSelect = false;
                
                //"out_day_interest_fee_" : 0.003,
                //"out_day_service_fee_" : 0.097,
                //"out_operate_fee_" : 0.06,
                operatorText = [NSString stringWithFormat:@"%.2f元",500*_rateModel.result.out_operate_fee_];
                serverText = [NSString stringWithFormat:@"%.2f元",500*(_rateModel.result.out_day_interest_fee_+_rateModel.result.out_day_service_fee_)*14];
                finalText = [NSString stringWithFormat:@"%.2f元",500*(1-(_rateModel.result.out_day_interest_fee_+_rateModel.result.out_day_service_fee_)*14-_rateModel.result.out_operate_fee_)];
                repayText = @"500元";
                
            }
                break;
            case 101: {
                _lowBtnSelect = false;
                _middleBtnSelect = true;
                _heighBtnSelect = false;
                operatorText = [NSString stringWithFormat:@"%.2f元",800*_rateModel.result.out_operate_fee_];
                serverText = [NSString stringWithFormat:@"%.2f元",800*(_rateModel.result.out_day_interest_fee_+_rateModel.result.out_day_service_fee_)*14];
                finalText = [NSString stringWithFormat:@"%.2f元",800*(1-(_rateModel.result.out_day_interest_fee_+_rateModel.result.out_day_service_fee_)*14-_rateModel.result.out_operate_fee_)];
                repayText = @"800元";
            }
                break;
            case 102: {
                _lowBtnSelect = false;
                _middleBtnSelect = false;
                _heighBtnSelect = true;
                operatorText = [NSString stringWithFormat:@"%.2f元",1000*_rateModel.result.out_operate_fee_];
                serverText = [NSString stringWithFormat:@"%.2f元",1000*(_rateModel.result.out_day_interest_fee_+_rateModel.result.out_day_service_fee_)*14];
                finalText = [NSString stringWithFormat:@"%.2f元",1000*(1-(_rateModel.result.out_day_interest_fee_+_rateModel.result.out_day_service_fee_)*14-_rateModel.result.out_operate_fee_)];
                repayText = @"1000元";
            }
                break;
            default:
                break;
        }
        [self.tableView reloadData];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
