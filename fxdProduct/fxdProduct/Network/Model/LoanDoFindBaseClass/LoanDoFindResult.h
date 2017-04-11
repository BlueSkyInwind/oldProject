//
//  LoanDoFindResult.h
//
//  Created by   on 15/10/29
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface LoanDoFindResult : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *createDat;
@property (nonatomic, assign) double resultIdentifier;
@property (nonatomic, strong) NSString *status;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
