//
//  GetCustomerBaseViewModel.h
//  fxdProduct
//
//  Created by dd on 16/4/12.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "ViewModelClass.h"

@interface GetCustomerBaseViewModel : ViewModelClass

- (void)fatchCustomBaseInfo:(NSDictionary *)paramDic;

- (void)fatchCustomBaseInfoNoHud:(NSDictionary *)paramDic;

@end
