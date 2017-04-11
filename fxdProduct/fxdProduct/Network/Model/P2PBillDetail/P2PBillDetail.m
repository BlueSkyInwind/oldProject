//
//  P2PBillDetail.m
//  fxdProduct
//
//  Created by dd on 2016/12/19.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "P2PBillDetail.h"

@implementation P2PBillDetail

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data":[BillData class]};
}

@end

@implementation BillData

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"bill_List_":[BillList class]};
}

@end


@implementation BillList



@end
