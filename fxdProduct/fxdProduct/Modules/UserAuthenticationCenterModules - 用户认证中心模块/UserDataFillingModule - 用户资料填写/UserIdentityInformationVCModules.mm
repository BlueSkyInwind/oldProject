//
//  PserInfoViewController.m
//  fxdProduct
//
//  Created by dd on 2017/2/22.
//  Copyright © 2017年 dd. All rights reserved.
//


#import "UserIdentityInformationVCModules.h"
#import "IdentityCell.h"
#import "LabelCell.h"
#import "RegionBaseClass.h"
#import "RegionCodeBaseClass.h"
#import "ColledgeView.h"
#import "FaceIDOCRFront.h"
#import "FaceIDOCRBack.h"
#import <MGBaseKit/MGBaseKit.h>
#import <MGIDCard/MGIDCard.h>
#import "SaveCustomBaseViewModel.h"
#import "GTMBase64.h"
#import "Custom_BaseInfo.h"
#import "CustomerIDInfo.h"
#import "DataDicParse.h"


#define FirstComponent 0
#define SubComponent 1
#define ThirdComponent 2
#define CellBGColorRed rgb(252, 0, 6)

@interface UserIdentityInformationVCModules ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,ColledgeViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSArray *_placeHolderArr;
    NSMutableArray *dataColor;
    NSMutableArray *dataListArr;
    RegionBaseClass *_reginBase;
    RegionSub *_regionSub;
    RegionResult *_regionResult;
    NSMutableArray *_pickerArray;
    NSMutableArray *_subPickerArray;
    NSMutableArray *_thirdPickerArray;
    RegionCodeBaseClass *_regionCodeParse;
    RegionCodeResult *_cityCode;
    ColledgeView *_colledgeView;
    NSInteger index;
    UIButton *_saveBtn;
    FaceIDOCRFront *_idOCRFrontParse;
    FaceIDOCRBack *_idOCRBackParse;
    NSDictionary *_eduLevelDic;
    NSString *_poro;
    CustomerIDInfo *_customerFrontIDParse;
    CustomerIDInfo *_customerBackIDParse;
    DataDicParse *_dataDicEduLevel;
}



@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) UIPickerView *localPicker;

@end

@implementation UserIdentityInformationVCModules

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"身份信息";
     _placeHolderArr = @[@[@"请确保填写的均为本人真实信息",@"身份证识别"],@[@"姓名",@"身份证号"],@[@"学历",@"现居住地",@"居住地详址"]];
    NSString *device = [[UIDevice currentDevice] systemVersion];
    index = 0;
    _pickerArray = [NSMutableArray array];
    _subPickerArray = [NSMutableArray array];
    _thirdPickerArray = [NSMutableArray array];
    dataListArr = [NSMutableArray array];
    dataColor = [NSMutableArray array];
    _eduLevelDic = @{@"博士及以上":@"1",
                     @"硕士":@"2",
                     @"本科":@"3",
                     @"大专":@"4",
                     @"高中":@"5"};
    for (int i = 0; i < 6; i++) {
        [dataColor addObject:UI_MAIN_COLOR];
        [dataListArr addObject:@""];
    }
    _toolbarCancelDone.hidden = true;
    
    [self configTableView];
    [self addBackItem];
    [self setValueOfDataArr];
}

- (void)getCodeDic:(void(^)())finish
{
    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_getDicCode_url] parameters:@{@"dict_type_":@"EDUCATION_LEVEL_"} finished:^(EnumServerStatus status, id object) {
        DLog(@"%@",object);
        
        if (![[object objectForKey:@"flag"] isEqualToString:@"0000"]) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:[object objectForKey:@"msg"]];
        }else {
            _dataDicEduLevel = [DataDicParse yy_modelWithJSON:object];
            if (finish) {
                finish();
            }
        }
    } failure:^(EnumServerStatus status, id object) {
    }];
}

