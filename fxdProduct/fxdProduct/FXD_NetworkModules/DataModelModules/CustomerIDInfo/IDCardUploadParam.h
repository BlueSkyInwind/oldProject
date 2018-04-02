//
//  IDCardUploadParam.h
//  fxdProduct
//
//  Created by admin on 2018/3/28.
//  Copyright © 2018年 dd. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface IDCardUploadParam : JSONModel

@property (nonatomic , strong) NSString<Optional>  *idCardSelf;

@property (nonatomic , strong) NSString<Optional>   *side;  //front/back

@property (nonatomic , strong) NSString<Optional>   *suffix;


@end
