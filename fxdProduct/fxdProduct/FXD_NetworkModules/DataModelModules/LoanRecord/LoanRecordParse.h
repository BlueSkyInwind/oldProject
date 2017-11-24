//
//  LoanRecordParse.h
//  fxdProduct
//
//  Created by dd on 2017/2/8.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LoanRecordExt,LoanRecordResult;

@interface LoanRecordParse : NSObject

@property (nonatomic ,copy) NSString  *flag;
@property (nonatomic ,strong) LoanRecordExt  *ext;
@property (nonatomic ,strong) NSArray<LoanRecordResult *> *result;
@property (nonatomic ,copy) NSString *msg;

@end

@interface LoanRecordResult :NSObject

@property (nonatomic ,copy) NSString *content;

@end


@interface LoanRecordExt :NSObject

@property (nonatomic ,copy) NSString *mobile_phone_;

@end
