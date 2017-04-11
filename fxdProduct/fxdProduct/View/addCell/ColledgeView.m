//
//  ColledgeView.m
//  fxdProduct
//
//  Created by zhangbaochuan on 15/12/11.
//  Copyright © 2015年 dd. All rights reserved.
//

#import "ColledgeView.h"
#import "DataDicParse.h"

@implementation ColledgeView

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self setupUI];
}

-(void)setupUI
{
//    _array = @[@"博士及以上",@"硕士",@"本科",@"大专",@"高中",@"其他"];
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    self.bgView.backgroundColor =[UIColor colorWithWhite:0 alpha:0.5];
    self.secondView.layer.borderWidth = 1;
    self.secondView.layer.borderColor = [[UIColor blackColor]CGColor];
    self.secondView.layer.cornerRadius = 10;
    self.secondView.layer.masksToBounds = YES;
    self.secondView.backgroundColor = [UIColor whiteColor];
//    RGBColor(239, 239, 239, 1);
    self.CollTableView.backgroundColor = [UIColor clearColor];
    self.CollTableView.dataSource = self;
    self.CollTableView.delegate =self;
    self.CollTableView.tableFooterView = [[UIView alloc] init];
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
 //   [self addGestureRecognizer:tap];
}
-(void)donghua
{
    self.secondView.alpha = 0;
    self.secondView.hidden = YES;
    [UIView animateWithDuration:1 animations:^{
        self.secondView.alpha = 1;
        self.secondView.hidden = NO;
    } completion:^(BOOL finished) {
        
    }];
}
-(void)showfist
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.secondView.alpha=0;
    self.secondView.hidden=YES;
    [window addSubview:self];
}

-(void)show
{
    //显示
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    [self donghua];
}

- (void)hide {
    
    [UIView animateWithDuration:0.35 animations:^{
        self.secondView.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma ->uitable

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataDic.result.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellindex= @"aabc";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellindex];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellindex];
    }
    cell.textLabel.text = _dataDic.result[indexPath.row].desc_;

    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self.delegate respondsToSelector:@selector(ColledgeDelegateNString:andIndex:)]) {
        [self.delegate ColledgeDelegateNString:_dataDic.result[indexPath.row].desc_ andIndex:indexPath];
    }
    [self hide];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"选择您的学历";
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
@end
