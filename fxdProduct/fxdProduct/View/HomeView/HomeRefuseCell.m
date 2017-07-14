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
    __weak typeof(self) wekSelf = self;
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wekSelf.mas_left);
        make.right.equalTo(wekSelf.mas_right);
        make.top.equalTo(wekSelf.mas_top).with.offset(40);
        make.bottom.equalTo(wekSelf.mas_bottom);
        
    }];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 330;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ExpressCreditRefuseView *cell = [ExpressCreditRefuseView cellWithTableView:tableView];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.selected = NO;
    cell.backgroundColor = rgb(245, 245, 245);
    cell.homeProductList = _homeProductList;
    __weak typeof(self) weakSelf = self;
    cell.jumpBtnClick = ^(UIButton *jumpBtn) {
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(moreClick)]) {
            [weakSelf.delegate moreClick];
        }
    };
    cell.viewClick = ^(NSString *url){
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(clickView:)]) {
            [weakSelf.delegate clickView:url];
        }
    };
    return cell;
    
}

@end
