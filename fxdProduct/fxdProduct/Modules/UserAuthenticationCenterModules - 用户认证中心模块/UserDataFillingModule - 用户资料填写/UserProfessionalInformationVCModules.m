//
//  ProfessionViewController.m
//  fxdProduct
//
//  Created by dd on 2017/2/22.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "UserProfessionalInformationVCModules.h"
#import "TelPhoneCompanyCell.h"
#import "LabelCell.h"
#import "RegionBaseClass.h"
#import "RegionCodeBaseClass.h"
#import "NSString+Validate.h"
#import "SaveCustomerCarrerViewModel.h"
#import "CareerParse.h"
#import "DataDicParse.h"
#import "DataDisplayCell.h"
#import "UserPhoneContactsVCModules.h"
#import "Custom_BaseInfo.h"
#import "GetCustomerBaseViewModel.h"
#import "DataWriteAndRead.h"
#import "CustomerCareerResult.h"

#define FirstComponent 0
#define SubComponent 1
#define ThirdComponent 2
#define CellBGColorRed rgb(252, 0, 6)

@interface UserProfessionalInformationVCModules ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSArray *_placeHolderArr;
    NSInteger _pickerTag;
    NSMutableArray *_pickerArray;
    NSMutableArray *_subPickerArray;
    NSMutableArray *_thirdPickerArray;
    NSMutableArray *dataListAll;
    NSMutableArray *dataColor;
    NSInteger index;
    RegionSub *_regionSub;
    NSMutableArray *_reginListArr;
    UIButton *_saveBtn;
    RegionCodeBaseClass *_regionCodeParse;
    RegionCodeResult *_cityCode;
    //职业信息返回信息
    CareerParse *_careerParse;
    NSString *add;
    NSMutableArray *_industyList;

    NSString * _contactStatus;
}

@property (nonatomic, strong) UIPickerView *localPicker;

@end

