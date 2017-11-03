//
//  GetMoneyResultBaseClass.h
//
//  Created by dd  on 15/10/16
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GetMoneyResultResult.h"
#import "GetMoneyResultAuditRecordBean.h"
#import "GetMoneyResultBaseClass.h"

@class GetMoneyResultResult;

@interface GetMoneyResultBaseClass : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) GetMoneyResultResult *result;
@property (nonatomic, strong) NSString *flag;
@property (nonatomic, strong) NSString *msg;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
