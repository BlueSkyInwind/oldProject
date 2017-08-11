//
//  P2PContactContentModel.h
//  fxdProduct
//
//  Created by admin on 2017/7/5.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface P2PContactContentModel : JSONModel

@property (nonatomic, strong)NSNumber<Optional> * success;
@property (nonatomic, strong)NSNumber<Optional> * appcode;
@property (nonatomic, strong)NSString<Optional> * content;

@end
