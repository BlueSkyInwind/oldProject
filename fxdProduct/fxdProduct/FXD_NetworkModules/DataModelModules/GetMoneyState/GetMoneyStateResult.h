//
//  GetMoneyStateResult.h
//
//  Created by dd  on 15/10/28
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GetMoneyStateUserBean;

@interface GetMoneyStateResult : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *submitDate;
@property (nonatomic, strong) NSString *auditSuccessDate;
@property (nonatomic, assign) double resultIdentifier;
@property (nonatomic, assign) double loanAmount;
@property (nonatomic, strong) NSString *createDate;
@property (nonatomic, strong) GetMoneyStateUserBean *userBean;
@property (nonatomic, strong) NSString *loanSuccessDate;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
