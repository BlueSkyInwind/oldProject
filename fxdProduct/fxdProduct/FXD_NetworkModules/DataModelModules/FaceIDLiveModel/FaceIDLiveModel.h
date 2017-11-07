//
//  FaceIDLiveModel.h
//  fxdProduct
//
//  Created by dd on 2017/2/24.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Id_exceptions,Result_faceid,Face_genuineness,Thresholds;

@interface FaceIDLiveModel : NSObject

@property (nonatomic , copy) NSString               * error_message;
@property (nonatomic , assign) NSInteger              time_used;
@property (nonatomic , strong) Id_exceptions        * id_exceptions;
@property (nonatomic , copy) NSString               * request_id;
@property (nonatomic , strong) Result_faceid        * result_faceid;
@property (nonatomic , strong) Face_genuineness     * face_genuineness;

@end

@interface Id_exceptions : NSObject

@property (nonatomic , assign) NSInteger              id_photo_monochrome;
@property (nonatomic , assign) NSInteger              id_attacked;

@end

@interface Result_faceid : NSObject

@property (nonatomic , assign) CGFloat              confidence;
@property (nonatomic , strong) Thresholds         * thresholds;

@end

@interface Face_genuineness : NSObject

@property (nonatomic , assign) NSInteger            screen_replay_confidence;
@property (nonatomic , assign) CGFloat              mask_threshold;
@property (nonatomic , assign) CGFloat              synthetic_face_threshold;
@property (nonatomic , assign) NSInteger            synthetic_face_confidence;
@property (nonatomic , assign) NSInteger            mask_confidence;
@property (nonatomic , assign) CGFloat              screen_replay_threshold;

@end

@interface Thresholds : NSObject

@property (nonatomic , assign) CGFloat              e3;
@property (nonatomic , assign) CGFloat              e6;
@property (nonatomic , assign) CGFloat              e4;
@property (nonatomic , assign) CGFloat              e5;

@end
