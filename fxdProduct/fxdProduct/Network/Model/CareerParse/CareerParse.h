//
//  CareerParse.h
//  fxdProduct
//
//  Created by dd on 2017/2/8.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CareerExt,CareerResult;

@interface CareerParse : NSObject

@property (nonatomic ,copy) NSString *flag;
@property (nonatomic ,strong) CareerExt *ext;
@property (nonatomic ,strong) CareerResult *result;
@property (nonatomic ,copy) NSString *msg;

@end

@interface CareerExt :NSObject

@property (nonatomic ,copy) NSString *mobile_phone_;

@end

@interface CareerResult :NSObject
@property (nonatomic ,copy) NSString *rulesid;
@property (nonatomic ,copy) NSString *resultcode;

@end