- (void)configTableView
{
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableView.showsVerticalScrollIndicator = NO;
// self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 0.0001)];
    self.tableView.tableHeaderView = [self tableViewHeaderView];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([IdentityCell class]) bundle:nil] forCellReuseIdentifier:@"IdentityCell"];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LabelCell class]) bundle:nil] forCellReuseIdentifier:@"LabelCell"];
    [self.tableView registerClass:[ContentTableViewCell class] forCellReuseIdentifier:@"ContentTableViewCell"];
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.tableView.contentInset = UIEdgeInsetsMake(BarHeightNew, 0, 0, 0);
    }else if (@available(iOS 9.0, *)) {
        self.automaticallyAdjustsScrollViewInsets = true;
    }else{
        self.automaticallyAdjustsScrollViewInsets = false;
    }
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _k_w, 100)];
    _saveBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [footView addSubview:_saveBtn];
    _saveBtn.enabled = false;
    [_saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [_saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [Tool setCorner:_saveBtn borderColor:[UIColor clearColor]];
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
    label.text = _placeHolderArr[0][0];
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


//拉取用户信息
- (void)setValueOfDataArr
{
    NSString *eduLevel = _custom_baseInfo.result.educationLevel;
    if (eduLevel) {
//        [_eduLevelDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
//            if ([eduLevel isEqualToString:obj]) {
//                [dataListArr replaceObjectAtIndex:3 withObject:key];
//            }
//        }];
        if (_dataDicEduLevel) {
            [_dataDicEduLevel.result enumerateObjectsUsingBlock:^(DataDicResult * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([eduLevel isEqualToString:obj.code_]) {
                    [dataListArr replaceObjectAtIndex:3 withObject:obj.desc_];
                    [_tableView reloadData];
                }
            }];
        } else {
            [self getCodeDic:^{
                [_dataDicEduLevel.result enumerateObjectsUsingBlock:^(DataDicResult * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if ([eduLevel isEqualToString:obj.code_]) {
                        [dataListArr replaceObjectAtIndex:3 withObject:obj.desc_];
                        [_tableView reloadData];
                    }
                }];
            }];
        }
    }
    if (_custom_baseInfo.result.province != nil && _custom_baseInfo.result.city != nil && _custom_baseInfo.result.county != nil) {
        NSString *proviece_city = @"";
        _poro = [NSString stringWithFormat:@"%@/%@/%@",_custom_baseInfo.result.provinceName,_custom_baseInfo.result.cityName,_custom_baseInfo.result.countyName];
        
        if ([_custom_baseInfo.result.provinceName isEqualToString: _custom_baseInfo.result.cityName]) {
            proviece_city = [NSString stringWithFormat:@"%@/%@",_custom_baseInfo.result.cityName,_custom_baseInfo.result.countyName];
        }else if ([_custom_baseInfo.result.countyName isEqualToString: _custom_baseInfo.result.cityName]){
            proviece_city = [NSString stringWithFormat:@"%@/%@",_custom_baseInfo.result.provinceName,_custom_baseInfo.result.cityName];
        }else{
            proviece_city = [NSString stringWithFormat:@"%@/%@/%@",_custom_baseInfo.result.provinceName,_custom_baseInfo.result.cityName,_custom_baseInfo.result.countyName];
        }
        [dataListArr replaceObjectAtIndex:4 withObject:proviece_city];
    }
    if (_custom_baseInfo.result.homeAddress) {
        [dataListArr replaceObjectAtIndex:5 withObject:_custom_baseInfo.result.homeAddress];
    }
    
    if (_custom_baseInfo.result.ocrStatus == 2) {
//        [dataListArr replaceObjectAtIndex:0 withObject:_custom_baseInfo.result.customerName];
        [dataListArr replaceObjectAtIndex:1 withObject:_custom_baseInfo.result.customerName];
        [dataListArr replaceObjectAtIndex:2 withObject:_custom_baseInfo.result.idCode];
    }
    if (_poro.length > 3) {
        [self PostGetCityCode:_poro];
    }
    [_tableView reloadData];
    
}

- (NSDictionary *)getPersonInfo
{
    __block NSString *degree = @"";
    if (_dataDicEduLevel) {
        [_dataDicEduLevel.result enumerateObjectsUsingBlock:^(DataDicResult * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.desc_ isEqualToString:dataListArr[3]]) {
                degree = obj.code_;
            }
        }];
    } else {
        [self getCodeDic:^{
            [_dataDicEduLevel.result enumerateObjectsUsingBlock:^(DataDicResult * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj.desc_ isEqualToString:dataListArr[3]]) {
                    degree = obj.code_;
                }
            }];
        }];
    }
