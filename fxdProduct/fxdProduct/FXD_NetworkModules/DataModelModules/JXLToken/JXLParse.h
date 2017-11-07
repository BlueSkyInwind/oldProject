//
//  JXLParse.h
//  fxdProduct
//
//  Created by dd on 2017/2/25.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JXLData,KXLDataSource,Update_time,Create_time;

@interface JXLParse : NSObject

@property (nonatomic , assign) BOOL              success;
@property (nonatomic , strong) JXLData              * data;

@end


@interface JXLData :NSObject
@property (nonatomic , copy) NSString              * token;
@property (nonatomic , strong) KXLDataSource       * datasource;
@property (nonatomic , copy) NSString              * cell_phone_num;

@end

@interface KXLDataSource :NSObject
@property (nonatomic , copy) NSString              * dataId;
@property (nonatomic , copy) NSString              * category;
@property (nonatomic , strong) Update_time              * update_time;
@property (nonatomic , assign) NSInteger              reset_pwd_method;
@property (nonatomic , assign) NSInteger              sms_required;
@property (nonatomic , assign) NSInteger              required_captcha_user_identified;
@property (nonatomic , assign) NSInteger              offline_times;
@property (nonatomic , assign) NSInteger              reset_pwd_frozen_time;
@property (nonatomic , copy) NSString              * category_name;
@property (nonatomic , assign) NSInteger              website_code;
@property (nonatomic , copy) NSString              * website;
@property (nonatomic , strong) Create_time              * create_time;
@property (nonatomic , assign) NSInteger              status;
@property (nonatomic , copy) NSString              * name;

@end

@interface Create_time :NSObject
@property (nonatomic , assign) NSInteger              dayOfMonth;
@property (nonatomic , assign) NSInteger              month;
@property (nonatomic , assign) NSInteger              hourOfDay;
@property (nonatomic , assign) NSInteger              minute;
@property (nonatomic , assign) NSInteger              year;
@property (nonatomic , assign) NSInteger              second;

@end

@interface Update_time :NSObject
@property (nonatomic , assign) NSInteger              dayOfMonth;
@property (nonatomic , assign) NSInteger              month;
@property (nonatomic , assign) NSInteger              hourOfDay;
@property (nonatomic , assign) NSInteger              minute;
@property (nonatomic , assign) NSInteger              year;
@property (nonatomic , assign) NSInteger              second;

@end




