//
//  CashResult.h
//
//  Created by dd  on 15/10/20
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface CashResult : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double amount;
@property (nonatomic, assign) double resultIdentifier;
@property (nonatomic, strong) NSString *vouchersStatus;
@property (nonatomic, strong) NSString *voucherType;
@property (nonatomic, strong) NSString *grantEndDate;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
