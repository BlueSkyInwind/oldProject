//
//  SendSmsModel.h
//  fxdProduct
//
//  Created by sxp on 17/5/22.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SendSmsDataModel;
@interface SendSmsModel : NSObject

//结果对照码   1发送成功 -1发送失败
@property (nonatomic,copy)NSString *appcode;
//结果描述
@property (nonatomic,copy)NSString *appmsg;
//短信序列号
@property (nonatomic,strong)SendSmsDataModel *data;

@end

@interface SendSmsDataModel : NSObject

//结果对照码   1发送成功 -1发送失败
@property (nonatomic,copy)NSString *appcode;
//结果描述
@property (nonatomic,copy)NSString *appmsg;
//短信序列号
@property (nonatomic,copy)NSString *sms_seq_;

@end