//    [_eduLevelDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
//        if ([key isEqualToString:dataListArr[3]]) {
//            degree = obj;
//        }
//    }];
    NSString *addressDetail = [dataListArr[5] stringByReplacingOccurrencesOfString:@" " withString:@""];
    
//    [Utility sharedUtility].userInfo.userIDNumber = dataListArr[0];
//    [Utility sharedUtility].userInfo.realName = dataListArr[2];
    NSDictionary *paramDic = @{@"customer_name_":dataListArr[1],
                               @"id_code_":dataListArr[2],
                               @"education_level_":degree,
                               @"home_address_":addressDetail,
                               @"province_":_cityCode.provinceCode,
                               @"city_":_cityCode.cityCode,
                               @"county_":_cityCode.districtCode
                               };
    
    return paramDic;
}

#pragma mark -> 个人信息保存接口
- (void)saveBtnClick
{
    DLog(@"保存");
    if (![_cityCode.provinceCode isEqualToString:@""] && ![_cityCode.cityCode isEqualToString:@""] && ![_cityCode.districtCode isEqualToString:@""]) {
        NSDictionary *paramDic = [self getPersonInfo];
        SaveCustomBaseViewModel *saveCustomBaseViewModel = [[SaveCustomBaseViewModel alloc] init];
        [saveCustomBaseViewModel setBlockWithReturnBlock:^(id returnValue) {
            if ([[returnValue valueForKey:@"flag"] isEqualToString:@"0000"]) {
                [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:[returnValue objectForKey:@"msg"]];
                [self.navigationController popViewControllerAnimated:true];
            } else {
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:[returnValue objectForKey:@"msg"]];
            }
        } WithFaileBlock:^{
            
        }];
        [saveCustomBaseViewModel saveCustomBaseInfo:paramDic];
    } else {
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请重新选择现居地址"];
    }
}

