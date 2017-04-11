//
//  BankCardInfoResult.h
//
//  Created by dd  on 15/12/28
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BankCardInfoResult : NSObject <NSCoding, NSCopying>


@property (nonatomic, strong) NSString *bankNo;
@property (nonatomic, strong) NSString *creditBankNo;
@property (nonatomic, assign) double resultIdentifier;
@property (nonatomic, strong) NSString *debitBankName;
@property (nonatomic, strong) NSString *debitCardNo;
@property (nonatomic, strong) NSString *creditBankName;
@property (nonatomic, strong) NSString *creditCardNo;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
