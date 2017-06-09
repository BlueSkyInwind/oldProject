//
//  Utility.m
//  fxdProduct
//
//  Created by dd on 15/9/25.
//  Copyright © 2015年 dd. All rights reserved.
//

#import "Utility.h"

@implementation Utility

@synthesize userInfo;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.userInfo = [[UserInfoObj alloc] init];
        self.getMineyInfo = [[GetMoneyInfo alloc] init];
        self.rateParse = [[RateModel alloc]init];

    }
    return self;
}

+ (Utility *)sharedUtility
{
    static Utility *sharedUtilityInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedUtilityInstance = [[self alloc] init];
    });
    return sharedUtilityInstance;
}



@end
