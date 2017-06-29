//
//  JRefuseView.h
//  fxdProduct
//
//  Created by sxp on 17/6/28.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ApplayBtn)();
typedef void(^AbandonBtn)();

@interface JRefuseView : UIView

@property (nonatomic,strong)UIImageView *nameImage;
@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UIImageView *contentImage;
@property (nonatomic,strong)UILabel *quotaLabel;
@property (nonatomic,strong)UILabel *termLabel;
@property (nonatomic,strong)UIButton *applayBtn;

-(instancetype)initWithFrame:(CGRect)frame;

@property (nonatomic,strong)UIButton *abandonBtn;

@property (nonatomic,copy)ApplayBtn applayBtnClick;
@property (nonatomic,copy)AbandonBtn abandonBtnClick;

-(void)setContent:(NSArray *)content;

@end
