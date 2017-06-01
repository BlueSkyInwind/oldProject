//
//  SaveLoanCaseModel.h
//  fxdProduct
//
//  Created by sxp on 17/6/1.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SaveLoanCaseResultModel;
@interface SaveLoanCaseModel : NSObject

@property (nonatomic,copy)NSString *flag;

@property (nonatomic,strong)SaveLoanCaseResultModel *result;

@end

@interface SaveLoanCaseResultModel : NSObject

@property (nonatomic,copy)NSString *appcode;

@property (nonatomic,copy)NSString *type_;

@property (nonatomic,copy)NSString *success;

@end
