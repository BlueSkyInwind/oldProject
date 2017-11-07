//
//  GetMoneyHistoryBaseClass.h
//
//  Created by dd  on 15/12/18
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GetMoneyHistoryResult.h"
#import "GetMoneyHistoryBaseClass.h"



@interface GetMoneyHistoryBaseClass : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *result;
@property (nonatomic, strong) NSString *flag;
@property (nonatomic, strong) NSString *msg;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end


/*
 {
 "result": [
 {
 "createDate": "2015-12-1811: 51: 59",
 "id": 41001681,
 "loanAmount": 0,
 "applyAmount": 1500,
 "interest": 0,
 "periods": 30,
 "status": "1081",
 "submitDate": "2015-12-1811: 25: 38"
 }
 ],
 "flag": "0000",
 "msg": "查询成功"
 }
 */