#pragma mark - TableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 2;
    }else{
        return 3;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 && indexPath.section == 0) {
        return 70.f;
    } else {
        return 60.f;
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
    switch (indexPath.section) {
        case 0:{
                IdentityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IdentityCell"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                [cell.identityUpBtn addTarget:self action:@selector(identityUpBtnClick) forControlEvents:UIControlEventTouchUpInside];
                [cell.identityBackBtn addTarget:self action:@selector(identityBackBtnClick) forControlEvents:UIControlEventTouchUpInside];
                if (_idOCRFrontParse != nil || _custom_baseInfo.result.ocrStatus == 2) {
                    [cell.identityUpBtn setBackgroundImage:[UIImage imageNamed:@"identitySelUp"] forState:UIControlStateNormal];
                    cell.identityUpBtn.enabled = false;
                }else {
                    [cell.identityUpBtn setBackgroundImage:[UIImage imageNamed:@"identityUpUn"] forState:UIControlStateNormal];
                    cell.identityUpBtn.enabled = true;
                }
                if (_idOCRBackParse != nil || _custom_baseInfo.result.ocrStatus == 2) {
                    [cell.identityBackBtn setBackgroundImage:[UIImage imageNamed:@"identitySelBack"] forState:UIControlStateNormal];
                    cell.identityBackBtn.enabled = false;
                } else {
                    [cell.identityBackBtn setBackgroundImage:[UIImage imageNamed:@"identityUnBack"] forState:UIControlStateNormal];
                    cell.identityBackBtn.enabled = true;
                }
                if (!cell.identityUpBtn.isEnabled && !cell.identityBackBtn.isEnabled) {
                    cell.identityLabel.textColor = UI_MAIN_COLOR;
                }
                //        [Tool setCorner:cell.bgView borderColor:dataColor[indexPath.row-1]];
                return cell;
        }
            break;
        case 1:{
            ContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"ContentTableViewCell%ld%ld",indexPath.row,indexPath.section]];
            if (!cell) {
                cell = [[ContentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"ContentTableViewCell%ld%ld",indexPath.row,indexPath.section]];
            }
            cell.titleLabel.text = _placeHolderArr[indexPath.section][indexPath.row];
            cell.contentTextField.tag = indexPath.row +(100 * indexPath.section);
            cell.contentTextField.delegate = self;
            cell.contentTextField.text = dataListArr[indexPath.row+1];
            cell.arrowsImageBtn.hidden = YES;
            cell.selectionStyle  = UITableViewCellSelectionStyleNone;
            return cell;
        }
            break;
        case 2:{
             ContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"ContentTableViewCell%ld%ld",indexPath.row,indexPath.section]];
            if (!cell) {
                cell = [[ContentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"ContentTableViewCell%ld%ld",indexPath.row,indexPath.section]];
            }
            if (indexPath.row == 2) {
                cell.arrowsImageBtn.hidden = YES;
                cell.contentTextField.enabled = YES;
            }else{
                cell.arrowsImageBtn.hidden = NO;
                cell.contentTextField.enabled = NO;
                cell.contentTextField.placeholder = @"点击选择";
            }
            cell.titleLabel.text = _placeHolderArr[indexPath.section][indexPath.row];
            cell.contentTextField.tag = indexPath.row +(100 * indexPath.section);;
            cell.contentTextField.delegate = self;
            cell.contentTextField.text = dataListArr[indexPath.row+3];
            cell.selectionStyle  = UITableViewCellSelectionStyleNone;
            
            return cell;
        }
            break;
        default:
            break;
    }
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section != 2) {
        return;
    }
    if (indexPath.row == 0) {
        [self.view endEditing:YES];
        if (_dataDicEduLevel) {
            _colledgeView = [[[NSBundle mainBundle] loadNibNamed:@"ColledgeView" owner:self options:nil] lastObject];
            _colledgeView.frame = CGRectMake(0, 0, _k_w, _k_h);
            _colledgeView.dataDic = _dataDicEduLevel;
            _colledgeView.delegate = self;
            [_colledgeView show];
        } else {
            [self getCodeDic:^{
                _colledgeView = [[[NSBundle mainBundle] loadNibNamed:@"ColledgeView" owner:self options:nil] lastObject];
                _colledgeView.frame = CGRectMake(0, 0, _k_w, _k_h);
                _colledgeView.dataDic = _dataDicEduLevel;
                _colledgeView.delegate = self;
                [_colledgeView show];
            }];
        }
    }else if (indexPath.row == 1){
        DLog(@"现居地址");
        if (_pickerArray.count != 34) {
            [self PostGetCity];
        }
        [self createPickViewShowWithTag];
    }
}
- (void)identityUpBtnClick
{
    DLog(@"正面");
    [self license:IDCARD_SIDE_FRONT];
}

- (void)identityBackBtnClick
{
    DLog(@"反面");
    [self license:IDCARD_SIDE_BACK];
}

- (void)license:(MGIDCardSide)CardSide
{
    [MGLicenseManager licenseForNetWokrFinish:^(bool License) {
        if (License) {
            DLog(@"授权成功");
            [self checkIDCard:CardSide];
        } else {
            DLog(@"授权失败");
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"授权失败"];
        }
    }];
}

