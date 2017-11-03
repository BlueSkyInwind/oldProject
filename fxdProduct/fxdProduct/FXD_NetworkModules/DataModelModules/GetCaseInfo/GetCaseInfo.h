//
//  GetCaseInfo.h
//  fxdProduct
//
//  Created by dd on 2016/9/27.
//  Copyright © 2016年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CaseInfoResult;

@interface GetCaseInfo : NSObject

@property (nonatomic, copy) NSString *flag;

@property (nonatomic, strong) CaseInfoResult *result;

@end

@interface CaseInfoResult : NSObject

@property (nonatomic, copy) NSString *from_;

@property (nonatomic, copy) NSString *client_;

@property (nonatomic, copy) NSString *desc_;

@property (nonatomic, copy) NSString *start_date_;

@property (nonatomic, copy) NSString *amount_;

@property (nonatomic, copy) NSString *from_case_id_;

@property (nonatomic, copy) NSString *product_id_;

@property (nonatomic, copy) NSString *auditor_;

@property (nonatomic, copy) NSString *user_id_;

@property (nonatomic, copy) NSString *description_;

@property (nonatomic, copy) NSString *invest_days_;

@property (nonatomic, copy) NSString *title_;

@end
