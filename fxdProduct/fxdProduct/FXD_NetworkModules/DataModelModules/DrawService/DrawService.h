//
//  DrawService.h
//  fxdProduct
//
//  Created by dd on 2016/9/27.
//  Copyright © 2016年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Data;

@interface DrawService : NSObject

@property (nonatomic, copy) NSString *appcode;

@property (nonatomic, copy) NSString *success;

@property (nonatomic, copy) NSString *appmsg;

@property (nonatomic, copy) NSString *tracemsg;

@property (nonatomic, strong) Data *data;

@end

@interface Data : NSObject

@property (nonatomic, copy) NSString *appcode;

@property (nonatomic, copy) NSString *success;

@property (nonatomic, copy) NSString *flg;

@property (nonatomic, copy) NSString *appmsg;

@end
