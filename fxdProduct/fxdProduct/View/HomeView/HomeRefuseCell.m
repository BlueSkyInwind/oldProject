//
//  HomeRefuseCell.m
//  fxdProduct
//
//  Created by sxp on 2017/7/5.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "HomeRefuseCell.h"
#import "ExpressCreditRefuseView.h"
#import "FXDWebViewController.h"
@interface HomeRefuseCell ()
@property (strong, nonatomic) UITableView *tableView;
@end

@implementation HomeRefuseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


+ (instancetype)cellWithTableView:(UITableView *)tableView {
    // NSLog(@"cellForRowAtIndexPath");
    static NSString *identifier = @"status";
    // 1.缓存中取
    HomeRefuseCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil) {
        cell = [[HomeRefuseCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configureView];
    }
    return self;
}


-(void)configureView{

    self.tableView = [[UITableView alloc]init];
    self.tableView.delegate  =self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = YES;
    self.tableView.scrollEnabled = YES;
    
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
        
    }];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (UI_IS_IPHONE5) {
        return 30;
    }
    return 330;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ExpressCreditRefuseView *cell = [ExpressCreditRefuseView cellWithTableView:tableView];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.selected = NO;
    cell.backgroundColor = [UIColor grayColor];
    NSArray *content = @[@"用钱宝",@"额度：最高5000元",@"期限：7-30天",@"费用：0.3%/日",@"贷嘛",@"额度：1000元-10万元",@"期限：1-60月",@"费用：0.35%-2%月"];
    [cell setContent:content];
    __weak typeof(self) weakSelf = self;
    cell.jumpBtnClick = ^(UIButton *jumpBtn) {
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(moreClick)]) {
            [weakSelf.delegate moreClick];
        }
//        [weakSelf moreClick];
    };
    cell.viewClick = ^(NSString *url){
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(clickView:)]) {
            [weakSelf.delegate clickView:url];
        }
//        [weakSelf clickView:url];
    };
    return cell;
    
}

///**
// 点击view
// */
//-(void)clickView:(NSString *)url{
//    
//    FXDWebViewController *webVC = [[FXDWebViewController alloc] init];
//    webVC.urlStr = url;
//    [self.navigationController pushViewController:webVC animated:true];
//    
//}
//
///**
// 点击更多
// */
//-(void)moreClick{
//    
//    FXDWebViewController *webVC = [[FXDWebViewController alloc] init];
//    webVC.urlStr = @"http:www.baidu.com";
//    [self.navigationController pushViewController:webVC animated:true];
//}

@end
