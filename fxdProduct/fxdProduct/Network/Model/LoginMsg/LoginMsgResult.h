//
//  LoginMsgResult.h
//
//  Created by dd  on 16/3/23
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface LoginMsgResult : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *juid;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