@implementation UserProfessionalInformationVCModules

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    _pickerArray = [NSMutableArray array];
    _subPickerArray = [NSMutableArray array];
    _thirdPickerArray = [NSMutableArray array];
    _industyList =[NSMutableArray array];
    dataListAll = [NSMutableArray array];
    _reginListArr = [NSMutableArray array];
    self.navigationItem.title = @"个人信息";
    _placeHolderArr = @[@"请确保填写的均为本人真实信息",@"单位名称",@"单位电话",@"行业",@"单位所在地",@"单位详址"];
    dataColor = [NSMutableArray array];
    dataListAll = [NSMutableArray array];
    _contactStatus = @"0";
    for (int i = 0; i < 6; i++) {
        [dataListAll addObject:@""];
        [dataColor addObject:UI_MAIN_COLOR];
    }
    index = 0;
    _toolbarCancelDone.hidden = true;
    [self addBackItem];
    [self configTableView];
    [self setDataInfo];
}
-(void)viewWillAppear:(BOOL)animated{
    [self obtainUserContactInfoStatus];
}
- (void)configTableView
{
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.tableHeaderView = [self tableViewHeaderView];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TelPhoneCompanyCell class]) bundle:nil] forCellReuseIdentifier:@"TelPhoneCompanyCell"];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LabelCell class]) bundle:nil] forCellReuseIdentifier:@"LabelCell"];
    [self.tableView registerClass:[ContentTableViewCell class] forCellReuseIdentifier:@"ContentTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DataDisplayCell class]) bundle:nil] forCellReuseIdentifier:@"DataDisplayCell"];
//    if (@available(iOS 11.0, *)) {
//        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
//    }else if (@available(iOS 9.0, *)) {
//        self.automaticallyAdjustsScrollViewInsets = true;
//    }else{
//        self.automaticallyAdjustsScrollViewInsets = false;
//    }
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _k_w, 100)];
    _saveBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [footView addSubview:_saveBtn];
    [_saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [_saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [FXD_Tool setCorner:_saveBtn borderColor:[UIColor clearColor]];
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
-(UIView *)tableViewHeaderView{
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _k_w, 40)];
    
    UIImageView *iconView = [[UIImageView alloc] init];
    iconView.image = [UIImage imageNamed:@"topCellIcon"];
    [backView addSubview:iconView];
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.centerY.equalTo(backView.mas_centerY);
        make.width.equalTo(@22);
        make.height.equalTo(@22);
    }];
    UILabel *label = [[UILabel alloc] init];
    [backView addSubview:label];
    label.text = _placeHolderArr[0];
    label.textColor = [UIColor redColor];
    label.font = [UIFont systemFontOfSize:13.f];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconView.mas_right).offset(4);
        make.centerY.equalTo(backView.mas_centerY);
        //                make.bottom.equalTo(cell.contentView);
        make.height.equalTo(@30);
        make.right.equalTo(backView);
    }];
    return backView;
}
- (void)getDataDic:(void(^)())finish
{
    if (_industyList.count != 0 && _industyList != nil) {
        if (finish) {
            finish();
            return;
        }
    }
    
    UserDataViewModel * userDataVM = [[UserDataViewModel alloc]init];
    [userDataVM setBlockWithReturnBlock:^(id returnValue) {
        BaseResultModel * baseRM = returnValue;
        if ([baseRM.errCode isEqualToString:@"0"]) {
            [_industyList removeAllObjects];
            NSArray * tempArr = (NSArray *)baseRM.data;
            for (NSDictionary * dic in tempArr) {
                DataDicParse * dataParse = [[DataDicParse alloc]initWithDictionary:dic error:nil];
                [_industyList addObject:dataParse];
            }
            if (finish) {
                finish();
            }
        }else{
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:baseRM.friendErrMsg];
        }
    } WithFaileBlock:^{
        
    }];
    [userDataVM getCommonDictCodeListTypeStr:@"INDUSTRY_"];
    
}
- (void)getUserInfo:(void(^)(UserDataInformationModel * userDataInformationM))finish
{
    GetCustomerBaseViewModel *customerInfo = [[GetCustomerBaseViewModel alloc] init];
    [customerInfo setBlockWithReturnBlock:^(id returnValue) {
        BaseResultModel * baseVM = returnValue;
        if ([baseVM.errCode isEqualToString:@"0"]) {
            UserDataInformationModel * userDataIM = [[UserDataInformationModel alloc]initWithDictionary:(NSDictionary *)baseVM.data error:nil];
            [DataWriteAndRead writeDataWithkey:UserInfomation value:userDataIM];
            [FXD_Utility sharedUtility].userInfo.userIDNumber = userDataIM.id_code_;
            [FXD_Utility sharedUtility].userInfo.realName = userDataIM.customer_name_;
            [FXD_Utility sharedUtility].userInfo.account_id = userDataIM.create_by_;
            finish(userDataIM);
        }else{
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:baseVM.friendErrMsg];
        }
    } WithFaileBlock:^{
    }];
    [customerInfo fatchCustomBaseInfo:nil];
}

