//
//  HomeRefuseCell.h
//  fxdProduct
//
//  Created by sxp on 2017/7/5.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeProductList.h"

@protocol HomeRefuseCellDelegate <NSObject>
-(void)clickView:(NSString *)url;
-(void)moreClick;
@end

@interface HomeRefuseCell : UITableViewCell<UITableViewDelegate,UITableViewDataSource>

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property(nonatomic,assign) id<HomeRefuseCellDelegate>delegate;

@property (nonatomic,strong)HomeProductList *homeProductList;

@end
