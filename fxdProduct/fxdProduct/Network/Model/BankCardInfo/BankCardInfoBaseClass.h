//
//  BankCardInfoBaseClass.h
//
//  Created by dd  on 15/12/28
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BankCardInfoResult.h"
#import "BankCardInfoBaseClass.h"

@class BankCardInfoResult;

@interface BankCardInfoBaseClass : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) BankCardInfoResult *result;
@property (nonatomic, strong) NSString *flag;
@property (nonatomic, strong) NSString *msg;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
