//
//  ProfessionViewController.m
//  fxdProduct
//
//  Created by dd on 2017/2/22.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "ProfessionViewController.h"
#import "TelPhoneCompanyCell.h"
#import "LabelCell.h"
#import "RegionBaseClass.h"
#import "RegionCodeBaseClass.h"
#import "NSString+Validate.h"
#import "SaveCustomerCarrerViewModel.h"
#import "CareerParse.h"
#import "CustomerCareerBaseClass.h"
#import "DataDicParse.h"

#define FirstComponent 0
#define SubComponent 1
#define ThirdComponent 2
#define CellBGColorRed rgb(252, 0, 6)

@interface ProfessionViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSArray *_placeHolderArr;
    NSInteger _pickerTag;
//    NSArray *_professionArray;//行业职业
    NSMutableArray *_pickerArray;
    NSMutableArray *_subPickerArray;
    NSMutableArray *_thirdPickerArray;
    NSMutableArray *dataListAll;
    NSMutableArray *dataColor;
    NSInteger index;
    RegionSub *_regionSub;
    RegionBaseClass *_reginBase;
    UIButton *_saveBtn;
    RegionCodeBaseClass *_regionCodeParse;
    RegionCodeResult *_cityCode;
    //职业信息返回信息
    CareerParse *_careerParse;
    NSString *add;
    
    DataDicParse *_dataDicModel;
}

@property (nonatomic, strong) UIPickerView *localPicker;

@end

@implementation ProfessionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    _pickerArray = [NSMutableArray array];
    _subPickerArray = [NSMutableArray array];
    _thirdPickerArray = [NSMutableArray array];
    dataListAll = [NSMutableArray array];
    self.navigationItem.title = @"职业信息";
    _placeHolderArr = @[@"请确保填写的均为本人真实信息",@"单位名称",@"单位电话",@"行业",@"单位所在地",@"单位详址"];
//    _professionArray = @[@"生活/服务业",@"人力/行政/管理",@"销售/客服/采购/淘宝",
//                         @"市场/媒介/广告/设计",@"生产/物流/质控/汽车",
//                         @"网络/通信/电子",@"法律/教育/翻译/出版",@"财会/金融/保险",
//                         @"医疗/制药/环保",@"其他"];
    dataColor = [NSMutableArray array];
    dataListAll = [NSMutableArray array];
    if (UI_IS_IPHONE5) {
        self.automaticallyAdjustsScrollViewInsets = false;
    }
    
    NSString *device = [[UIDevice currentDevice] systemVersion];
    if (device.floatValue>10) {
        
        self.automaticallyAdjustsScrollViewInsets = true;
    }else{
        
        self.automaticallyAdjustsScrollViewInsets = false;
    }
    
    for (int i = 0; i < 6; i++) {
        [dataListAll addObject:@""];
        [dataColor addObject:UI_MAIN_COLOR];
    }
    index = 0;
    _toolbarCancelDone.hidden = true;
    [self addBackItem];
    [self configTableView];
    [self setDataInfo];
//    [self getDataDic:nil];
}

- (void)configTableView
{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TelPhoneCompanyCell class]) bundle:nil] forCellReuseIdentifier:@"TelPhoneCompanyCell"];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LabelCell class]) bundle:nil] forCellReuseIdentifier:@"LabelCell"];
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _k_w, 100)];
    _saveBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [footView addSubview:_saveBtn];
    [_saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [_saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [Tool setCorner:_saveBtn borderColor:[UIColor clearColor]];
    _saveBtn.enabled = false;
    [_saveBtn setBackgroundColor:rgb(139, 140, 143)];
    [_saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.right.equalTo(@(-20));
        make.bottom.equalTo(@0);
        make.height.equalTo(_saveBtn.mas_width).multipliedBy(0.15);
    }];
    [_saveBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.tableView.tableFooterView = footView;
    
}

- (void)getDataDic:(void(^)())finish
{
    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_getDicCode_url] parameters:@{@"dict_type_":@"INDUSTRY_"} finished:^(EnumServerStatus status, id object) {
        if ([[object objectForKey:@"flag"] isEqualToString:@"0000"]) {
            _dataDicModel = [DataDicParse yy_modelWithJSON:object];
            if (finish) {
                finish();
            }
        } else {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:[object objectForKey:@"msg"]];
        }
    } failure:^(EnumServerStatus status, id object) {
        
    }];
}

