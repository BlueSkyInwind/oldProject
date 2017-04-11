//
//  GetMoneyResultAuditRecordBean.h
//
//  Created by dd  on 15/10/16
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface GetMoneyResultAuditRecordBean : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *trialStatus;
@property (nonatomic, strong) NSString *submitTime;
@property (nonatomic, assign) double auditRecordBeanIdentifier;
@property (nonatomic, strong) NSString *lastCompleteTime;
@property (nonatomic, strong) NSString *auditTime;
@property (nonatomic, strong) NSString *createDate;
@property (nonatomic, assign) double cashWithdrawalId;
@property (nonatomic, assign) double createId;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
