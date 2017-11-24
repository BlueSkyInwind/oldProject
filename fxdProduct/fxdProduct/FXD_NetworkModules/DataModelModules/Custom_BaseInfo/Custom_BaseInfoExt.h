//
//  Ext.h
//
//  Created by dd  on 2017/3/1
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Custom_BaseInfoExt : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *mobilePhone;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
