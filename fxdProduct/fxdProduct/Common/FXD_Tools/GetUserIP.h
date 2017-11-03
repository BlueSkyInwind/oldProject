//
//  GetUserIP.h
//  fxdProduct
//
//  Created by dd on 15/11/10.
//  Copyright © 2015年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetUserIP : NSObject

+ (GetUserIP *)sharedUserIP;

- (NSString *)getIPAddress;
@end
