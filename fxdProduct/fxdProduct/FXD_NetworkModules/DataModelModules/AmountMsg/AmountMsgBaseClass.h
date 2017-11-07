//
//  AmountMsgBaseClass.h
//
//  Created by dd  on 15/10/30
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AmountMsgResult.h"
#import "AmountMsgBaseClass.h"

@class AmountMsgResult;

@interface AmountMsgBaseClass : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) AmountMsgResult *result;
@property (nonatomic, strong) NSString *flag;
@property (nonatomic, strong) NSString *msg;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
