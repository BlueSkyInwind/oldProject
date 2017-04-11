//
//  FaceIDOCRFront.h
//  fxdProduct
//
//  Created by dd on 2017/2/23.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HeadRect,Birthday,Lt,Lb,Rt,Rb,FaceIDOCRFrontLegality;


@interface FaceIDOCRFront : NSObject

@property (nonatomic , copy) NSString              * address;
@property (nonatomic , copy) NSString              * gender;
@property (nonatomic , assign) CGFloat              time_used;
@property (nonatomic , strong) HeadRect              * head_rect;
@property (nonatomic , copy) NSString              * request_id;
@property (nonatomic , strong) Birthday              * birthday;
@property (nonatomic , copy) NSString              * id_card_number;
@property (nonatomic , copy) NSString              * side;
@property (nonatomic , copy) NSString              * race;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic, strong) FaceIDOCRFrontLegality              *legality;

@end

@interface FaceIDOCRFrontLegality :NSObject
@property (nonatomic , assign) NSInteger              edited;
@property (nonatomic , assign) NSInteger              photocopy;
@property (nonatomic , assign) NSInteger              screen;
@property (nonatomic , assign) NSInteger              temporary_ID_Photo;
@property (nonatomic , assign) NSInteger              iD_Photo;

@end

@interface HeadRect: NSObject

@property (nonatomic , strong) Lt              * lt;
@property (nonatomic , strong) Lb              * lb;
@property (nonatomic , strong) Rt              * rt;
@property (nonatomic , strong) Rb              * rb;

@end

@interface Birthday: NSObject

@property (nonatomic , copy) NSString              * year;
@property (nonatomic , copy) NSString              * day;
@property (nonatomic , copy) NSString              * month;

@end

@interface Lt :NSObject
@property (nonatomic , assign) CGFloat              y;
@property (nonatomic , assign) CGFloat              x;

@end

@interface Lb :NSObject
@property (nonatomic , assign) CGFloat              y;
@property (nonatomic , assign) CGFloat              x;

@end

@interface Rt :NSObject
@property (nonatomic , assign) CGFloat              y;
@property (nonatomic , assign) CGFloat              x;

@end

@interface Rb :NSObject
@property (nonatomic , assign) CGFloat              y;
@property (nonatomic , assign) CGFloat              x;

@end

/*
 request_id	String	用于区分每一次请求的唯一的字符串。
 time_used	Float	整个请求所花费的时间，单位为毫秒。
 address string 住址
 birthday dict 生日，下分年月日，都是一个字符串
 gender tring 性别（男/女）
 
 id_card_number string 身份证号
 
 name string 姓名
 
 race string 民族（汉字）
 
 side string front/back 表示身份证的正面或者反面（illegal）
 
 issued_by string 签发机关
 
 valid_date string 有效日期，格式为一个16位长度的字符串，表示内容如下YYYY.MM.DD-YYYY.MM.DD，或是YYYY.MM.DD-长期。
 
 head_rect dict 身份证中人脸框的位置，分别包含左上、右上、右下、左下四个角点。可能会超过图本身。
 
 legality 如果用户调用时设置可选参数legality为“1”，则返回身份证照片的合法性检查结果，否则不返回该字段。结果为五种分类的概率值（取［0，1］区间实数，取3位有效数字，总和等于1.0），返回结果样例见2.1.4。五种分类为：
 
 ID Photo （正式身份证照片）
 
 Temporary ID Photo  （临时身份证照片）
 
 Photocopy （正式身份证的复印件）
 
 Screen （手机或电脑屏幕翻拍的照片）
 
 Edited （用工具合成或者编辑过的身份证图片）
 */