- (void)setDataInfo
{
    if (_careerInfo.result.organizationName) {
        [dataListAll replaceObjectAtIndex:0 withObject:_careerInfo.result.organizationName];
    }
    if (_careerInfo.result.organizationTelephone) {
        if ([_careerInfo.result.organizationTelephone length]>9) {
            NSString *telString= _careerInfo.result.organizationTelephone;
            NSArray *telArray = [telString componentsSeparatedByString:@"-"];
            if (telArray.count >1) {
                if ([telArray[0] isAreaCode]) {
                    [dataListAll replaceObjectAtIndex:5 withObject:telArray[0]];
                }
                if ([self isCommonString:telArray[1]]) {
                    [dataListAll replaceObjectAtIndex:1 withObject:telArray[1]];
                }
                
            }else{
                telString = [_careerInfo.result.organizationTelephone areaCodeFormat];
                NSArray *telArray1 = [telString componentsSeparatedByString:@"-"];
                if ([telArray1[0] isAreaCode]) {
                    [dataListAll replaceObjectAtIndex:5 withObject:telArray1[0]];
                }
                if ([self isCommonString:telArray1[1]]) {
                    [dataListAll replaceObjectAtIndex:1 withObject:telArray1[1]];
                }
            }
            
        }else{
            
            if ([self isCommonString:_careerInfo.result.organizationTelephone]) {
                [dataListAll replaceObjectAtIndex:1 withObject:_careerInfo.result.organizationTelephone];
            }
        }
    }
    //行业
    if (_careerInfo.result.industry) {
        NSInteger tagflag = [_careerInfo.result.industry integerValue];
        if (_dataDicModel) {
            [_dataDicModel.result enumerateObjectsUsingBlock:^(DataDicResult * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (tagflag == obj.code_.integerValue) {
                    [dataListAll replaceObjectAtIndex:2 withObject:obj.desc_];
                    [_tableView reloadData];
                }
            }];
        } else {
            [self getDataDic:^{
                [_dataDicModel.result enumerateObjectsUsingBlock:^(DataDicResult * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if (tagflag == obj.code_.integerValue) {
                        [dataListAll replaceObjectAtIndex:2 withObject:obj.desc_];
                        [_tableView reloadData];
                    }
                }];
            }];
        }
        
//        for (int i = 1; i< 11; i++) {
//            if (i == tagflag) {
//                [dataListAll replaceObjectAtIndex:2 withObject:_professionArray[i-1]];
//            }
//        }
    }
    if (_careerInfo.result.cityName && _careerInfo.result.provinceName && _careerInfo.result.countryName){
        NSString  *addree = @"";
        add = [NSString stringWithFormat:@"%@/%@/%@",_careerInfo.result.provinceName,
                         _careerInfo.result.cityName,_careerInfo.result.countryName];
        if ([_careerInfo.result.cityName isEqualToString: _careerInfo.result.provinceName]) {
            addree = [NSString stringWithFormat:@"%@/%@",
                      _careerInfo.result.cityName,_careerInfo.result.countryName];
        }else if ([_careerInfo.result.cityName isEqualToString: _careerInfo.result.countryName]){
            addree = [NSString stringWithFormat:@"%@/%@",_careerInfo.result.provinceName,
                      _careerInfo.result.cityName];
        }else{
            addree = [NSString stringWithFormat:@"%@/%@/%@",_careerInfo.result.provinceName,
                      _careerInfo.result.cityName,_careerInfo.result.countryName];
        }
        [dataListAll replaceObjectAtIndex:3 withObject:addree];
    }else{
        if(_careerInfo.result.city && _careerInfo.result.province && _careerInfo.result.country)
        {
            NSString *addrees = [NSString stringWithFormat:@"%@/%@/%@",_careerInfo.result.province,
                                _careerInfo.result.city,_careerInfo.result.country];
            [dataListAll replaceObjectAtIndex:3 withObject:addrees];
        }
    }
    if (_careerInfo.result.organizationAddress) {
        [dataListAll replaceObjectAtIndex:4 withObject:_careerInfo.result.organizationAddress];
    }
    if (add.length > 3) {
        [self PostGetCityCode:add];
    }
    
}

