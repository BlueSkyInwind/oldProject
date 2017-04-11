//
//  ColledgeView.h
//  fxdProduct
//
//  Created by zhangbaochuan on 15/12/11.
//  Copyright © 2015年 dd. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DataDicParse;

@protocol ColledgeViewDelegate <NSObject>

-(void)ColledgeDelegateNString:(NSString *)CollString andIndex:(NSIndexPath *)indexPath;

@end

@interface ColledgeView : UIView<UITableViewDelegate,UITableViewDataSource>
{
    ColledgeView *_CollView;
//    NSArray *_array;
}
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIView *secondView;
@property (weak, nonatomic) IBOutlet UITableView *CollTableView;

@property (nonatomic, strong)DataDicParse *dataDic;

@property (weak, nonatomic)id <ColledgeViewDelegate>delegate;

-(void)showfist;

-(void)show;

-(void)hide;

@end
