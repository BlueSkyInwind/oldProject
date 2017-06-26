//
//  QryUserStatusParamModel.h
//  fxdProduct
//
//  Created by sxp on 17/6/2.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface QryUserStatusParamModel : JSONModel

@property (nonatomic,copy)NSString *case_id_;
@property (nonatomic,copy)NSString *client_;
@property (nonatomic,copy)NSString *description_;
@property (nonatomic,copy)NSString *period_;
@property (nonatomic,copy)NSString *type_;

@end
