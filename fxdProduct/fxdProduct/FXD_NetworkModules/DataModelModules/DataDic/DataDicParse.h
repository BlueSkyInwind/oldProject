//
//  DataDicParse.h
//  fxdProduct
//
//  Created by dd on 2017/3/8.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DataDicResult,DataDicExt;

@interface DataDicParse : NSObject

@property (nonatomic , copy) NSString              * flag;
@property (nonatomic , strong) DataDicExt              * ext;
@property (nonatomic , strong) NSArray<DataDicResult *>              * result;
@property (nonatomic , copy) NSString              * msg;


@end


@interface DataDicResult :NSObject
@property (nonatomic , copy) NSString              * desc_;
@property (nonatomic , copy) NSString              * id_;
@property (nonatomic , copy) NSString              * dic_index_id_;
@property (nonatomic , copy) NSString              * status_;
@property (nonatomic , copy) NSString              * code_;

@end

@interface DataDicExt :NSObject
@property (nonatomic , copy) NSString              * mobile_phone_;

@end