//获取职业
- (NSDictionary *)getProfessionInfo
{
    
    NSString *telString =[NSString stringWithFormat:@"%@-%@",dataListAll.lastObject,dataListAll[1]];
    __block NSString *profefssiontag = @"";
    if (_dataDicModel) {
        [_dataDicModel.result enumerateObjectsUsingBlock:^(DataDicResult * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([dataListAll[2] isEqualToString:obj.desc_]) {
                profefssiontag = obj.code_;
            }
        }];
    } else {
        [self getDataDic:^{
            [_dataDicModel.result enumerateObjectsUsingBlock:^(DataDicResult * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([dataListAll[2] isEqualToString:obj.desc_]) {
                    profefssiontag = obj.code_;
                }
            }];
        }];
    }
    
//    for (int i = 0; i < _professionArray.count; i++) {
//        if ([dataListAll[2] isEqualToString:_professionArray[i]]) {
//            profefssiontag =[NSString stringWithFormat:@"%d",i+1];
//        }
//    }
    NSString *cityDetail = [dataListAll[4] stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *companyString  = [dataListAll[0] stringByReplacingOccurrencesOfString:@" " withString:@""];
    return @{@"organization_name_":companyString,
             @"organization_telephone_":telString,
             @"industry_":profefssiontag,
             @"province_":_cityCode.provinceCode,
             @"city_":_cityCode.cityCode,
             @"country_":_cityCode.districtCode,
             @"organization_address_":cityDetail,
             @"product_id_":_product_id};
}

#pragma mark - 职业信息保存

- (void)saveBtnClick
{
    DLog(@"保存");
    if (![_cityCode.provinceCode isEqualToString:@""] && ![_cityCode.cityCode isEqualToString:@""] && ![_cityCode.districtCode isEqualToString:@""]) {
        //职业信息保存
        NSDictionary *dictry = [self getProfessionInfo];
        
        SaveCustomerCarrerViewModel *saveCustomerCarrerViewModel = [[SaveCustomerCarrerViewModel alloc] init];
        [saveCustomerCarrerViewModel setBlockWithReturnBlock:^(id returnValue) {
            _careerParse = [CareerParse yy_modelWithJSON:returnValue];
            if ([_careerParse.flag isEqualToString:@"0000"]) {
                [self.delegate setProfessRule:_careerParse];
                [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:_careerParse.msg];
                [self.navigationController popViewControllerAnimated:true];
                
            }else{
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:[returnValue objectForKey:@"msg"]];
            }
        } WithFaileBlock:^{
            
        }];
        [saveCustomerCarrerViewModel saveCustomCarrer:dictry];
    }else{
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请重新选择单位所在地"];
    }
}

#pragma mark->获取省市区

-(void)PostGetCity
{
    
    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_getAllRegionList_url] parameters:nil finished:^(EnumServerStatus status, id object) {
        if (status == Enum_SUCCESS) {
            if ([[object objectForKey:@"flag"]isEqualToString:@"0000"])
            {
                _reginBase = [RegionBaseClass modelObjectWithDictionary:object];
                for (int i = 0; i < _reginBase.result.count; i++) {
                    //取出省
                    _regionSub = _reginBase.result[i];
                    [_pickerArray addObject:_regionSub.name];
                }
                
                //第一个省的所有区
                RegionSub *regisonSubModel = _reginBase.result[0];
                for (int j = 0; j < regisonSubModel.sub.count; j++) {
                    RegionResult *regionResultModel = regisonSubModel.sub[j];
                    [_subPickerArray addObject:regionResultModel.name];
                }
                
                //第一个区的县的所有县
                RegionResult *regionResultModel = regisonSubModel.sub[0];
                for (int j = 0; j < regionResultModel.sub.count; j++) {
                    //取出市
                    [_thirdPickerArray addObject:[regionResultModel.sub[j] objectForKey:@"name"]];
                    
                }
                
                [_localPicker reloadAllComponents];
            }
        }
    } failure:^(EnumServerStatus status, id object) {
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请求失败"];
    }];
}


