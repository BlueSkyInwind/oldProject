//
//  FeesDescriptionViewController.m
//  fxdProduct
//
//  Created by admin on 2017/9/2.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "FeesDescriptionViewController.h"
#import "DrawingsInfoModel.h"
#import "FeeDescriptionTableViewCell.h"

@interface FeesDescriptionViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
    
    
}


@property (nonatomic,strong)UITableView * tableView;

@end

@implementation FeesDescriptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"费用详情";
    [self addBackItem];
    self.view.backgroundColor = [UIColor whiteColor];
    [self configuireView];
}

-(void)configuireView{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([FeeDescriptionTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"FeeDescriptionTableViewCell"];

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.feeArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FeeDescriptionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FeeDescriptionTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    SalaryFeeDetailModel * salaryFeeDetailModel = self.feeArray[indexPath.row];
    cell.titleLabel.text = salaryFeeDetailModel.label;
    cell.feeLabel.text = [NSString stringWithFormat:@"%@%@",salaryFeeDetailModel.value,salaryFeeDetailModel.unit];

    return cell;
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
