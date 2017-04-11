//
//  PushParse.h
//  fxdProduct
//
//  Created by d on 15/11/5.
//  Copyright © 2015年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PushParse : NSObject

@property (nonatomic,assign) NSInteger badge;
@property (nonatomic,assign) NSInteger type;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *content;

@end
