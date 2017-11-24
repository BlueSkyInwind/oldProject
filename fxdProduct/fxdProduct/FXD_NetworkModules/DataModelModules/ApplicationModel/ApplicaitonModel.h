//
//  ApplicaitonModel.h
//  fxdProduct
//
//  Created by admin on 2017/9/1.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface ApplicaitonModel : JSONModel




@end




@interface ApplicaitonViewInfoModel : JSONModel

@property(nonatomic,strong)NSArray<Optional> * detail;
@property(nonatomic,strong)NSString<Optional> * icon;
@property(nonatomic,strong)NSString<Optional> * period;
@property(nonatomic,strong)NSString<Optional> * productName;
@property(nonatomic,strong)NSArray<Optional> * special;
@property(nonatomic,strong)NSString<Optional> * amount;

@end