- (void)setDataInfo
{
    if (_careerInfo.organization_name_) {
        [dataListAll replaceObjectAtIndex:0 withObject:_careerInfo.organization_name_];
    }
    if (_careerInfo.organization_telephone_) {
        if ([_careerInfo.organization_telephone_ length]>9) {
            NSString *telString= _careerInfo.organization_telephone_;
            NSArray *telArray = [telString componentsSeparatedByString:@"-"];
            if (telArray.count >1) {
                if ([telArray[0] isAreaCode]) {
                    [dataListAll replaceObjectAtIndex:5 withObject:telArray[0]];
                }
                if ([self isCommonString:telArray[1]]) {
                    [dataListAll replaceObjectAtIndex:1 withObject:telArray[1]];
                }
            }else{
                telString = [_careerInfo.organization_telephone_ areaCodeFormat];
                NSArray *telArray1 = [telString componentsSeparatedByString:@"-"];
                if ([telArray1[0] isAreaCode]) {
                    [dataListAll replaceObjectAtIndex:5 withObject:telArray1[0]];
                }
                if ([self isCommonString:telArray1[1]]) {
                    [dataListAll replaceObjectAtIndex:1 withObject:telArray1[1]];
                }
            }
        }else{
            if ([self isCommonString:_careerInfo.organization_telephone_]) {
                [dataListAll replaceObjectAtIndex:1 withObject:_careerInfo.organization_telephone_];
            }
        }
    }
    //行业
    if (_careerInfo.industry_) {
        NSInteger tagflag = [_careerInfo.industry_ integerValue];
            [self getDataDic:^{
                [_industyList enumerateObjectsUsingBlock:^(DataDicParse * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if (tagflag == obj.code_.integerValue) {
                        [dataListAll replaceObjectAtIndex:2 withObject:obj.desc_];
                        [_tableView reloadData];
                    }
                }];
            }];
    }
    if (_careerInfo.city_name_ && _careerInfo.province_name_ && _careerInfo.country_name_){
        NSString  *addree = @"";
        add = [NSString stringWithFormat:@"%@/%@/%@",_careerInfo.province_name_,
                         _careerInfo.city_name_,_careerInfo.country_name_];
        if ([_careerInfo.city_name_ isEqualToString: _careerInfo.province_name_]) {
            addree = [NSString stringWithFormat:@"%@/%@",
                      _careerInfo.city_name_,_careerInfo.country_name_];
        }else if ([_careerInfo.city_name_ isEqualToString: _careerInfo.country_name_]){
            addree = [NSString stringWithFormat:@"%@/%@",_careerInfo.province_name_,
                      _careerInfo.city_name_];
        }else{
            addree = [NSString stringWithFormat:@"%@/%@/%@",_careerInfo.province_name_,
                      _careerInfo.city_name_,_careerInfo.country_name_];
        }
        [dataListAll replaceObjectAtIndex:3 withObject:addree];
    }
    if (_careerInfo.organization_address_) {
        [dataListAll replaceObjectAtIndex:4 withObject:_careerInfo.organization_address_];
    }
    if (add.length > 3) {
        [self PostGetCityCode:add];
    }
}

#pragma mark - 职业信息保存

- (void)saveBtnClick
{
    DLog(@"保存");
    if (_contactStatus.boolValue == false) {
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请您完善联系人资料！"];
        return;
    }
    
    if ([_cityCode.provinceCode isEqualToString:@""] || [_cityCode.cityCode isEqualToString:@""] || [_cityCode.districtCode isEqualToString:@""]) {
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请重新选择单位所在地"];
        return;
     }
    
    NSString *telString =[NSString stringWithFormat:@"%@-%@",dataListAll.lastObject,dataListAll[1]];
    __block NSString *profefssiontag = @"";
    
    [self getDataDic:^{
        [_industyList enumerateObjectsUsingBlock:^(DataDicParse * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([dataListAll[2] isEqualToString:obj.desc_]) {
                profefssiontag = obj.code_;
            }
        }];
    }];
    
    NSString *cityDetail = [dataListAll[4] stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *companyString  = [dataListAll[0] stringByReplacingOccurrencesOfString:@" " withString:@""];

    //职业信息保存
     SaveCustomerCarrerViewModel *saveCustomerCarrerViewModel = [[SaveCustomerCarrerViewModel alloc] init];
    [saveCustomerCarrerViewModel setBlockWithReturnBlock:^(id returnValue) {
        BaseResultModel * baseRM =returnValue;
        if ([baseRM.errCode isEqualToString:@"0"]) {
            CareerParse * careerParse = [[CareerParse alloc]initWithDictionary:(NSDictionary *)baseRM.data error:nil];
            if (self.delegate && [self.delegate respondsToSelector:@selector(setProfessRule:)]) {
                [self.delegate setProfessRule:careerParse];
            }
            [self.navigationController popViewControllerAnimated:true];
        }else{
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:baseRM.friendErrMsg];
        }
    } WithFaileBlock:^{
        
    }];
    [saveCustomerCarrerViewModel saveCustomCarrerName:companyString organization_telephone:telString industry:profefssiontag province:_cityCode.provinceCode city:_cityCode.cityCode country:_cityCode.districtCode organization_address:cityDetail product_id:_product_id];
   
}

#pragma mark->获取省市区

