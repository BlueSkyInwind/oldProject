//
//  SelectTableViewController.h
//  present
//
//  Created by dd on 16/5/20.
//  Copyright © 2016年 dd. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Available_Redpackets;

@protocol SelectViewDelegate <NSObject>

- (void)selectIndex:(NSInteger)index;

@end

@interface SelectTableViewController : UITableViewController

@property (nonatomic ,weak) id <SelectViewDelegate>delegate;

@property (nonatomic, strong)NSArray<Available_Redpackets *> *dataArr;

- (void)setData:(NSArray<Available_Redpackets *> *)dataArr;

@end
