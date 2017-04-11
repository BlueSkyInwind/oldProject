//
//  ReconfrInfoModel.h
//  fxdProduct
//
//  Created by dd on 2017/3/2.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ReconfrInfoModelResult,ReconfrList;

@interface ReconfrInfoModel : NSObject

@property (nonatomic, copy) NSString *flag;

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, strong) ReconfrInfoModelResult *result;

@end

@interface ReconfrInfoModelResult : NSObject

@property (nonatomic, strong) NSArray <ReconfrList*> *list;

@end

@interface ReconfrList : NSObject

@property (nonatomic, copy) NSString *id_;

@property (nonatomic, copy) NSString *product_id_;

@property (nonatomic, copy) NSString *protocol_content_;

@property (nonatomic, copy) NSString *protocol_type_;

@end
