//
//  UserInfoCell.h
//  fxdProduct
//
//  Created by dd on 16/1/22.
//  Copyright © 2016年 dd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomerBaseInfoBaseClass.h"
#import "CustomerCareerBaseClass.h"

@interface UserInfoCell : UITableViewCell

@property (nonatomic, strong) UIButton *basicEditBtn;
@property (nonatomic, strong) UIButton *professEditBtn;
//@property (nonatomic, strong) CustomerBaseInfoBaseClass *customerBaseClass;
//@property (nonatomic, strong) CustomerCareerBaseClass *carrerInfoModel;

-(void)CustomBaseinfoModel:(CustomerBaseInfoBaseClass *)_customerBaseClass andcustomCareerBaseModel:(CustomerCareerBaseClass *)_carrerInfoModel;
@end
