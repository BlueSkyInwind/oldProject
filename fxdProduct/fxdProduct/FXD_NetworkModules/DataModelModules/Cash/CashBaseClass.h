//
//  CashBaseClass.h
//
//  Created by dd  on 15/10/20
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CashResult.h"
#import "CashBaseClass.h"


@interface CashBaseClass : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *result;
@property (nonatomic, strong) NSString *flag;
@property (nonatomic, strong) NSString *msg;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
