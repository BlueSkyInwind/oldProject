//
//  HomeBannerModel.h
//  fxdProduct
//
//  Created by dd on 2017/3/3.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HomeBannerResult,HomeBannerFiles;

@interface HomeBannerModel : NSObject

@property (nonatomic , copy) NSString              * flag;
@property (nonatomic , strong) HomeBannerResult              * result;
@property (nonatomic , copy) NSString              * msg;

@end


@interface HomeBannerResult :NSObject
@property (nonatomic , copy) NSString              * title_;
@property (nonatomic , assign) NSInteger              appcode;
@property (nonatomic , copy) NSString              * content_;
@property (nonatomic , strong) NSArray<HomeBannerFiles *> * files_;
@property (nonatomic , copy) NSString              * position_;
@property (nonatomic , copy) NSString              * is_valid_;
@property (nonatomic , copy) NSString              * type_;
@property (nonatomic , assign) BOOL              success;

@end

@interface HomeBannerFiles :NSObject
@property (nonatomic , copy) NSString              * file_store_path_;
@property (nonatomic , copy) NSString              * link_url_;

@end