#pragma mark - OCR识别结果
- (void)checkIDCard:(MGIDCardSide)CardSide
{
    NSLog(@"%@",[MGIDCardManager IDCardVersion]);
    __unsafe_unretained UserIdentityInformationVCModules *weakSelf = self;
    BOOL idcard = [MGIDCardManager getLicense];
    if (!idcard) {
        [[[UIAlertView alloc] initWithTitle:@"提示" message:@"SDK授权失败，请检查" delegate:self cancelButtonTitle:@"完成" otherButtonTitles:nil, nil] show];
        return;
    }
    
    MGIDCardManager *cardManager = [[MGIDCardManager alloc] init];
    [cardManager IDCardStartDetection:self IdCardSide:CardSide
                               finish:^(MGIDCardModel *model) {
                                   //                                   weakSelf.cardView.image = [model croppedImageOfIDCard];
                                   [weakSelf verifyIDCard:[model croppedImageOfIDCard] cardSide:CardSide];
                               }
                                 errr:^(MGIDCardError) {
                                     //                                     weakSelf.cardView.image = nil;
                                     //                                     DLog(@"%ld",MGIDCardError);
                                 }];
}
- (void)verifyIDCard:(UIImage *)image cardSide:(MGIDCardSide)cardSide
{
    __unsafe_unretained UserIdentityInformationVCModules *weakSelf = self;
    //    UIImageJPEGRepresentation(image, 0.2)
    NSDictionary *paramDic = @{@"api_key":FaceIDAppKey,
                               @"api_secret":FaceIDAppSecret,
                               @"legality":@1};
    NSDictionary *imageDic = @{@"image":UIImagePNGRepresentation(image)};
    [[FXDNetWorkManager sharedNetWorkManager] POSTUpLoadImage:_detectIDCardOCR_url FilePath:imageDic parameters:paramDic finished:^(EnumServerStatus status, id object) {
        DLog(@"%@",object);
        if (cardSide == IDCARD_SIDE_FRONT) {
            _idOCRFrontParse = [FaceIDOCRFront yy_modelWithJSON:object];
            [weakSelf saveUserIDCardImage:image carSide:@"front" faceResult:object];
        }
        if (cardSide == IDCARD_SIDE_BACK) {
            _idOCRBackParse = [FaceIDOCRBack yy_modelWithJSON:object];
            [weakSelf saveUserIDCardImage:image carSide:@"back" faceResult:object];
        }
        
    } failure:^(EnumServerStatus status, id object) {
        NSError *error = object;
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:[NSString stringWithFormat:@"Error-%ld",(long)error.code]];
    }];
}

- (void)saveUserIDCardImage:(UIImage *)image carSide:(NSString *)side faceResult:(id)result
{
    __unsafe_unretained UserIdentityInformationVCModules *weakSelf = self;
    NSData *data = UIImageJPEGRepresentation(image, 0.2);
    NSString *cardStr = [GTMBase64 stringByEncodingData:data];
    
    NSDictionary *dic = [NSDictionary dictionaryWithDictionary:result];
    NSData *resultData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonStr = [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
    
    NSDictionary *paramDic = @{@"idCardSelf":cardStr,
                               @"records":jsonStr,
                               @"side":side};
    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_saveIDInfo_url] parameters:paramDic finished:^(EnumServerStatus status, id object) {
        DLog(@"%@",object);
        if ([side isEqualToString:@"front"]) {
            _customerFrontIDParse = [CustomerIDInfo yy_modelWithJSON:object];
            if ([_customerFrontIDParse.flag isEqualToString:@"0000"]) {
                [weakSelf setUserIDCardInfo];
            } else {
                [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:_customerFrontIDParse.msg];
            }
        }
        if ([side isEqualToString:@"back"]) {
            _customerBackIDParse = [CustomerIDInfo yy_modelWithJSON:object];
            if ([_customerBackIDParse.flag isEqualToString:@"0000"]) {
                [weakSelf setUserIDCardInfo];
            } else {
                [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:_customerBackIDParse.msg];
            }
        }
        
    } failure:^(EnumServerStatus status, id object) {
        
    }];
}

