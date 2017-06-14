//
//  QueryUserBidStatusParamModel.h
//  fxdProduct
//
//  Created by sxp on 17/6/14.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface QueryUserBidStatusParamModel : JSONModel

/*来源*/
@property (nonatomic,copy)NSString *form_;
/*来源进件id*/
@property (nonatomic,copy)NSString *from_case_id_;

@end
