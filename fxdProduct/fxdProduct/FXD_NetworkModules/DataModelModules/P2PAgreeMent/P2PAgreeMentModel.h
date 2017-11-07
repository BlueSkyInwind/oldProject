//
//  P2PAgreeMentModel.h
//  fxdProduct
//
//  Created by dd on 2016/12/2.
//  Copyright © 2016年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>
@class P2PAgreeMentModelData,Pact;

@interface P2PAgreeMentModel : NSObject

@property (nonatomic, copy)NSString *appcode;

@property (nonatomic, assign)BOOL success;

@property (nonatomic, strong)P2PAgreeMentModelData *result;

@end


@interface P2PAgreeMentModelData : NSObject

@property (nonatomic, copy)NSString *appcode;

@property (nonatomic, strong) NSArray<Pact*> *pactList;

@end

@interface Pact : NSObject

@property (nonatomic, copy)NSString *bid_id_;

@property (nonatomic, copy)NSString *id_;

@property (nonatomic, copy)NSString *name_;

@property (nonatomic, copy)NSString *status_;

@property (nonatomic, copy)NSString *debt_id_;

@end