- (void)setUserIDCardInfo
{
    if (_idOCRFrontParse != nil && _idOCRBackParse != nil) {
//        [dataListArr replaceObjectAtIndex:0 withObject:_customerIDParse.result.customer_name_];
        [dataListArr replaceObjectAtIndex:1 withObject:_customerFrontIDParse.result.customer_name_];
        [dataListArr replaceObjectAtIndex:2 withObject:_customerFrontIDParse.result.id_code_];
        [Utility sharedUtility].userInfo.userIDNumber = _customerFrontIDParse.result.id_code_;
        [Utility sharedUtility].userInfo.realName = _customerFrontIDParse.result.customer_name_;
    }
    [_tableView reloadData];
}

#pragma mark - UITextFieldDelegate

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    DLog(@"%ld",textField.tag);
    
    if (textField.tag == 200 || textField.tag == 201) {
        return NO;
    }
    
    if (textField.tag == 100) {
        if (_customerFrontIDParse.result.editable_field_ && _customerFrontIDParse.result.editable_field_.length > 2) {
            if ([_customerFrontIDParse.result.editable_field_ containsString:@"customer_name_"]) {
                return true;
            }else {
                return false;
            }
        } else {
            return false;
        }
    }
    if (textField.tag == 101) {
        if (_customerFrontIDParse.result.editable_field_ && _customerFrontIDParse.result.editable_field_.length > 2) {
            if ([_customerFrontIDParse.result.editable_field_ containsString:@"id_code_"]) {
                return true;
            }else {
                return false;
            }
        } else {
            return false;
        }
    }
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *stringLength=[NSString stringWithFormat:@"%@%@",textField.text,string];
    if(textField.tag == 101)
    {
        if ([stringLength length]>18) {
            return NO;
        }
    }
    if (textField.tag == 200 || textField.tag == 201) {
        return NO;
    }
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag == 100) {
        if (![CheckUtils checkUserNameHanzi:textField.text]) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入正确的姓名"];
            [dataColor replaceObjectAtIndex:1 withObject:CellBGColorRed];
            [dataListArr replaceObjectAtIndex:1 withObject:@""];
        }else{
            [dataListArr replaceObjectAtIndex:1 withObject:textField.text];
            [dataColor replaceObjectAtIndex:1 withObject:UI_MAIN_COLOR];
        }
    }
    if (textField.tag == 101) {
        if (![CheckUtils checkUserIdCard:textField.text]) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入正确的身份证号"];
            [dataColor replaceObjectAtIndex:2 withObject:CellBGColorRed];
            [dataListArr replaceObjectAtIndex:2 withObject:@""];
        }else{
            [dataListArr replaceObjectAtIndex:2 withObject:textField.text];
            [dataColor replaceObjectAtIndex:2 withObject:UI_MAIN_COLOR];
        }
    }
    if (textField.tag == 200) {
        if (textField.text.length <1) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请选择正确的学历"];
            [dataColor replaceObjectAtIndex:3 withObject:CellBGColorRed];
        }else{
            [dataListArr replaceObjectAtIndex:3 withObject:textField.text];
            [dataColor replaceObjectAtIndex:3 withObject:UI_MAIN_COLOR];
        }
    }
    if (textField.tag == 201) {
        if (textField.text.length <2) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请选择正确的现居住地"];
            [dataColor replaceObjectAtIndex:4 withObject:CellBGColorRed];
        }else{
            [dataListArr replaceObjectAtIndex:4 withObject:textField.text];
            [dataColor replaceObjectAtIndex:4 withObject:UI_MAIN_COLOR];
        }
    }
    if (textField.tag == 202) {
        NSString *deta = [textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        if (![CheckUtils checkUserDetail:deta] || [CheckUtils checkNumber1_30wei:deta]) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请选择正确的居住地详址"];
            [dataColor replaceObjectAtIndex:5 withObject:CellBGColorRed];
        }else{
            [dataListArr replaceObjectAtIndex:5 withObject:textField.text];
            [dataColor replaceObjectAtIndex:5 withObject:UI_MAIN_COLOR];
        }
    }
    if (textField.tag >= 100 && textField.tag <= 202)
    {
        if ([self isCanSelectBtn]) {
            NSIndexPath *indexPat=[NSIndexPath indexPathForRow:textField.tag % 100 inSection:textField.tag / 100];
            NSArray *indexArray=[NSArray arrayWithObject:indexPat];
            [_tableView reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationAutomatic];
        } else {
            [_tableView reloadData];
        }
    }
}

