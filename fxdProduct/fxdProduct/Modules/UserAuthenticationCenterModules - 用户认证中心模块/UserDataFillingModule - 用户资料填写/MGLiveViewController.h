//
//  MGLiveViewController.h
//  fxdProduct
//
//  Created by dd on 2017/3/9.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MGLivenessDetection/MGLivenessDetection.h>
@class FaceIDData;

@protocol LiveDeteDelgate <NSObject>
@required

- (void)liveDateSuccess:(FaceIDData *)faceIDData;

- (void)liveDateFaile:(MGLivenessDetectionFailedType)errorType;

@end

@interface MGLiveViewController : MGLiveDetectViewController

@property (nonatomic, weak) id <LiveDeteDelgate>delagate;

@end
