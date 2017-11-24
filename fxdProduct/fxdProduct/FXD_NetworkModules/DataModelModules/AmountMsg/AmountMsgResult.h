//
//  AmountMsgResult.h
//
//  Created by dd  on 15/10/30
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface AmountMsgResult : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *typeStatus;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