-(BOOL)isCanSelectBtn{
    
    if ([CheckUtils checkUserNameHanzi:[dataListArr objectAtIndex:1]] && [CheckUtils checkUserIdCard:[dataListArr objectAtIndex:2]] && [[dataListArr objectAtIndex:3] length] >1 && [[dataListArr objectAtIndex:4] length] >1&&[[dataListArr objectAtIndex:5] length] > 1) {
        for (int i=1; i<5; i++) {
            [dataColor replaceObjectAtIndex:i withObject:UI_MAIN_COLOR];
        }
        
        return YES;
    }else {
        
        return NO;
    }
}

-(void)senderBtn:(UIButton *)sender
{
    switch (sender.tag) {
        case 14:
        {
            [self.view endEditing:YES];
            if (_dataDicEduLevel) {
                _colledgeView = [[[NSBundle mainBundle] loadNibNamed:@"ColledgeView" owner:self options:nil] lastObject];
                _colledgeView.frame = CGRectMake(0, 0, _k_w, _k_h);
                _colledgeView.dataDic = _dataDicEduLevel;
                _colledgeView.delegate = self;
                [_colledgeView show];
            } else {
                [self getCodeDic:^{
                    _colledgeView = [[[NSBundle mainBundle] loadNibNamed:@"ColledgeView" owner:self options:nil] lastObject];
                    _colledgeView.frame = CGRectMake(0, 0, _k_w, _k_h);
                    _colledgeView.dataDic = _dataDicEduLevel;
                    _colledgeView.delegate = self;
                    [_colledgeView show];
                }];
            }
           
        }
            break;
        case 15:
        {
            DLog(@"现居地址");
            if (_pickerArray.count != 34) {
                [self PostGetCity];
            }
            [self createPickViewShowWithTag];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - 创建PIckView --UIPickerViewDelegate
-(void)createPickViewShowWithTag
{
    [self.view endEditing:YES];
    [self setRomovePickView];
    
    //    _pickerTag = tag;
    _localPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, _k_h-183, _k_w, 183)];
    _localPicker.backgroundColor = [UIColor whiteColor];
    _localPicker.dataSource = self;
    _localPicker.delegate = self;
    [self.view addSubview:_localPicker];
    //        case 208://现在居住地址
    //        {
    //            _pickerTag = tag;
    //            _localPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, _k_h-183, _k_w, 183)];
    //            _localPicker.backgroundColor = [UIColor whiteColor];
    //            _localPicker.dataSource = self;
    //            _localPicker.delegate = self;
    //            [self.view addSubview:_localPicker];
    //        }
}

-(void)setRomovePickView
{
    _toolbarCancelDone.hidden = NO;
    [self.view bringSubviewToFront:_toolbarCancelDone];
    _toolbarCancelDone.backgroundColor =  rgb(241, 241, 241);
    [_localPicker removeFromSuperview];
}

#pragma mark--UIPickerViewDataSource
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 30.0;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    if (component==FirstComponent) {
        return [_pickerArray count];
    }
    if (component==SubComponent) {
        return [_subPickerArray count];
    }
    if (component==ThirdComponent) {
        return [_thirdPickerArray count];
    }
    return 0;
}

#pragma mark--UIPickerViewDelegate
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
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
    return nil;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    //    NSLog(@"row is %ld,Component is %ld",row,component);
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
    if (component==1) {
        
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

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if (component==FirstComponent) {
        return 90.0;
    }
    if (component==SubComponent) {
        return 120.0;
    }
    if (component==ThirdComponent) {
        return 100.0;
    }
    return 0;
}


