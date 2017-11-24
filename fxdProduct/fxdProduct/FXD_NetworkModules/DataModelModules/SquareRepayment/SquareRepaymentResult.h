//
//  SquareRepaymentResult.h
//
//  Created by dd  on 16/5/25
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface SquareRepaymentResult : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *availableRedpackets;
@property (nonatomic, strong) NSString *totalAmount;
@property (nonatomic, strong) NSString *reapyInterest;
@property (nonatomic, strong) NSString *settleAmount;
@property (nonatomic, strong) NSString *socket;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
