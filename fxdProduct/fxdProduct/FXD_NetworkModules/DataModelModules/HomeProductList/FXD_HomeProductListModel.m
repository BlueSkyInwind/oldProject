//
//  FXD_HomeProductListModel.m
//  fxdProduct
//
//  Created by sxp on 2017/12/25.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "FXD_HomeProductListModel.h"

@implementation FXD_HomeProductListModel

@end

@implementation BannerListModel

@end

@implementation DrawInfoModel

@end

@implementation HandingAndFailModel

@end

@implementation OverdueInfoModel

@end

@implementation PopListModel

@end

@implementation RedCollarListModel

@end

@implementation RepayInfoModel

@end

@implementation TestFailInfoModel

@end

@implementation ThirdProductListModel

+(JSONKeyMapper *)keyMapper{
    
    return [[JSONKeyMapper alloc]initWithModelToJSONDictionary:@{@"id_":@"id"}];
}
@end

@implementation ExtAttrModel

@end

//@implementation RuleTextModel
//
//+(JSONKeyMapper *)keyMapper{
//    
//    return [[JSONKeyMapper alloc]initWithModelToJSONDictionary:@{@"label_":@"label",@"value_":@"value"}];
//}
//
//@end

@implementation FeeTextModel

@end


