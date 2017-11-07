//
//  UIApplication+Extend.h
//  Lunch
//
//  Created by dd on 16/3/15.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "UIApplication+Extend.h"

@implementation UIApplication (Extend)


/*
 *  当前程序的版本号
 */
-(NSString *)version{
    
    //系统直接读取的版本号
    NSString *versionValueStringForSystemNow=[[NSBundle mainBundle].infoDictionary valueForKey:(NSString *)kCFBundleVersionKey];
    
    return versionValueStringForSystemNow;
}



@end
