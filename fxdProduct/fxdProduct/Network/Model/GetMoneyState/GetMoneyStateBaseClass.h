//
//  GetMoneyStateBaseClass.h
//
//  Created by dd  on 15/10/28
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GetMoneyStateResult.h"
#import "GetMoneyStateUserBean.h"
#import "GetMoneyStateBaseClass.h"

@class GetMoneyStateResult;

@interface GetMoneyStateBaseClass : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) GetMoneyStateResult *result;
@property (nonatomic, strong) NSString *flag;
@property (nonatomic, strong) NSString *msg;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
