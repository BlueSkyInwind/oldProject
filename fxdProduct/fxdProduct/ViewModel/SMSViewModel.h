//
//  SMSViewModel.h
//  fxdProduct
//
//  Created by dd on 15/12/28.
//  Copyright © 2015年 dd. All rights reserved.
//

#import "ViewModelClass.h"
#import "ReturnMsgBaseClass.h"

@interface SMSViewModel : ViewModelClass

- (void)fatchRequestSMS:(NSDictionary *)paramDic;

@end
