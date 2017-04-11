//
//  repayClearView.h
//  fxdProduct
//
//  Created by zy on 16/5/23.
//  Copyright © 2016年 dd. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol RepaySureBtnDelegate <NSObject>

-(void)MakeSureBtn:(NSInteger)tag;

@end
@interface repayClearView : UIView
{
    repayClearView *_epayClearView;
}
@property (weak, nonatomic) IBOutlet UIImageView *HomeImageView;
@property (weak, nonatomic) IBOutlet UIView *alertView;
@property (weak, nonatomic) IBOutlet UIView *BgView;
@property (weak, nonatomic) IBOutlet UIButton *DisSureBtn;

@property (weak, nonatomic) IBOutlet UIButton *SureBtn;
@property (weak, nonatomic) IBOutlet UILabel *Lbltitle;
@property (weak, nonatomic) IBOutlet UILabel *lblTotalMoney;
@property (weak, nonatomic) IBOutlet UILabel *lblRedPacket;

@property (weak, nonatomic) IBOutlet UILabel *lblLastRepay;
-(void)showfist;

-(void)show;

-(void)hide;
@property(assign,nonatomic)NSInteger num;
@property(weak,nonatomic)id<RepaySureBtnDelegate>delegat;
@end
