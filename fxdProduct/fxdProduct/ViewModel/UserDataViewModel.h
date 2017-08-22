//
//  UserDataViewModel.h
//  fxdProduct
//
//  Created by admin on 2017/8/22.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewModelClass.h"

@interface UserDataViewModel : ViewModelClass

//上传活体认证信息
-(void)uploadLiveIdentiInfo:(FaceIDData *)imagesDic;

@end
