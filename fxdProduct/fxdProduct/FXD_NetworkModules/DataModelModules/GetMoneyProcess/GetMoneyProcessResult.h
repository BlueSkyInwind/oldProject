//
//  GetMoneyProcessResult.h
//
//  Created by dd  on 15/11/9
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GetMoneyProcessUserBean;

@interface GetMoneyProcessResult : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *submitDate;
@property (nonatomic, assign) double applyAmount;
@property (nonatomic, assign) double resultIdentifier;
@property (nonatomic, strong) NSString *loanAmount;
@property (nonatomic, strong) NSString *auditSuccessDate;
@property (nonatomic, strong) NSString *createDate;
@property (nonatomic, strong) GetMoneyProcessUserBean *userBean;
@property (nonatomic, strong) NSString *loanSuccessDate;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
