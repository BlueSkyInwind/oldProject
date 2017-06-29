//
//  RepayRequestManage.h
//  fxdProduct
//
//  Created by dd on 2017/2/12.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RepayRequestManage : NSObject

- (void)repayRequest;

@property (nonatomic, strong) UIViewController *targetVC;
@property (nonatomic,assign)BOOL isP2pView;


@end
