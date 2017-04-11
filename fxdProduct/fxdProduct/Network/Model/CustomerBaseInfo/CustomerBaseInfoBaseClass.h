//
//  CustomerBaseInfoBaseClass.h
//
//  Created by dd  on 16/4/11
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomerBaseInfoResult.h"
#import "CustomerBaseInfoExt.h"
#import "CustomerBaseInfoContactBean.h"
#import "CustomerBaseInfoBaseClass.h"

@class CustomerBaseInfoExt, CustomerBaseInfoResult;

@interface CustomerBaseInfoBaseClass : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *flag;
@property (nonatomic, strong) CustomerBaseInfoExt *ext;
@property (nonatomic, strong) CustomerBaseInfoResult *result;
@property (nonatomic, strong) NSString *msg;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