#pragma mark - TableviewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 50.f;
    } else {
        return 70.f;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self isCanSelectBtn]) {
        _saveBtn.enabled = true;
        [_saveBtn setBackgroundColor:rgb(16, 129, 249)];
    } else {
        _saveBtn.enabled = false;
        [_saveBtn setBackgroundColor:rgb(139, 140, 143)];
    }
    
    if (indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            UIImageView *iconView = [[UIImageView alloc] init];
            iconView.image = [UIImage imageNamed:@"topCellIcon"];
            [cell.contentView addSubview:iconView];
            [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(@10);
                make.top.equalTo(@9);
                make.width.equalTo(@22);
                make.height.equalTo(@22);
                //                make.bottom.equalTo(@5);
                //                make.width.equalTo(iconView.mas_height).multipliedBy(1.f);
            }];
            UILabel *label = [[UILabel alloc] init];
            [cell.contentView addSubview:label];
            label.text = _placeHolderArr[indexPath.row];
            label.textColor = [UIColor redColor];
            label.font = [UIFont systemFontOfSize:13.f];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(iconView.mas_right).offset(4);
                make.top.equalTo(@5);
                //                make.bottom.equalTo(cell.contentView);
                make.height.equalTo(@30);
                make.right.equalTo(cell.contentView);
            }];
        }
        return cell;
    }else {
        switch (indexPath.row) {
            case 2:
            {
                TelPhoneCompanyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TelPhoneCompanyCell"];
                if (!cell) {
                    cell = [[[NSBundle mainBundle] loadNibNamed:@"TelPhoneCompanyCell" owner:self options:nil] lastObject];
                }
                cell.textfiledCode.text = dataListAll.lastObject;
                cell.textfiledCode.tag = 2;
                cell.textfiledCode.delegate = self;
                cell.textfiledCode.keyboardType = UIKeyboardTypePhonePad;
                
                cell.textfiledTel.text = dataListAll[indexPath.row-1];
                cell.textfiledTel.delegate = self;
                cell.textfiledTel.tag = indexPath.row + 10;
                cell.textfiledTel.keyboardType = UIKeyboardTypePhonePad;
                [Tool setCorner:cell.viewCode borderColor:dataColor.lastObject];
                [Tool setCorner:cell.viewTel borderColor:dataColor[indexPath.row-1]];
                return cell;
            }
                break;
            case 1:
            case 3:
            case 4:
            case 5:
            {
                LabelCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"LabelCell%ld",indexPath.row]];
                if (!cell) {
                    cell = [[[NSBundle mainBundle] loadNibNamed:@"LabelCell" owner:self options:nil] lastObject];
                }
                
                cell.textField.placeholder = _placeHolderArr[indexPath.row];
                cell.textField.tag = indexPath.row + 10;
                cell.textField.delegate = self;
                cell.textField.text = dataListAll[indexPath.row-1];
                
                if (indexPath.row == 1 || indexPath.row == 5) {
                    cell.btn.hidden = YES;
                }else{
                    cell.btn.hidden = NO;
                    cell.btn.tag = indexPath.row + 200;
                    [cell.btn addTarget:self action:@selector(senderBtn:) forControlEvents:UIControlEventTouchUpInside];
                    [cell.btn setBackgroundImage:[UIImage imageNamed:@"3_lc_icon_25"] forState:UIControlStateNormal];
                }
                cell.btnSecory.hidden = YES;
                [Tool setCorner:cell.bgView borderColor:dataColor[indexPath.row-1]];
                cell.selectionStyle  = UITableViewCellSelectionStyleNone;
                return cell;
            }
                break;
                
            default:
                break;
        }
    }
    
    return nil;
}

-(void)senderBtn:(UIButton *)sender
{
    switch (sender.tag) {
        case 203:
        {
            if (_dataDicModel) {
                [self createPickViewShowWithTag:203];
            } else {
                [self getDataDic:^{
                    [self createPickViewShowWithTag:203];
                }];
            }
        }
            break;
        case 204:
        {
            if (_pickerArray.count != 34) {
                [self PostGetCity];
            }
            [self createPickViewShowWithTag:204];
        }
            break;
            
        default:
            break;
    }
}

