//
//  RepayListCell.h
//  fxdProduct
//
//  Created by dd on 16/8/31.
//  Copyright © 2016年 dd. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Situations,BillList;

typedef NS_ENUM(NSUInteger, CellDisplayStyle) {
    RepayCellNormal = 0,
    RepayCellDetail,
};

typedef void(^DetailClickBlock)(NSInteger row);

@protocol RepayCellDelegate <NSObject>

- (void)clickCell:(NSInteger )row selectState:(BOOL)state;

@end


@interface RepayListCell : UITableViewCell

@property (nonatomic, assign) CellDisplayStyle displayStyle;

@property (nonatomic, strong) DetailClickBlock detailClickBlock;

@property (nonatomic, weak)id<RepayCellDelegate> delegate;

@property (nonatomic, assign) NSInteger row;

@property (weak, nonatomic) IBOutlet UIView *identifierView;

@property (weak, nonatomic) IBOutlet UILabel *numberOfIdentifier;

@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

//剩余天数
@property (weak, nonatomic) IBOutlet UILabel *overTime;

@property (nonatomic, assign) BOOL identifierSelect;

@property (nonatomic, strong) NSArray<NSNumber *> *cellSelectArr;

//期供信息状态
@property (weak, nonatomic) IBOutlet UIView *orderStateView;

@property (weak, nonatomic) IBOutlet UIView *detailStateView;

@property (weak, nonatomic) IBOutlet UILabel *detailStateLabel;


//发薪贷期供信息
@property (nonatomic,strong) Situations *situation;

//P2P期供信息
@property (nonatomic, strong) BillList *bill;

//可点击最小坐标
@property (nonatomic,assign) NSUInteger clickMinIndex;

//可点击最大坐标
@property (nonatomic,assign) NSInteger clickMaxIndex;

@end
