//
//  ReturnMsgBaseClass.h
//
//  Created by dd  on 15/9/28
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReturnMsgBaseClass.h"


@interface ReturnMsgBaseClass : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *result;
@property (nonatomic, strong) NSString *flag;
@property (nonatomic, strong) NSString *msg;
@property (nonatomic, strong) NSString *ext;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
