//
//  LivenessSelfie.h
//
//  Created by dd  on 16/3/31
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface LivenessSelfie : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *imageId;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
