//
//  HomePop.h
//  fxdProduct
//
//  Created by dd on 2016/11/30.
//  Copyright © 2016年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HomePopResult,PicFileInfo;

@interface HomePop : NSObject

@property (nonatomic, copy) NSString *flag;

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, strong) HomePopResult *result;

@end


@interface HomePopResult : NSObject

@property (nonatomic, copy) NSString *title_;

@property (nonatomic, copy) NSString *appcode;

@property (nonatomic, copy) NSString *content_;

@property (nonatomic, copy) NSString *position_;

@property (nonatomic, copy) NSString *is_valid_;

@property (nonatomic, copy) NSString *type_;

@property (nonatomic, assign) BOOL success;

@property (nonatomic, retain) NSArray<PicFileInfo*>* files_;

@end

@interface PicFileInfo : NSObject

@property (nonatomic, copy) NSString *file_store_path_;

@property (nonatomic, copy) NSString *link_url_;

@end
