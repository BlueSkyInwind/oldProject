//
//  RepayMentAvailableRedpackets.h
//
//  Created by dd  on 16/5/25
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface RepayMentAvailableRedpackets : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *validityPeriodTo;
@property (nonatomic, strong) NSString *createDate;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *source;
@property (nonatomic, strong) NSString *accountBaseId;
@property (nonatomic, strong) NSString *availableRedpacketsIdentifier;
@property (nonatomic, strong) NSString *createBy;
@property (nonatomic, strong) NSString *validityPeriodFrom;
@property (nonatomic, assign) double residualAmount;
@property (nonatomic, strong) NSString *useConditions;
@property (nonatomic, strong) NSString *isSplitUse;
@property (nonatomic, assign) double usedAmount;
@property (nonatomic, assign) double totalAmount;
@property (nonatomic, strong) NSString *redpacketName;
@property (nonatomic, assign) double isUsing;
@property (nonatomic, strong) NSString *availableMeans;
@property (nonatomic, strong) NSString *getDate;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
