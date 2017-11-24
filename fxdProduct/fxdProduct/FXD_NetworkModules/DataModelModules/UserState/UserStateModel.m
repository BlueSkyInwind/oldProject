//
//  UserStateModel.m
//  fxdProduct
//
//  Created by zy on 16/3/25.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "UserStateModel.h"

@implementation UserStateModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key  {
    if([key isEqualToString:@"id"])
        self.productId = value;
}

+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{@"productId":@"id",
             @"applyStatus":@"apply_status_",
             @"modifyDate":@"modify_date_",
             @"validStatus":@"valid_status_",
             @"applyFlag":@"apply_flag_",
             @"applyAgain":@"apply_again_",
             @"applyID":@"apply_id_",
             @"taskStatus":@"task_status_",
             @"platform_type":@"platform_type_",
             @"qq_status":@"qq_status_",
             @"zfb_status":@"zfb_status_",
             @"if_add_documents":@"if_add_documents_",
             @"product_id":@"product_id_",
             @"case_info_id":@"case_info_id_",
             
            };
}

@end
