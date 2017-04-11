//
//  JXLMessagePrse.h
//  fxdProduct
//
//  Created by dd on 2017/2/27.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JXLMessagePrseData;

@interface JXLMessagePrse : NSObject

@property (nonatomic , assign) BOOL              success;
@property (nonatomic , strong) JXLMessagePrseData   * data;

@end

@interface JXLMessagePrseData :NSObject
@property (nonatomic , copy) NSString              * content;
@property (nonatomic , assign) NSInteger              process_code;
@property (nonatomic , copy) NSString              * type;
@property (nonatomic , assign) BOOL              finish;

@end