-(void)PostGetCity
{
    UserDataViewModel * userDataVM  = [[UserDataViewModel alloc]init];
    [userDataVM setBlockWithReturnBlock:^(id returnValue) {
        BaseResultModel * baseRM = returnValue;
        if ([baseRM.errCode isEqualToString:@"0"]) {
            NSArray *array  = (NSArray *)baseRM.data ;
            for (NSDictionary * dic  in array) {
                //取出省
                _regionSub = [[RegionSub alloc]initWithDictionary:dic error:nil];
                [_reginListArr addObject:_regionSub];
                [_pickerArray addObject:_regionSub.name];
            }
            
            //第一个省的所有区
            RegionSub *regisonSubModel = _reginListArr[0];
            for (NSDictionary * dic  in regisonSubModel.sub) {
                RegionSub * regisonSub = [[RegionSub alloc]initWithDictionary:dic error:nil];
                [_subPickerArray addObject:regisonSub.name];
            }
            
            //第一个区的县的所有县
            RegionSub *regionResultModel = [[RegionSub alloc]initWithDictionary:regisonSubModel.sub[0] error:nil];
            for (NSDictionary * dic  in regionResultModel.sub) {
                //取出市
                RegionSub * regisonSub = [[RegionSub alloc]initWithDictionary:dic error:nil];
                [_thirdPickerArray addObject:regisonSub.name];
            }
            [_localPicker reloadAllComponents];
            
        }else{
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:baseRM.friendErrMsg];
        }
    } WithFaileBlock:^{
        
    }];
    [userDataVM getAllRegionList];
}

#pragma mark - TableviewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 5;
    }else if (section == 1){
        return 1;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        return 60.f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self isCanSelectBtn]) {
        _saveBtn.enabled = true;
        [_saveBtn setBackgroundColor:UI_MAIN_COLOR];
    } else {
        _saveBtn.enabled = false;
        [_saveBtn setBackgroundColor:rgb(139, 140, 143)];
    }
    
    if (indexPath.section == 1) {
        ContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"ContentTableViewCell%ld%ld",indexPath.row,indexPath.section]];
        if (!cell) {
            cell = [[ContentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"ContentTableViewCell%ld%ld",indexPath.row,indexPath.section]];
        }
        cell.contentTextField.enabled = NO;
        cell.titleLabel.text = @"联系人信息";
        cell.promptLabel.hidden = NO;
        cell.promptLabel.text = @"未完成";
        if (_contactStatus.boolValue == true) {
            cell.promptLabel.text = @"已完成";
        }
        return cell;
    }
    
    switch (indexPath.row) {
        case 1:
        {
            TelPhoneCompanyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TelPhoneCompanyCell"];
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"TelPhoneCompanyCell" owner:self options:nil] lastObject];
            }
            cell.textfiledCode.text = dataListAll.lastObject;
            cell.textfiledCode.tag = 2;
            cell.textfiledCode.delegate = self;
            cell.textfiledCode.keyboardType = UIKeyboardTypePhonePad;
            
            cell.textfiledTel.text = dataListAll[indexPath.row];
            cell.textfiledTel.delegate = self;
            cell.textfiledTel.tag = indexPath.row + 10;
            cell.textfiledTel.keyboardType = UIKeyboardTypePhonePad;
            
            return cell;
        }
            break;
        case 0:
        case 2:
        case 3:
        case 4:
        {
            
            ContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"ContentTableViewCell%ld%ld",indexPath.row,indexPath.section]];
            if (!cell) {
                cell = [[ContentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"ContentTableViewCell%ld%ld",indexPath.row,indexPath.section]];
            }
            cell.contentTextField.enabled = YES;
            if (indexPath.row == 2 || indexPath.row == 3) {
                cell.contentTextField.enabled = NO;
                cell.contentTextField.placeholder = @"点击选择";
            }

            cell.selectionStyle  = UITableViewCellSelectionStyleNone;
            cell.titleLabel.text = _placeHolderArr[indexPath.row + 1];
            cell.contentTextField.tag = indexPath.row + 10;
            cell.contentTextField.delegate = self;
            cell.contentTextField.text = dataListAll[indexPath.row];
            cell.arrowsImageBtn.tag = 200 + indexPath.row;
            cell.arrowsImageBtn.hidden = NO;
            if (indexPath.row == 0 || indexPath.row == 4) {
                cell.arrowsImageBtn.hidden = YES;
            }
            return cell;
        }
            break;
            
        default:
            break;
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        [self getUserInfo:^(UserDataInformationModel * userDataInformationM) {
            UserPhoneContactsVCModules *userContactVC = [[UserPhoneContactsVCModules alloc] init];
            userContactVC.custom_baseInfo = userDataInformationM;
            [self.navigationController pushViewController:userContactVC animated:true];
        }];
        return;
    }
    if (indexPath.section == 0) {
        if (indexPath.row == 2) {
            [self getDataDic:^{
                [self createPickViewShowWithTag:202];
            }];
        }
        if (indexPath.row == 3) {
            if (_pickerArray.count != 34) {
                [self PostGetCity];
            }
            [self createPickViewShowWithTag:203];
        }
    }
}

