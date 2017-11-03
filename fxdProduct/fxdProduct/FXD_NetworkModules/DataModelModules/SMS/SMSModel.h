//
//  SMSModel.h
//  fxdProduct
//
//  Created by admin on 2017/5/23.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SMSModel : JSONModel

@property (strong, nonatomic)NSString * mobile_phone_;
@property (strong, nonatomic)NSString * flag;
@property (strong, nonatomic)NSString<Optional> * pic_verify_id_;
@property (strong, nonatomic)NSString<Optional> * pic_verify_code_;



@end
