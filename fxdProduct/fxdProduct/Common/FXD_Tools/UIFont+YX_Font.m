//
//  UIFont+YX_Font.m
//  fxdProduct
//
//  Created by admin on 2017/11/21.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "UIFont+YX_Font.h"



#ifdef UI_IS_IPHONE6
#define fontScale 1.0
#elif UI_IS_IPHONE5
#define fontScale 0.8
#elif UI_IS_IPHONE6P
#define fontScale 1.2
#elif UI_IS_IPHONEX
#define fontScale 1.2
#else
#define fontScale 0.7
#endif
#define displayFontSize(fontSize) fontSize * fontScale

@implementation NSObject (Extension)

+ (void)swizzleClassSelector:(SEL)originalSelector withSwizzledClassSelector:(SEL)swizzledSelector
{
    Method originalMethod = class_getClassMethod(self, originalSelector);
    Method swizzledMethod = class_getClassMethod(self, swizzledSelector);
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

@end

@implementation UIFont (YX_Font)
+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleClassSelector:@selector(systemFontOfSize:) withSwizzledClassSelector:@selector(yx_systemFontOfSize:)];
        [self swizzleClassSelector:@selector(systemFontOfSize:weight:) withSwizzledClassSelector:@selector(yx_systemFontOfSize:weight:)];
        [self swizzleClassSelector:@selector(boldSystemFontOfSize:) withSwizzledClassSelector:@selector(yx_boldSystemFontOfSize:)];
        [self swizzleClassSelector:@selector(italicSystemFontOfSize:) withSwizzledClassSelector:@selector(yx_italicSystemFontOfSize:)];
        [self swizzleClassSelector:@selector(fontWithName:size:) withSwizzledClassSelector:@selector(yx_fontWithName:size:)];
    });
}

+ (UIFont *)yx_systemFontOfSize:(CGFloat)fontSize
{
    return [self yx_systemFontOfSize:displayFontSize(fontSize)];
}

+ (UIFont *)yx_systemFontOfSize:(CGFloat)fontSize weight:(CGFloat)weight
{
    return [self yx_systemFontOfSize:displayFontSize(fontSize) weight:weight];
}

+ (UIFont *)yx_boldSystemFontOfSize:(CGFloat)fontSize
{
    return [self yx_boldSystemFontOfSize:displayFontSize(fontSize)];
}

+ (UIFont *)yx_italicSystemFontOfSize:(CGFloat)fontSize
{
    return [self yx_italicSystemFontOfSize:displayFontSize(fontSize)];
}

+ (nullable UIFont *)yx_fontWithName:(NSString *)fontName size:(CGFloat)fontSize
{
    return [self yx_fontWithName:fontName size:displayFontSize(fontSize)];
}

@end
