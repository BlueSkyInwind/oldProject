//
//  ApprovalAmountBaseClass.h
//
//  Created by dd  on 16/3/30
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ApprovalAmountExt.h"
#import "ApprovalAmountResult.h"
#import "ApprovalAmountBaseClass.h"

@class ApprovalAmountExt, ApprovalAmountResult;

@interface ApprovalAmountBaseClass : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *flag;
@property (nonatomic, strong) ApprovalAmountExt *ext;
@property (nonatomic, strong) ApprovalAmountResult *result;
@property (nonatomic, strong) NSString *msg;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
