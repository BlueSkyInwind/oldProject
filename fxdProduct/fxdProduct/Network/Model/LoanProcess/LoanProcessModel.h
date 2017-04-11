//
//  LoanProcessModel.h
//  fxdProduct
//
//  Created by dd on 2017/2/8.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LoanProcessExt,LoanProcessResult;

@interface LoanProcessModel : NSObject

@property (nonatomic, copy) NSString *flag;
@property (nonatomic, strong) LoanProcessExt *ext;
@property (nonatomic, strong) NSArray<LoanProcessResult *> *result;
@property (nonatomic, copy) NSString *msg;

@end

@interface LoanProcessExt :NSObject

@property (nonatomic , copy) NSString *mobile_phone_;

@end

@interface LoanProcessResult :NSObject

@property (nonatomic , copy) NSString *content_;
@property (nonatomic , copy) NSString *audit_time_;
@property (nonatomic , copy) NSString *apply_status_;

@end
