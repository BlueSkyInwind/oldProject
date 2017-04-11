//
//  UserInfoCell.m
//  fxdProduct
//
//  Created by dd on 16/1/22.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "UserInfoCell.h"


@implementation UserInfoCell


- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    [super awakeFromNib];
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
//        [self createCellUI];
    }
    return self;
}

- (void)CustomBaseinfoModel:(CustomerBaseInfoBaseClass *)_customerBaseClass andcustomCareerBaseModel:(CustomerCareerBaseClass *)_carrerInfoModel
{
    NSArray *_professionArray = @[@"生活/服务业",@"人力/行政/管理",@"销售/客服/采购/淘宝",
                                  @"市场/媒介/广告/设计",@"生产/物流/质控/汽车",
                                  @"网络/通信/电子",@"法律/教育/翻译/出版",@"财会/金融/保险",
                                  @"医疗/制药/环保",@"其他"];
    NSArray *eduLevelArray = @[@"博士及以上",@"硕士",@"本科",@"大专",
                               @"高中",@"其他"];
    NSArray *titleArray = @[@"基本信息",@"姓名",@"身份证号",@"学历",@"现居地址",
                            @"居住地详址",@"联系人1",@"联系人姓名",@"联系人手机号",
                            @"联系人2",@"联系人姓名",@"联系人手机号"];
    NSMutableArray *basicTitArr = [NSMutableArray new];
    NSArray *professionArr = @[@"职业信息",@"单位名称",@"单位电话",@"行业/职业",@"单位详址"];
    NSMutableArray *professTitArr =[NSMutableArray new];
    if (_carrerInfoModel.result.organizationName) {
//        NSArray *unitAddressArr = [[Utility sharedUtility].userInfo.userInfoModel.result.unitAddress componentsSeparatedByString:@" "];
        [professTitArr insertObject:professionArr[0] atIndex:0];
        NSString *company=@"";
        if (_carrerInfoModel.result.organizationName) {
            company = _carrerInfoModel.result.organizationName;
        }
        [professTitArr insertObject:[NSString stringWithFormat:@"%@:%@",professionArr[1],company] atIndex:1];
        NSString *telp =@"";
        if (_carrerInfoModel.result.organizationTelephone) {
            telp = _carrerInfoModel.result.organizationTelephone;
        }
        [professTitArr insertObject:[ NSString stringWithFormat:@"%@:%@",professionArr[2],telp] atIndex:2];
        //行业
        if (_carrerInfoModel.result.industry) {
            NSInteger tagflag = [_carrerInfoModel.result.industry integerValue];
           
            switch (tagflag) {
            
                    case 1:
                    case 2:
                    case 3:
                    case 4:
                    case 5:
                    case 6:
                    case 7:
                    case 8:
                    case 9:
                    case 10:
                {
                    [professTitArr insertObject:[NSString stringWithFormat:@"%@:%@",professionArr[3],_professionArray[tagflag-1]] atIndex:3];
                }
                    break;
                    
                default:
                    [professTitArr insertObject:[NSString stringWithFormat:@"%@",professionArr[3]] atIndex:3];
                    break;
            }
        }else{
            [professTitArr insertObject:[NSString stringWithFormat:@"%@",professionArr[3]] atIndex:3];
        }
        if (_carrerInfoModel.result.provinceName && _carrerInfoModel.result.countryName && _carrerInfoModel.result.cityName && _carrerInfoModel.result.organizationAddress) {
            NSString *addree = @"";
            if ([_carrerInfoModel.result.provinceName isEqualToString:_carrerInfoModel.result.cityName]) {
                addree = [NSString stringWithFormat:@"%@/%@",_carrerInfoModel.result.cityName,_carrerInfoModel.result.countryName];
            }else if ([_carrerInfoModel.result.cityName isEqualToString:_carrerInfoModel.result.countryName]){
                addree = [NSString stringWithFormat:@"%@/%@",_carrerInfoModel.result.provinceName,_carrerInfoModel.result.cityName];
            }else{
                addree = [NSString stringWithFormat:@"%@/%@/%@",_carrerInfoModel.result.provinceName,_carrerInfoModel.result.cityName,_carrerInfoModel.result.countryName];
            }
            
            [professTitArr insertObject:[NSString stringWithFormat:@"%@:%@%@",professionArr[4],addree,_carrerInfoModel.result.organizationAddress] atIndex:4];
        }else{
            if(_carrerInfoModel.result.city && _carrerInfoModel.result.province && _carrerInfoModel.result.country && _carrerInfoModel.result.organizationAddress)
            {
                NSString *addree = [NSString stringWithFormat:@"%@/%@/%@",_carrerInfoModel.result.province,_carrerInfoModel.result.city,_carrerInfoModel.result.country];
                [professTitArr insertObject:[NSString stringWithFormat:@"%@:%@%@",professionArr[4],addree,_carrerInfoModel.result.organizationAddress] atIndex:4];
            }else{
                [professTitArr insertObject:[NSString stringWithFormat:@"%@",professionArr[4]] atIndex:4];
            }
        }
        

        
        
    } else {
        [professTitArr addObjectsFromArray:professionArr];
    }

    if (_customerBaseClass.result.customerName) {
//        NSArray *addressArr = [[Utility sharedUtility].userInfo.userInfoModel.result.address componentsSeparatedByString:@" "];
        [basicTitArr  addObject:[NSString stringWithFormat:@"%@",titleArray[0]]];
        [basicTitArr addObject:[NSString stringWithFormat:@"%@:%@",titleArray[1],_customerBaseClass.result.customerName]];
        [basicTitArr addObject:[NSString stringWithFormat:@"%@:%@",titleArray[2],_customerBaseClass.result.idCode]];
        //学历
        NSInteger eduLevel = [_customerBaseClass.result.educationLevel floatValue];
        for (int i = 1; i<7; i++) {
            if (i == eduLevel) {
                [basicTitArr addObject:[NSString stringWithFormat:@"%@:%@",titleArray[3],eduLevelArray[i-1]]];
            }
        }
        //现居地址
        if (_customerBaseClass.result.provinceName && _customerBaseClass.result.cityName && _customerBaseClass.result.countyName) {
            
            NSString *proviece_city = @"";
            if ([_customerBaseClass.result.provinceName isEqualToString: _customerBaseClass.result.cityName]) {
                proviece_city = [NSString stringWithFormat:@"%@/%@",_customerBaseClass.result.cityName,_customerBaseClass.result.countyName];
            }else if ([_customerBaseClass.result.cityName isEqualToString: _customerBaseClass.result.countyName]){
                proviece_city = [NSString stringWithFormat:@"%@/%@",_customerBaseClass.result.provinceName,_customerBaseClass.result.cityName];
            }else{
                proviece_city = [NSString stringWithFormat:@"%@/%@/%@",_customerBaseClass.result.provinceName,_customerBaseClass.result.cityName,_customerBaseClass.result.countyName];
            }
            
            [basicTitArr addObject:[NSString stringWithFormat:@"%@:%@",titleArray[4],proviece_city]];
        }else{
            if (_customerBaseClass.result.province && _customerBaseClass.result.city && _customerBaseClass.result.county) {
                NSString *proviece_city = [NSString stringWithFormat:@"%@/%@/%@",_customerBaseClass.result.province,_customerBaseClass.result.city,_customerBaseClass.result.county];
                [basicTitArr addObject:[NSString stringWithFormat:@"%@:%@",titleArray[4],proviece_city]];
            }else{
                [basicTitArr addObject:[NSString stringWithFormat:@"%@",titleArray[4]]];
            }
        }
        
        //详细
        if (_customerBaseClass.result.homeAddress) {
            
            [basicTitArr addObject:[NSString stringWithFormat:@"%@:%@",titleArray[5],_customerBaseClass.result.homeAddress]];
        }
        
        if (_customerBaseClass.result.contactBean.count >=2) {
            CustomerBaseInfoContactBean *contactBeanModel= _customerBaseClass.result.contactBean[0];
            CustomerBaseInfoContactBean *contactBeanModel1= _customerBaseClass.result.contactBean[1];
            if ([contactBeanModel.relationship isEqualToString:@"1"] || [contactBeanModel.relationship isEqualToString:@"2"]) {
                if (contactBeanModel.relationship) {
                    if ([contactBeanModel.relationship isEqualToString:@"1"]) {
                        [basicTitArr addObject:[NSString stringWithFormat:@"%@:%@",titleArray[6],@"父母"]];
                    }else if ([contactBeanModel.relationship isEqualToString:@"2"]) {
                        [basicTitArr addObject:[NSString stringWithFormat:@"%@:%@",titleArray[6],@"配偶"]];
                    }else{
                        [basicTitArr addObject:[NSString stringWithFormat:@"%@",titleArray[6]]];
                    }
                    
                }
                //姓名
                if (contactBeanModel.contactName) {
                    [basicTitArr addObject:[NSString stringWithFormat:@"%@:%@",titleArray[7],contactBeanModel.contactName]];
                }else{
                    [basicTitArr addObject:[NSString stringWithFormat:@"%@",titleArray[7]]];
                }
                //电话
                if (contactBeanModel.contactPhone) {
                    [basicTitArr addObject:[NSString stringWithFormat:@"%@:%@",titleArray[8],[self formatString:contactBeanModel.contactPhone]]];
                }else{
                    [basicTitArr addObject:[NSString stringWithFormat:@"%@",titleArray[8]]];
                }
                
                if (contactBeanModel1.relationship) {
                    if ([contactBeanModel1.relationship isEqualToString:@"4"]) {
                        [basicTitArr addObject:[NSString stringWithFormat:@"%@:%@",titleArray[9],@"同事"]];
                    }else if ([contactBeanModel1.relationship isEqualToString:@"8"]) {
                        [basicTitArr addObject:[NSString stringWithFormat:@"%@:%@",titleArray[9],@"朋友"]];
                    }else{
                        [basicTitArr addObject:[NSString stringWithFormat:@"%@",titleArray[9]]];
                    }
                    
                }
                //姓名
                if (contactBeanModel1.contactName) {
                    [basicTitArr addObject:[NSString stringWithFormat:@"%@:%@",titleArray[10],contactBeanModel1.contactName]];
                }else{
                    [basicTitArr addObject:[NSString stringWithFormat:@"%@",titleArray[10]]];
                }
                //电话
                if (contactBeanModel1.contactPhone) {
                    [basicTitArr addObject:[NSString stringWithFormat:@"%@:%@",titleArray[11],[self formatString:contactBeanModel1.contactPhone]]];
                }else{
                    [basicTitArr addObject:[NSString stringWithFormat:@"%@",titleArray[11]]];
                }
                
            }else{
                if (contactBeanModel1.relationship) {
                    if ([contactBeanModel1.relationship isEqualToString:@"1"]) {
                        [basicTitArr addObject:[NSString stringWithFormat:@"%@:%@",titleArray[6],@"父母"]];
                    }else if ([contactBeanModel1.relationship isEqualToString:@"2"]) {
                        [basicTitArr addObject:[NSString stringWithFormat:@"%@:%@",titleArray[6],@"配偶"]];
                    }else{
                        [basicTitArr addObject:[NSString stringWithFormat:@"%@",titleArray[6]]];
                    }
                    
                }
                //姓名
                if (contactBeanModel1.contactName) {
                    [basicTitArr addObject:[NSString stringWithFormat:@"%@:%@",titleArray[7],contactBeanModel1.contactName]];
                }else{
                    [basicTitArr addObject:[NSString stringWithFormat:@"%@",titleArray[7]]];
                }
                //电话
                if (contactBeanModel1.contactPhone) {
                    [basicTitArr addObject:[NSString stringWithFormat:@"%@:%@",titleArray[8],[self formatString:contactBeanModel1.contactPhone]]];
                }else{
                    [basicTitArr addObject:[NSString stringWithFormat:@"%@",titleArray[8]]];
                }
                
                if (contactBeanModel.relationship) {
                    if ([contactBeanModel.relationship isEqualToString:@"4"]) {
                        [basicTitArr addObject:[NSString stringWithFormat:@"%@:%@",titleArray[9],@"同事"]];
                    }else if ([contactBeanModel.relationship isEqualToString:@"8"]) {
                        [basicTitArr addObject:[NSString stringWithFormat:@"%@:%@",titleArray[9],@"朋友"]];
                    }else{
                        [basicTitArr addObject:[NSString stringWithFormat:@"%@",titleArray[9]]];
                    }
                    
                }
                //姓名
                if (contactBeanModel.contactName) {
                    [basicTitArr addObject:[NSString stringWithFormat:@"%@:%@",titleArray[10],contactBeanModel.contactName]];
                }else{
                    [basicTitArr addObject:[NSString stringWithFormat:@"%@",titleArray[10]]];
                }
                //电话
                if (contactBeanModel.contactPhone) {
                    [basicTitArr addObject:[NSString stringWithFormat:@"%@:%@",titleArray[11],[self formatString:contactBeanModel.contactPhone]]];
                }else{
                    [basicTitArr addObject:[NSString stringWithFormat:@"%@",titleArray[11]]];
                }
                
            }

        }else{
            for (int i= 6; i < 12; i++) {
                [basicTitArr addObject:[NSString stringWithFormat:@"%@",titleArray[i]]];
            }
        }
        
    }else{
        [basicTitArr addObjectsFromArray:titleArray];
    }
    
    
    UIView *basicView = [[UIView alloc]initWithFrame:CGRectMake(15, 20, _k_w-30, 380)];
    UIView *professionView = [[UIView alloc]initWithFrame:CGRectMake(15, 420, _k_w-30, 200)];
    [self.contentView addSubview:basicView];
    [self.contentView addSubview:professionView];
    [Tool setCorner:basicView borderColor:RGBColor(214, 214, 214, 1)];
    [Tool setCorner:professionView borderColor:RGBColor(214, 214, 214, 1)];
    
    for (int i = 0; i < basicTitArr.count; i++) {
        UIView *insideView = [[UIView alloc] init];
        if (i == 0) {
            insideView.frame = CGRectMake(0, 0, basicView.frame.size.width, 50);
            UILabel *titLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 80, 30)];
            titLabel.text = [basicTitArr objectAtIndex:i];
            [titLabel setFont:[UIFont systemFontOfSize:18]];
            titLabel.textAlignment = NSTextAlignmentLeft;
            [insideView addSubview:titLabel];
            
            self.basicEditBtn = [[UIButton alloc] initWithFrame:CGRectMake(_k_w - 70, 14, 21, 21)];
            if ([_customerBaseClass.result.province isEqualToString:@""] || _customerBaseClass.result.province == nil) {
                self.basicEditBtn.hidden = YES;
            }else{
                self.basicEditBtn.hidden = NO;
            }
            [self.basicEditBtn setImage:[UIImage imageNamed:@"6_my_icon_06"] forState:UIControlStateNormal];
            [insideView addSubview:self.basicEditBtn];
        } else {
            if (i == 1) {
                insideView.frame = CGRectMake(0, i * 50, basicView.frame.size.width, 30);
                UILabel *titLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, basicView.frame.size.width-20, 20)];
                titLabel.text = [basicTitArr objectAtIndex:i];
                [titLabel setFont:[UIFont systemFontOfSize:14]];
                titLabel.textAlignment = NSTextAlignmentLeft;
                titLabel.textColor = RGBColor(158, 158, 159, 1);
                [insideView addSubview:titLabel];
                
                UILabel *contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(_k_w - 250, 5, 210, 20)];
                [insideView addSubview:contentLabel];
            } else {
                insideView.frame = CGRectMake(0, 50 + (i - 1)*30, basicView.frame.size.width, 30);
                UILabel *titLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, basicView.frame.size.width-20, 20)];
                titLabel.text = [basicTitArr objectAtIndex:i];
                [titLabel setFont:[UIFont systemFontOfSize:14]];
                titLabel.textAlignment = NSTextAlignmentLeft;
                titLabel.textColor = RGBColor(158, 158, 159, 1);
                [insideView addSubview:titLabel];
                
                UILabel *contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(_k_w - 250, 5, 210, 20)];
                [insideView addSubview:contentLabel];
            }
        }
        
        if (i % 2 == 0) {
            insideView.backgroundColor = RGBColor(240, 240, 240, 1);
        } else {
            insideView.backgroundColor = [UIColor whiteColor];
        }
        [basicView addSubview:insideView];
    }
    
    for (int i = 0; i < professionArr.count; i++) {
        UIView *insideView = [[UIView alloc] init];
        if (i == 0) {
            insideView.frame = CGRectMake(0, 0, basicView.frame.size.width, 50);
            UILabel *titLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 80, 30)];
            titLabel.text = [professTitArr objectAtIndex:i];
            [titLabel setFont:[UIFont systemFontOfSize:18]];
            titLabel.textAlignment = NSTextAlignmentLeft;
            [insideView addSubview:titLabel];
            
            self.professEditBtn = [[UIButton alloc] initWithFrame:CGRectMake(_k_w - 70, 14, 21, 21)];
            if (_carrerInfoModel.result.province == nil || [_carrerInfoModel.result.province isEqualToString:@""]) {
                self.professEditBtn.hidden = YES;
            }else{
                self.professEditBtn.hidden = NO;
            }
            [self.professEditBtn setImage:[UIImage imageNamed:@"6_my_icon_06"] forState:UIControlStateNormal];
            [insideView addSubview:self.professEditBtn];
        }else {
            if (i == 1) {
                insideView.frame = CGRectMake(0, i * 50, basicView.frame.size.width, 30);
                UILabel *titLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, basicView.frame.size.width-20, 20)];
                titLabel.text = [professTitArr objectAtIndex:i];
                [titLabel setFont:[UIFont systemFontOfSize:14]];
                titLabel.textAlignment = NSTextAlignmentLeft;
                titLabel.textColor = RGBColor(158, 158, 159, 1);
                [insideView addSubview:titLabel];
                
                UILabel *contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(_k_w - 250, 5, 210, 20)];
                [contentLabel setFont:[UIFont systemFontOfSize:14]];
                contentLabel.textAlignment = NSTextAlignmentLeft;
                [insideView addSubview:contentLabel];
            } else if (i == 4) {
                insideView.frame = CGRectMake(0, 50 + (i - 1)*30, basicView.frame.size.width, 60);
                UILabel *titLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, basicView.frame.size.width-20, 40)];
                titLabel.numberOfLines = 0;
                titLabel.text = [professTitArr objectAtIndex:i];
                [titLabel setFont:[UIFont systemFontOfSize:14]];
                titLabel.textAlignment = NSTextAlignmentLeft;
                titLabel.textColor = RGBColor(158, 158, 159, 1);
                [insideView addSubview:titLabel];
                
            } else {
                insideView.frame = CGRectMake(0, 50 + (i - 1)*30, basicView.frame.size.width, 30);
                UILabel *titLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, basicView.frame.size.width-20, 20)];
                titLabel.text = [professTitArr objectAtIndex:i];
                [titLabel setFont:[UIFont systemFontOfSize:14]];
                titLabel.textAlignment = NSTextAlignmentLeft;
                titLabel.textColor = RGBColor(158, 158, 159, 1);
                [insideView addSubview:titLabel];
                
                UILabel *contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(_k_w - 250, 5, 210, 20)];
                [contentLabel setFont:[UIFont systemFontOfSize:14]];
                contentLabel.textAlignment = NSTextAlignmentLeft;
                [insideView addSubview:contentLabel];
            }
        }
        
        if (i % 2 == 0) {
            insideView.backgroundColor = RGBColor(240, 240, 240, 1);
        } else {
            insideView.backgroundColor = [UIColor whiteColor];
        }
        [professionView addSubview:insideView];
    }
    
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (NSString *)formatString:(NSString *)str
{
    NSMutableString *returnStr = [NSMutableString stringWithString:str];
    
    NSMutableString *zbc = [NSMutableString string];
    for (NSInteger i = 0; i < returnStr.length; i++) {
        unichar c = [returnStr characterAtIndex:i];
        if (i > 0) {
            if (i == 2) {
                [zbc appendFormat:@"%C ",c];
                
            }else if (i == 6){
                [zbc appendFormat:@"%C ",c];
            }else {
                [zbc appendFormat:@"%C",c];
            }
        } else {
            [zbc appendFormat:@"%C",c];
        }
    }
    
    return zbc;
}


@end
