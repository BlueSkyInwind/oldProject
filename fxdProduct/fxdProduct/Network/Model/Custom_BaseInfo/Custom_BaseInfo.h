//
//  Custom_BaseInfo.h
//
//  Created by dd  on 2017/3/1
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Custom_BaseInfoResult.h"
#import "Custom_BaseInfoExt.h"
#import "ContactBean.h"
#import "Custom_BaseInfo.h"

@class Custom_BaseInfoExt, Custom_BaseInfoResult;

@interface Custom_BaseInfo : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *flag;
@property (nonatomic, strong) Custom_BaseInfoExt *ext;
@property (nonatomic, strong) Custom_BaseInfoResult *result;
@property (nonatomic, strong) NSString *msg;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
