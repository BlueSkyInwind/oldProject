//
//  CustomerIDInfo.h
//  fxdProduct
//
//  Created by dd on 2017/3/2.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CustomerIDInfoResult;

@interface CustomerIDInfo : NSObject

@property (nonatomic , copy) NSString  *msg;

@property (nonatomic , copy) NSString  *flag;

@property (nonatomic , strong)CustomerIDInfoResult *result;

@end

@interface CustomerIDInfoResult : NSObject

@property (nonatomic , copy) NSString  *customer_name_;

@property (nonatomic , copy) NSString  *editable_field_;

@property (nonatomic , copy) NSString  *id_code_;

@end