- (IBAction)doneAction:(id)sender {
    NSString *localString = @"";
    NSString *loString = @"";
    if (_pickerTag == 203) {
        
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
        [dataListAll replaceObjectAtIndex:3 withObject:localString];
        [dataColor replaceObjectAtIndex:3 withObject:UI_MAIN_COLOR];
        //第一个省的所有区
        [_subPickerArray removeAllObjects];
        RegionSub *regisonSubModel = _reginListArr[0];
        for (NSDictionary * dic  in regisonSubModel.sub) {
            RegionSub * regisonSub = [[RegionSub alloc]initWithDictionary:dic error:nil];
            [_subPickerArray addObject:regisonSub.name];
        }
        //第一个区的县的所有县
        [_thirdPickerArray removeAllObjects];
        RegionSub *regionResultModel = [[RegionSub alloc]initWithDictionary:regisonSubModel.sub[0] error:nil];
        for (NSDictionary * dic  in regionResultModel.sub) {
            //取出市
            RegionSub * regisonSub = [[RegionSub alloc]initWithDictionary:dic error:nil];
            [_thirdPickerArray addObject:regisonSub.name];
        }
        [self PostGetCityCode:loString];
    }else {
        if ([dataListAll[2] isEqualToString:@""]) {
            DataDicParse * dataParse = _industyList.firstObject;
            [dataListAll replaceObjectAtIndex:2 withObject:dataParse.desc_];
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

-(void)obtainUserContactInfoStatus{
    UserDataViewModel * userDataVM1 = [[UserDataViewModel alloc]init];
    [userDataVM1 setBlockWithReturnBlock:^(id returnValue) {
        BaseResultModel * resultM = [[BaseResultModel alloc]initWithDictionary:returnValue error:nil];
        if ([resultM.errCode isEqualToString:@"0"]) {
            NSDictionary * dic = (NSDictionary *)resultM.data;
            if ([dic.allKeys containsObject:@"complete"]) {
                _contactStatus = dic[@"complete"];
                [self.tableView reloadData];
            }
        }else {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:resultM.msg];
        }
    } WithFaileBlock:^{
        
    }];
    [userDataVM1 obtainContactInfoStatus];
}
#pragma mark ->获取省市区代码
-(void)PostGetCityCode:(NSString *)datalisCity
{
    UserDataViewModel * userDataVM  = [[UserDataViewModel alloc]init];
    [userDataVM setBlockWithReturnBlock:^(id returnValue) {
        BaseResultModel * baseRM = returnValue;
        if ([baseRM.errCode isEqualToString:@"0"]) {
            _cityCode = [[RegionCodeResult alloc]initWithDictionary:(NSDictionary *)baseRM.data error:nil];
        }else{
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:baseRM.friendErrMsg];
        }
    } WithFaileBlock:^{
        
    }];
    [userDataVM getRegionCodeByAreaName:datalisCity];
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
        case 202: //行业
        {
            _pickerTag = tag;
            _localPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, _k_h - 183 - [self obtainNaviBarHeight], _k_w, 183)];
            _localPicker.backgroundColor = [UIColor whiteColor];
            _localPicker.dataSource = self;
            _localPicker.delegate = self;
            [self.view addSubview:_localPicker];
        }
            break;
        case 203: //单位地址
        {
            _pickerTag = tag;
            _localPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, _k_h-183 - [self obtainNaviBarHeight], _k_w, 183)];
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
    if (_pickerTag == 202) {
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
    if (_pickerTag == 202)
    {
        return _industyList.count;
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
    if (_pickerTag == 202)
    {
        DataDicParse * dataParse = _industyList[row];
        return dataParse.desc_;
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
    if (_pickerTag == 202) {
        DataDicParse * dataParse = _industyList[row];
        [dataListAll replaceObjectAtIndex:2 withObject:dataParse.desc_];
    }else{
        if (component == 0) {
            //第一个省的所有区
            index = row;
            [_subPickerArray removeAllObjects];
            _regionSub = _reginListArr[row];
            
            for (NSDictionary * dic  in _regionSub.sub) {
                RegionSub * regisonSub = [[RegionSub alloc]initWithDictionary:dic error:nil];
                [_subPickerArray addObject:regisonSub.name];
            }
            
            //第一个区的县的所有县
            [_thirdPickerArray removeAllObjects];
            RegionSub * thirdRegisonSub = [[RegionSub alloc]initWithDictionary:_regionSub.sub[0] error:nil];
            for (NSDictionary * dic  in thirdRegisonSub.sub) {
                //取出市
                RegionSub * regisonSub = [[RegionSub alloc]initWithDictionary:dic error:nil];
                [_thirdPickerArray addObject:regisonSub.name];
            }
            
            [pickerView selectedRowInComponent:1];
            [pickerView reloadComponent:0];
            [pickerView reloadComponent:1];
            [pickerView selectedRowInComponent:2];
        }
        if (component == 1) {
            
            [_subPickerArray removeAllObjects];
            _regionSub = _reginListArr[index];
            for (NSDictionary * dic  in _regionSub.sub) {
                RegionSub * regisonSub = [[RegionSub alloc]initWithDictionary:dic error:nil];
                [_subPickerArray addObject:regisonSub.name];
            }
            //第一个区的县的所有县
            [_thirdPickerArray removeAllObjects];
            RegionSub *regionResultModel;
            if (row > _regionSub.sub.count - 1) {
                //            regionResultModel = _regionSub.sub[0];
                regionResultModel = [[RegionSub alloc]initWithDictionary:_regionSub.sub[0] error:nil];
            }else{
                //            regionResultModel = _regionSub.sub[row];
                regionResultModel = [[RegionSub alloc]initWithDictionary:_regionSub.sub[row] error:nil];
            }
            for (NSDictionary * dic in regionResultModel.sub) {
                //取出市
                RegionSub * regisonSub = [[RegionSub alloc]initWithDictionary:dic error:nil];
                [_thirdPickerArray addObject:regisonSub.name];
            }
            
            [pickerView selectRow:0 inComponent:2 animated:YES];
        }
        [pickerView reloadComponent:2];
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if (_pickerTag == 202) {
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
    if (textField.tag == 12 || textField.tag == 13) {
        return NO;
    }
    
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag == 10) {
        if (![CheckUtils checkUserName:textField.text]) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入正确的单位名称"];
            [dataColor replaceObjectAtIndex:0 withObject:CellBGColorRed];
        }else{
            [dataListAll replaceObjectAtIndex:0 withObject:textField.text];
            [dataColor replaceObjectAtIndex:0 withObject:UI_MAIN_COLOR];
        }
    }
    if (textField.tag == 11) {
        if (![self isCommonString:textField.text]) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入正确的单位电话"];
            [dataColor replaceObjectAtIndex:1 withObject:CellBGColorRed];
        }else{
            [dataListAll replaceObjectAtIndex:1 withObject:textField.text];
            [dataColor replaceObjectAtIndex:1 withObject:UI_MAIN_COLOR];
        }
    }
    if (textField.tag == 12) {
        if (textField.text.length < 5) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请选择正确的行业/职业"];
            [dataColor replaceObjectAtIndex:2 withObject:CellBGColorRed];
        }else{
            [dataListAll replaceObjectAtIndex:2 withObject:textField.text];
            [dataColor replaceObjectAtIndex:2 withObject:UI_MAIN_COLOR];
        }
    }
    if (textField.tag == 13) {
        if (textField.text.length < 5) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请选择正确的单位所在地"];
            [dataColor replaceObjectAtIndex:3 withObject:CellBGColorRed];
        }else{
            [dataListAll replaceObjectAtIndex:3 withObject:textField.text];
            [dataColor replaceObjectAtIndex:3 withObject:UI_MAIN_COLOR];
        }
    }
    if (textField.tag == 14) {
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
