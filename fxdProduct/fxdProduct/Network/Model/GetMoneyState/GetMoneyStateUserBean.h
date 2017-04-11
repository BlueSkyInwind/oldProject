//
//  GetMoneyStateUserBean.h
//
//  Created by dd  on 15/10/28
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface GetMoneyStateUserBean : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double userBeanIdentifier;
@property (nonatomic, strong) NSString *debitBankName;
@property (nonatomic, strong) NSString *debitCardNo;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
