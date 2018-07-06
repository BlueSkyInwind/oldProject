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


@interface LoginSyncParse : JSONModel

@property (nonatomic, strong)NSString<Optional> *channel;
@property (nonatomic, strong)NSString<Optional> *juid;
@property (nonatomic, strong)NSString<Optional> *platformType;
@property (nonatomic, strong)NSString<Optional> *version;

@end
