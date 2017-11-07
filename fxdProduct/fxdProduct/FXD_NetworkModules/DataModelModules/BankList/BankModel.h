//
//  BankModel.h
//  fxdProduct
//
//  Created by dd on 7/11/16.
//  Copyright © 2016 dd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BankList.h"

@interface BankModel : NSObject

@property (nonatomic, strong)NSMutableArray *result;
@property (nonatomic, copy)NSString *flag;
@property (nonatomic, copy)NSString *msg;

@end
