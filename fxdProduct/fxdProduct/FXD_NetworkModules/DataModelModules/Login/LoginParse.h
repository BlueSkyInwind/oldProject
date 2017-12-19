//
//  LoginParse.h
//  fxdProduct
//
//  Created by dd on 2017/2/9.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface LoginParse : JSONModel

@property (nonatomic ,copy) NSString *juid;
@property (nonatomic ,copy) NSString *user_id_;
@property (nonatomic, copy) NSString *invitation_code;

@end
 
