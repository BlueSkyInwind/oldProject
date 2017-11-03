//
//  LivenessBaseClass.h
//
//  Created by dd  on 16/3/31
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LivenessSelfie.h"
#import "LivenessIdentity.h"
#import "LivenessBaseClass.h"

@class LivenessIdentity, LivenessSelfie;

@interface LivenessBaseClass : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) LivenessIdentity *identity;
@property (nonatomic, strong) LivenessSelfie *selfie;
@property (nonatomic, strong) NSString *requestId;
@property (nonatomic, assign) double confidence;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
