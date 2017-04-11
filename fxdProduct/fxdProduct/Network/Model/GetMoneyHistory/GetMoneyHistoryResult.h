//
//  GetMoneyHistoryResult.h
//
//  Created by dd  on 15/12/18
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface GetMoneyHistoryResult : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *submitDate;
@property (nonatomic, assign) double applyAmount;
@property (nonatomic, assign) double resultIdentifier;
@property (nonatomic, assign) double periods;
@property (nonatomic, assign) double loanAmount;
@property (nonatomic, strong) NSString *createDate;
@property (nonatomic, assign) double interest;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
