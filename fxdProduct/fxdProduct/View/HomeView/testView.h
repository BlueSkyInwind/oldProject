//
//  testView.h
//  myAlertView
//
//  Created by wxd on 15/10/28.
//  Copyright (c) 2015年 lzj. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MakeSureBtnDelegate <NSObject>

-(void)MakeSureBtn:(NSInteger)tag;

@end

@interface testView : UIView
{
    testView *_testView;
}

@property (weak, nonatomic) IBOutlet UIImageView *homeImageView;

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *lbltitle;

@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet UIView *alertView;
@property (weak, nonatomic) IBOutlet UIButton *DisSureBtn;

-(void)showfist;

-(void)show;

-(void)hide;
@property(assign,nonatomic)NSInteger num;
@property(weak,nonatomic)id<MakeSureBtnDelegate>delegat;

@end
