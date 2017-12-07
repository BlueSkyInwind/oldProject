//
//  RegionCodeResult.h
//
//  Created by dd  on 16/4/12
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegionCodeResult : JSONModel

@property (nonatomic, strong)NSString<Optional> *provinceCode;
@property (nonatomic, strong)NSString<Optional>  *cityCode;
@property (nonatomic, strong)NSString<Optional> *districtCode;


@end