- (IBAction)doneAction:(id)sender {
    NSString *localString = @"";
    NSString *loString = @"";
    if (_pickerTag == 204) {
        
        if (_pickerArray.count > 0 && _subPickerArray.count > 0 && _thirdPickerArray.count > 0) {
            if ([[_pickerArray objectAtIndex:[self.localPicker selectedRowInComponent:0]] isEqualToString:[_subPickerArray objectAtIndex:[self.localPicker selectedRowInComponent:1]]]) {
                localString = [NSString stringWithFormat:@"%@/%@",[_subPickerArray objectAtIndex:[self.localPicker selectedRowInComponent:1]],[_thirdPickerArray objectAtIndex:[self.localPicker selectedRowInComponent:2]]];
                
                loString = [NSString stringWithFormat:@"%@/%@/%@",[_pickerArray objectAtIndex:[self.localPicker selectedRowInComponent:0]],[_subPickerArray objectAtIndex:[self.localPicker selectedRowInComponent:1]],[_thirdPickerArray objectAtIndex:[self.localPicker selectedRowInComponent:2]]];
            }else if ([[_subPickerArray objectAtIndex:[self.localPicker selectedRowInComponent:1]] isEqualToString:[_thirdPickerArray objectAtIndex:[self.localPicker selectedRowInComponent:2]]]){
                localString = [NSString stringWithFormat:@"%@/%@",[_pickerArray objectAtIndex:[self.localPicker selectedRowInComponent:0]],[_subPickerArray objectAtIndex:[self.localPicker selectedRowInComponent:1]]];
                loString = [NSString stringWithFormat:@"%@/%@/%@",[_pickerArray objectAtIndex:[self.localPicker selectedRowInComponent:0]],[_subPickerArray objectAtIndex:[self.localPicker selectedRowInComponent:1]],[_thirdPickerArray objectAtIndex:[self.localPicker selectedRowInComponent:2]]];
            } else if ([_pickerArray objectAtIndex:[self.localPicker selectedRowInComponent:0]] &&[_subPickerArray objectAtIndex:[self.localPicker selectedRowInComponent:1]] &&[_thirdPickerArray objectAtIndex:[self.localPicker selectedRowInComponent:2]]){
                localString = [NSString stringWithFormat:@"%@/%@/%@",[_pickerArray objectAtIndex:[self.localPicker selectedRowInComponent:0]],[_subPickerArray objectAtIndex:[self.localPicker selectedRowInComponent:1]],[_thirdPickerArray objectAtIndex:[self.localPicker selectedRowInComponent:2]]];
                loString = [NSString stringWithFormat:@"%@/%@/%@",[_pickerArray objectAtIndex:[self.localPicker selectedRowInComponent:0]],[_subPickerArray objectAtIndex:[self.localPicker selectedRowInComponent:1]],[_thirdPickerArray objectAtIndex:[self.localPicker selectedRowInComponent:2]]];
            }
            
        }
        //        [dataListAll replaceObjectAtIndex:7 withObject:loString];
        [dataListAll replaceObjectAtIndex:3 withObject:localString];
        [dataColor replaceObjectAtIndex:3 withObject:UI_MAIN_COLOR];
        //第一个省的所有区
        [_subPickerArray removeAllObjects];
        RegionSub *regisonSubModel = _reginBase.result[0];
        for (int j = 0; j < regisonSubModel.sub.count; j++) {
            RegionResult *regionResultModel = regisonSubModel.sub[j];
            [_subPickerArray addObject:regionResultModel.name];
        }
        
        //第一个区的县的所有县
        [_thirdPickerArray removeAllObjects];
        RegionResult *regionResultModel = regisonSubModel.sub[0];
        for (int j = 0; j < regionResultModel.sub.count; j++) {
            //取出市
            [_thirdPickerArray addObject:[regionResultModel.sub[j] objectForKey:@"name"]];
            
        }
        [self PostGetCityCode:loString];
    }else {
        if ([dataListAll[2] isEqualToString:@""]) {
            [dataListAll replaceObjectAtIndex:2 withObject:_dataDicModel.result.firstObject.desc_];
        }
        [dataColor replaceObjectAtIndex:2 withObject:UI_MAIN_COLOR];
    }
    
    [_tableView reloadData];
    [UIView animateWithDuration:0.5
                          delay:0.1
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.localPicker.hidden = YES;
                         self.toolbarCancelDone.hidden = YES;
                     }
                     completion:^(BOOL finished){
                         
                     }];
    
}

#pragma mark ->获取省市区代码
-(void)PostGetCityCode:(NSString *)datalisCity
{
    //获取省市区代码
    NSArray *cityArray = [datalisCity componentsSeparatedByString:@"/"];
    NSString *city0 = @"";
    NSString *city1 = @"";
    NSString *city2 = @"";
    if (cityArray.count > 2) {
        city0 = cityArray[0];
        city1 = cityArray[1];
        city2 = cityArray[2];
    }
    
    NSDictionary *dict = @{@"provinceName":city0,
                           @"cityName":city1,
                           @"districtName":city2
                           };
    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_getRegionCodeByName_jhtml] parameters:dict finished:^(EnumServerStatus status, id object) {
        if (status == Enum_SUCCESS) {
            if ([[object objectForKey:@"flag"] isEqualToString:@"0000"]) {
                _regionCodeParse = [RegionCodeBaseClass modelObjectWithDictionary:object];
                _cityCode = _regionCodeParse.result;
                //                    [self PostCustomerInfoSaveBase];
            } else {
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请重新选择省市区"];
            }
        }
    } failure:^(EnumServerStatus status, id object) {
        
    }];
}

