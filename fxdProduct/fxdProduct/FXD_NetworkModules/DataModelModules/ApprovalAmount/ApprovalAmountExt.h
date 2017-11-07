//
//  ApprovalAmountExt.h
//
//  Created by dd  on 16/3/30
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ApprovalAmountExt : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *mobilePhone;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
