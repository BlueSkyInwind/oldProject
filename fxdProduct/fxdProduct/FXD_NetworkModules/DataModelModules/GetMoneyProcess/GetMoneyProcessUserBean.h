//
//  GetMoneyProcessUserBean.h
//
//  Created by dd  on 15/11/9
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface GetMoneyProcessUserBean : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *debitBankName;
@property (nonatomic, assign) double userBeanIdentifier;
@property (nonatomic, strong) NSString *bankNo;
@property (nonatomic, strong) NSString *debitCardNo;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