- (IBAction)cancelAction:(id)sender {
    [UIView animateWithDuration:0.5
                          delay:0.1
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         
                         self.localPicker.hidden = YES;
                         self.toolbarCancelDone.hidden = YES;
                     }
                     completion:^(BOOL finished){
                         
                     }];
}


-(void)setRomovePickView
{
    _toolbarCancelDone.hidden = NO;
    [self.view bringSubviewToFront:_toolbarCancelDone];
    _toolbarCancelDone.backgroundColor =  rgb(241, 241, 241);
    [_localPicker removeFromSuperview];
}

#pragma mark - 创建PIckView --UIPickerViewDelegate
-(void)createPickViewShowWithTag:(NSInteger)tag
{
    [self.view endEditing:YES];
    [self setRomovePickView];
    
    switch (tag) {
        case 203: //行业
        {
            _pickerTag = tag;
            _localPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, _k_h-183, _k_w, 183)];
            _localPicker.backgroundColor = [UIColor whiteColor];
            _localPicker.dataSource = self;
            _localPicker.delegate = self;
            [self.view addSubview:_localPicker];
        }
            break;
        case 204: //单位地址
        {
            _pickerTag = tag;
            _localPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, _k_h-183, _k_w, 183)];
            _localPicker.backgroundColor = [UIColor whiteColor];
            _localPicker.dataSource = self;
            _localPicker.delegate = self;
            [self.view addSubview:_localPicker];
        }
            break;
        default:
            break;
    }
}

#pragma mark--UIPickerViewDataSource
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (_pickerTag == 203) {
        return 1;
    }
    return 3;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 30.f;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (_pickerTag == 203)
    {
        return _dataDicModel.result.count;
    }else {
        if (component == FirstComponent) {
            return [_pickerArray count];
        }
        if (component == SubComponent) {
            return [_subPickerArray count];
        }
        if (component == ThirdComponent) {
            return [_thirdPickerArray count];
        }
    }
    return 0;
}


#pragma mark--UIPickerViewDelegate
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (_pickerTag == 203)
    {
        return _dataDicModel.result[row].desc_;
    }else{
        
        if (component==FirstComponent) {
            return [_pickerArray objectAtIndex:row];
        }
        if (component==SubComponent) {
            if (_subPickerArray.count - 1 < row) {
                return _subPickerArray[0];
            }
            return [_subPickerArray objectAtIndex:row];
        }
        if (component==ThirdComponent) {
            if (_thirdPickerArray.count - 1 < row) {
                return _thirdPickerArray[0];
            }
            return [_thirdPickerArray objectAtIndex:row];
        }
    }
    return nil;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (_pickerTag == 203) {
        [dataListAll replaceObjectAtIndex:2 withObject:_dataDicModel.result[row].desc_];
    }else{
        if (component == 0) {
            //第一个省的所有区
            index = row;
            [_subPickerArray removeAllObjects];
            _regionSub = _reginBase.result[row];
            
            for (int j = 0; j < _regionSub.sub.count; j++) {
                RegionResult *regionResultModel = _regionSub.sub[j];
                [_subPickerArray addObject:regionResultModel.name];
            }
            
            //第一个区的县的所有县
            [_thirdPickerArray removeAllObjects];
            RegionResult *regionResultModel = _regionSub.sub[0];
            for (int j = 0; j < regionResultModel.sub.count; j++) {
                //取出市
                [_thirdPickerArray addObject:[regionResultModel.sub[j] objectForKey:@"name"]];
                
            }
            
            [pickerView selectedRowInComponent:1];
            [pickerView reloadComponent:0];
            [pickerView reloadComponent:1];
            [pickerView selectedRowInComponent:2];
        }
        if (component == 1) {
            
            [_subPickerArray removeAllObjects];
            _regionSub = _reginBase.result[index];
            for (int j = 0; j < _regionSub.sub.count; j++) {
                RegionResult *regionResultModel = _regionSub.sub[j];
                [_subPickerArray addObject:regionResultModel.name];
            }
            //第一个区的县的所有县
            [_thirdPickerArray removeAllObjects];
            RegionResult *regionResultModel = [[RegionResult alloc] init];
            if (row > _regionSub.sub.count - 1) {
                regionResultModel = _regionSub.sub[0];
            }else{
                regionResultModel = _regionSub.sub[row];
            }
            
            for (int j = 0; j < regionResultModel.sub.count; j++) {
                //取出市
                [_thirdPickerArray addObject:[regionResultModel.sub[j] objectForKey:@"name"]];
                
            }
            
            [pickerView selectRow:0 inComponent:2 animated:YES];
        }
        [pickerView reloadComponent:2];
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if (_pickerTag == 203) {
        return 300.;
    }else{
        if (component==FirstComponent) {
            return 90.0;
        }
        if (component==SubComponent) {
            return 120.0;
        }
        if (component==ThirdComponent) {
            return 100.0;
        }
    }
    return 0;
}


