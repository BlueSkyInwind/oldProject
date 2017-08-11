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
    
    __weak typeof(self) wekSelf = self;
    UIView *tipView = [[UIView alloc]init];
    tipView.backgroundColor = [UIColor clearColor];
    [self addSubview:tipView];
    [tipView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(wekSelf.mas_top).with.offset(10);
        make.centerX.equalTo(wekSelf.mas_centerX);
        make.height.equalTo(@22);
        make.width.equalTo(@270);
    }];
    
    UIImageView *tipImage = [[UIImageView alloc]init];
    tipImage.image = [UIImage imageNamed:@"icon_shibai"];
    [tipView addSubview:tipImage];
    [tipImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tipView.mas_top).with.offset(0);
        make.left.equalTo(tipView.mas_left).with.offset(0);
    }];
    
    UILabel *tipLabel = [[UILabel alloc]init];
    tipLabel.text = @"很抱歉，您的借款申请审核失败";
    tipLabel.textColor = UI_MAIN_COLOR;
    if (UI_IS_IPHONE5) {
        tipLabel.font = [UIFont systemFontOfSize:13];
    }else{
        
        tipLabel.font = [UIFont systemFontOfSize:16];
    }
    [tipView addSubview:tipLabel];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tipView.mas_top).with.offset(3);
        make.left.equalTo(tipImage.mas_right).with.offset(10);
        make.height.equalTo(@15);
    }];
    self.tableView = [[UITableView alloc]init];
    self.tableView.delegate  =self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = YES;
    self.tableView.scrollEnabled = YES;
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
