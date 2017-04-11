//
//  GetMoneyProcessBaseClass.h
//
//  Created by dd  on 15/11/9
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GetMoneyProcessResult.h"
#import "GetMoneyProcessUserBean.h"
#import "GetMoneyProcessBaseClass.h"

@class GetMoneyProcessResult;

@interface GetMoneyProcessBaseClass : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) GetMoneyProcessResult *result;
@property (nonatomic, strong) NSString *flag;
@property (nonatomic, strong) NSString *msg;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