#pragma mark - UITextFieldDelegate

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField.tag == 13 || textField.tag == 14) {
        return NO;
    }
    
    return YES;
}

//-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//
//}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag == 11) {
        if (![CheckUtils checkUserName:textField.text]) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入正确的单位名称"];
            [dataColor replaceObjectAtIndex:0 withObject:CellBGColorRed];
        }else{
            [dataListAll replaceObjectAtIndex:0 withObject:textField.text];
            [dataColor replaceObjectAtIndex:0 withObject:UI_MAIN_COLOR];
        }
    }
    if (textField.tag == 12) {
        if (![self isCommonString:textField.text]) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入正确的单位电话"];
            [dataColor replaceObjectAtIndex:1 withObject:CellBGColorRed];
        }else{
            [dataListAll replaceObjectAtIndex:1 withObject:textField.text];
            [dataColor replaceObjectAtIndex:1 withObject:UI_MAIN_COLOR];
        }
    }
    if (textField.tag == 13) {
        if (textField.text.length < 5) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请选择正确的行业/职业"];
            [dataColor replaceObjectAtIndex:2 withObject:CellBGColorRed];
        }else{
            [dataListAll replaceObjectAtIndex:2 withObject:textField.text];
            [dataColor replaceObjectAtIndex:2 withObject:UI_MAIN_COLOR];
        }
    }
    if (textField.tag == 14) {
        if (textField.text.length < 5) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请选择正确的单位所在地"];
            [dataColor replaceObjectAtIndex:3 withObject:CellBGColorRed];
        }else{
            [dataListAll replaceObjectAtIndex:3 withObject:textField.text];
            [dataColor replaceObjectAtIndex:3 withObject:UI_MAIN_COLOR];
        }
    }
    if (textField.tag == 15) {
        NSString *detain = [textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        if (![CheckUtils checkUserDetail:detain] || [CheckUtils checkNumber1_30wei:detain]) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入正确的单位详址"];
            [dataColor replaceObjectAtIndex:4 withObject:CellBGColorRed];
        }else{
            [dataListAll replaceObjectAtIndex:4 withObject:textField.text];
            [dataColor replaceObjectAtIndex:4 withObject:UI_MAIN_COLOR];
        }
    }
    if (textField.tag == 2) {
        if (![textField.text isAreaCode]) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入正确的区号"];
            [dataColor replaceObjectAtIndex:dataColor.count-1 withObject:CellBGColorRed];
        }else{
            [dataListAll replaceObjectAtIndex:dataColor.count-1 withObject:textField.text];
            [dataColor replaceObjectAtIndex:dataColor.count-1 withObject:UI_MAIN_COLOR];
        }
    }
    [_tableView reloadData];
}

-(BOOL)isCanSelectBtn{
    
    if ([CheckUtils checkUserName:dataListAll[0]] && [dataListAll[2] length]>=2 && [dataListAll[3] length]>1 && [dataListAll[4] length]>2 && [dataListAll.lastObject isAreaCode] && [self isCommonString:dataListAll[1]]) {
        return YES;
    }else {
        return NO;
    }
    return NO;
}


//判断是否全部相等
-(BOOL)isCommonString:(NSString *)str{
    if (str.length <7 || str.length >8) {
        return NO;
    }
    char firstChar = [str characterAtIndex:0];
    for (int i = 1; i< str.length; i++) {
        if (firstChar != [str characterAtIndex:i]) {
            return YES;
        }
    }
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
