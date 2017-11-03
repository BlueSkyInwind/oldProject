//
//  FaceIDOCRBack.h
//  fxdProduct
//
//  Created by dd on 2017/2/23.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FaceIDOCRBackLegality;

@interface FaceIDOCRBack : NSObject

@property (nonatomic , copy) NSString              * issued_by;
@property (nonatomic , assign) NSInteger              time_used;
@property (nonatomic , copy) NSString              * request_id;
@property (nonatomic , copy) NSString              * valid_date;
@property (nonatomic , strong) FaceIDOCRBackLegality   * legality;
@property (nonatomic , copy) NSString              * side;

@end

@interface FaceIDOCRBackLegality : NSObject

@property (nonatomic , assign) CGFloat              edited;
@property (nonatomic , assign) NSInteger              photocopy;
@property (nonatomic , assign) CGFloat              screen;
@property (nonatomic , assign) NSInteger              temporary_ID_Photo;
@property (nonatomic , assign) CGFloat              iD_Photo;

@end
