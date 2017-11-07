//
//  GetMoneyStateData.h
//
//  Created by dd  on 15/10/10
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GetMoneyStateUserBean;

@interface GetMoneyStateData : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *createDate;
@property (nonatomic, strong) GetMoneyStateUserBean *userBean;
@property (nonatomic, assign) double loanAmount;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
