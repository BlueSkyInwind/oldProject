//
//  GetMoneyResultResult.h
//
//  Created by dd  on 15/10/16
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GetMoneyResultAuditRecordBean;

@interface GetMoneyResultResult : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double resultIdentifier;
@property (nonatomic, strong) NSString *isExport;
@property (nonatomic, assign) double createId;
@property (nonatomic, assign) double applicantId;
@property (nonatomic, strong) NSString *createDate;
@property (nonatomic, assign) double bankCardId;
@property (nonatomic, strong) GetMoneyResultAuditRecordBean *auditRecordBean;
@property (nonatomic, strong) NSString *isSettlement;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *isLoan;
@property (nonatomic, assign) double applyAmount;
@property (nonatomic, assign) double interest;
@property (nonatomic, assign) double periods;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
