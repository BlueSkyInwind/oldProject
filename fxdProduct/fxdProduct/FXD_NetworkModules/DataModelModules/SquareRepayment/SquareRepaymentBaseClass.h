//
//  SquareRepaymentBaseClass.h
//
//  Created by dd  on 16/5/25
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SquareRepaymentResult.h"
#import "SquareRepaymentExt.h"
#import "SquareRepaymentAvailableRedpackets.h"
#import "SquareRepaymentBaseClass.h"

@class SquareRepaymentExt, SquareRepaymentResult;

@interface SquareRepaymentBaseClass : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *flag;
@property (nonatomic, strong) SquareRepaymentExt *ext;
@property (nonatomic, strong) SquareRepaymentResult *result;
@property (nonatomic, strong) NSString *msg;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
