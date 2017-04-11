//
//  ContactProtocol.h
//  fxdProduct
//
//  Created by dd on 2017/2/20.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ContactProtocol <NSObject>

@required

-(void)GetContactName:(NSString *)name TelPhone:(NSString *)telph andFlagTure:(NSInteger )flagInteger;

@end

//@interface ContactProtocol : NSObject
//
//@end
