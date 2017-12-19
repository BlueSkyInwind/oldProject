//
//  ReconfrInfoModel.h
//  fxdProduct
//
//  Created by dd on 2017/3/2.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface ReconfrList : JSONModel

@property (nonatomic, strong) NSString<Optional> *id_;

@property (nonatomic, copy) NSString<Optional> *product_id_;

@property (nonatomic, copy) NSString<Optional> *protocol_content_;

@property (nonatomic, copy) NSString<Optional> *protocol_type_;

@end
