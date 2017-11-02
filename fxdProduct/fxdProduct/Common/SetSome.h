//
//  SetSome.h
//  fxdProduct
//
//  Created by dd on 15/9/8.
//  Copyright (c) 2015年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SetSome : NSObject
+ (SetSome *)shared;

-(void)InitializeAppSet;
@end
