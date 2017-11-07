//
//  LoanDoFindBaseClass.h
//
//  Created by   on 15/10/29
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoanDoFindResult.h"
#import "LoanDoFindBaseClass.h"

@class LoanDoFindResult;

@interface LoanDoFindBaseClass : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) LoanDoFindResult *result;
@property (nonatomic, strong) NSString *flag;
@property (nonatomic, strong) NSString *msg;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