#pragma mark->colledgeViewDelegate
-(void)ColledgeDelegateNString:(NSString *)CollString andIndex:(NSIndexPath *)indexPath
{
    [dataListArr replaceObjectAtIndex:3 withObject:CollString];
    [dataColor replaceObjectAtIndex:3 withObject:UI_MAIN_COLOR];
    [_tableView reloadData];
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

//-(void)PostCustomerInfoSaveBase
//{
////    DLog(@"%@---%@",dataListAll[3],dataListAll1[6]);
//    if (![_cityCode.provinceCode isEqualToString:@""] && ![_cityCode.cityCode isEqualToString:@""] && ![_cityCode.districtCode isEqualToString:@""]) {
//        NSDictionary *dicParam = [self getInfoMsg];
//        SaveCustomBaseViewModel *saveCustomBaseViewModel = [[SaveCustomBaseViewModel alloc] init];
//        [saveCustomBaseViewModel setBlockWithReturnBlock:^(id returnValue) {
//            if ([[returnValue objectForKey:@"flag"]isEqualToString:@"0000"]) {
//                [UserDefaulInfo getUserInfoData];
//                _segment.selectedSegmentIndex =1;
//                [dataListAll1 replaceObjectAtIndex:3 withObject:dataListAll[3]];
//                [dataListAll1 replaceObjectAtIndex:7 withObject:dataListAll1[6]];
//                [self createUIWith:_segment.selectedSegmentIndex];
//            } else {
//                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:[returnValue objectForKey:@"msg"]];
//            }
//        } WithFaileBlock:^{
//
//        }];
//        [saveCustomBaseViewModel saveCustomBaseInfo:dicParam];
//    } else {
//        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请重新选择现居地址"];
//    }
//}



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

- (IBAction)doneAction:(id)sender {
    NSString *localString = @"";
    NSString *loString = @"";
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
    DLog(@"%@---%@",loString,localString);
    [dataListArr replaceObjectAtIndex:4 withObject:localString];
    [dataColor replaceObjectAtIndex:4 withObject:UI_MAIN_COLOR];
    //第一个省的所有区
    [_subPickerArray removeAllObjects];
    //    RegionSub *regisonSubModel = _reginBase.result[0];
    //    for (int j = 0; j < regisonSubModel.sub.count; j++) {
    //        RegionResult *regionResultModel = regisonSubModel.sub[j];
    //        [_subPickerArray addObject:regionResultModel.name];
    //    }
    //
    //    //第一个区的县的所有县
    //    [_thirdPickerArray removeAllObjects];
    //    RegionResult *regionResultModel = regisonSubModel.sub[0];
    //    for (int j = 0; j < regionResultModel.sub.count; j++) {
    //        //取出市
    //        [_thirdPickerArray addObject:[regionResultModel.sub[j] objectForKey:@"name"]];
    //
    //    }
    
    //    [dataListAll1 replaceObjectAtIndex:7 withObject:loString];
    //    [dataListAll1 replaceObjectAtIndex:3 withObject:localString];
    //    [datacolor1 replaceObjectAtIndex:3 withObject:cyancColor];
    //第一个省的所有区
    //    [_subPickerArray removeAllObjects];
    //    RegionSub *regisonSubModel = _reginBase.result[0];
    //    for (int j = 0; j < regisonSubModel.sub.count; j++) {
    //        RegionResult *regionResultModel = regisonSubModel.sub[j];
    //        [_subPickerArray addObject:regionResultModel.name];
    //    }
    
    //    //第一个区的县的所有县
    //    [_thirdPickerArray removeAllObjects];
    //    RegionResult *regionResultModel = regisonSubModel.sub[0];
    //    for (int j = 0; j < regionResultModel.sub.count; j++) {
    //        //取出市
    //        [_thirdPickerArray addObject:[regionResultModel.sub[j] objectForKey:@"name"]];
    //
    //    }
    [self PostGetCityCode:loString];
    [_tableView reloadData];
    //    [_tableView0 reloadData];
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
