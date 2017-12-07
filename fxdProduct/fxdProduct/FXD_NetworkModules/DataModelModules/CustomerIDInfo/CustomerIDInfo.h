//
//  CustomerIDInfo.h
//  fxdProduct
//
//  Created by dd on 2017/3/2.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomerIDInfo : JSONModel

@property (nonatomic , strong) NSString<Optional>  *customer_name_;

@property (nonatomic , strong) NSString<Optional>   *editable_field_;

@property (nonatomic , strong) NSString<Optional>   *id_code_;

@end

@interface CustomerIDInfoParam : JSONModel

@property (nonatomic , copy) NSString<Optional>   *idCardSelf;

@property (nonatomic , copy) NSString<Optional>   *records;

@property (nonatomic , copy) NSString<Optional>   *side;

@end




