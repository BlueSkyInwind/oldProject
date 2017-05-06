//
//  SubmitZhimaCreditAuthModel.h
//  fxdProduct
//
//  Created by sxp on 17/5/5.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SubmitResult;
@interface SubmitZhimaCreditAuthModel : NSObject


@property (nonatomic,strong)SubmitResult *result;


@end

@interface SubmitResult : NSObject

@property (nonatomic,strong)NSString *auth_url;

@end
