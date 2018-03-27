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
#import "CustomerIDInfo.h"
#import "DataDicParse.h"
#import "PserInfoViewModel.h"


#define FirstComponent 0
#define SubComponent 1
#define ThirdComponent 2
#define CellBGColorRed rgb(252, 0, 6)

@interface UserIdentityInformationVCModules ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,ColledgeViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSArray *_placeHolderArr;
    NSMutableArray *dataColor;
    NSMutableArray *dataListArr;
    NSMutableArray *_reginListArr;
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
    NSString *_poro;
    CustomerIDInfo *_customerFrontIDParse;
    CustomerIDInfo *_customerBackIDParse;
    DataDicParse *_dataDicEduLevel;
    NSMutableArray * _edudataList;
    
    BOOL isEdit;
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
    _edudataList = [NSMutableArray array];
    _reginListArr = [NSMutableArray array];
    for (int i = 0; i < 6; i++) {
        [dataColor addObject:UI_MAIN_COLOR];
        [dataListArr addObject:@""];
    }
    _toolbarCancelDone.hidden = true;
    isEdit = false;
    
    [self configTableView];
    [self addBackItem];
    [self setValueOfDataArr];
}

- (void)getEduLevelListInfo:(void(^)())finish
{
    //教育等级列表信息
    if (_edudataList.count != 0) {
        if (finish) {
            finish();
            return;
        }
    }
    
    UserDataViewModel * userDataVM = [[UserDataViewModel alloc]init];
    [userDataVM setBlockWithReturnBlock:^(id returnValue) {
        BaseResultModel * baseRM = returnValue;
        if ([baseRM.errCode isEqualToString:@"0"]) {
            [_edudataList removeAllObjects];
            NSArray * tempArr = (NSArray *)baseRM.data;
            for (NSDictionary * dic in tempArr) {
                DataDicParse * dataParse = [[DataDicParse alloc]initWithDictionary:dic error:nil];
                [_edudataList addObject:dataParse];
            }
            if (finish) {
                finish();
            }
        }else{
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:baseRM.friendErrMsg];
        }
    } WithFaileBlock:^{
        
    }];
    [userDataVM getCommonDictCodeListTypeStr:@"EDUCATION_LEVEL_"];
}

- (void)configTableView
{
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableView.showsVerticalScrollIndicator = NO;
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
    [FXD_Tool setCorner:_saveBtn borderColor:[UIColor clearColor]];
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
        make.height.equalTo(@30);
        make.right.equalTo(backView);
    }];
    return backView;
}

//拉取用户信息
- (void)setValueOfDataArr
{
    NSString *eduLevel = self.userDataIformationM.education_level_;
    if (eduLevel) {
        [self getEduLevelListInfo:^{
            [_edudataList enumerateObjectsUsingBlock:^(DataDicParse * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([eduLevel isEqualToString:obj.code_]) {
                    [dataListArr replaceObjectAtIndex:3 withObject:obj.desc_];
                    [_tableView reloadData];
                }
            }];
        }];
    }
    
    if (_userDataIformationM.province_ != nil && _userDataIformationM.city_ != nil && _userDataIformationM.county_ != nil) {
        NSString *proviece_city = @"";
        _poro = [NSString stringWithFormat:@"%@/%@/%@",_userDataIformationM.province_name_,_userDataIformationM.city_name_,_userDataIformationM.county_name_];
        if ([_userDataIformationM.province_name_ isEqualToString: _userDataIformationM.city_name_]) {
            proviece_city = [NSString stringWithFormat:@"%@/%@",_userDataIformationM.city_name_,_userDataIformationM.county_name_];
        }else if ([_userDataIformationM.county_name_ isEqualToString: _userDataIformationM.city_name_]){
            proviece_city = [NSString stringWithFormat:@"%@/%@",_userDataIformationM.province_name_,_userDataIformationM.city_name_];
        }else{
            proviece_city = [NSString stringWithFormat:@"%@/%@/%@",_userDataIformationM.province_name_,_userDataIformationM.city_name_,_userDataIformationM.county_name_];
        }
        [dataListArr replaceObjectAtIndex:4 withObject:proviece_city];
    }
    if (_userDataIformationM.home_address_) {
        [dataListArr replaceObjectAtIndex:5 withObject:_userDataIformationM.home_address_];
    }
    
    if ([_userDataIformationM.ocr_status_ integerValue] == 2) {
        [dataListArr replaceObjectAtIndex:1 withObject:_userDataIformationM.customer_name_];
        [dataListArr replaceObjectAtIndex:2 withObject:_userDataIformationM.id_code_];
    }
    if (_poro.length > 3) {
        [self PostGetCityCode:_poro];
    }
    
    [_tableView reloadData];
}

#pragma mark -> 个人信息保存接口
- (void)saveBtnClick
{
    DLog(@"保存");
    if ([_cityCode.provinceCode isEqualToString:@""] || [_cityCode.cityCode isEqualToString:@""] || [_cityCode.districtCode isEqualToString:@""]) {
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请重新选择现居地址"];
        return;
    }
    __block NSString *degree = @"";
    [self getEduLevelListInfo:^{
        [_edudataList enumerateObjectsUsingBlock:^(DataDicParse * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.desc_ isEqualToString:dataListArr[3]]) {
                degree = obj.code_;
            }
        }];
    }];
    
    NSString *addressDetail = [dataListArr[5] stringByReplacingOccurrencesOfString:@" " withString:@""];
    SaveCustomBaseViewModel *saveCustomBaseViewModel = [[SaveCustomBaseViewModel alloc] init];
    [saveCustomBaseViewModel setBlockWithReturnBlock:^(id returnValue) {
        BaseResultModel * baseRM = returnValue;
        if ([baseRM.errCode isEqualToString:@"0"]) {
            [self.navigationController popViewControllerAnimated:true];
        }else{
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:baseRM.friendErrMsg];
        }
    } WithFaileBlock:^{
    }];
    [saveCustomBaseViewModel saveCustomBaseInfoName:dataListArr[1] ID_code_:dataListArr[2] EduLevel:degree home_address:addressDetail province:_cityCode.provinceCode city:_cityCode.cityCode county:_cityCode.districtCode];
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
                if (_idOCRFrontParse != nil || [_userDataIformationM.ocr_status_ integerValue] == 2) {
                    [cell.identityUpBtn setBackgroundImage:[UIImage imageNamed:@"identitySelUp"] forState:UIControlStateNormal];
                    cell.identityUpBtn.enabled = false;
                }else {
                    [cell.identityUpBtn setBackgroundImage:[UIImage imageNamed:@"identityUpUn"] forState:UIControlStateNormal];
                    cell.identityUpBtn.enabled = true;
                }
                if (_idOCRBackParse != nil || [_userDataIformationM.ocr_status_ integerValue] == 2) {
                    [cell.identityBackBtn setBackgroundImage:[UIImage imageNamed:@"identitySelBack"] forState:UIControlStateNormal];
                    cell.identityBackBtn.enabled = false;
                } else {
                    [cell.identityBackBtn setBackgroundImage:[UIImage imageNamed:@"identityUnBack"] forState:UIControlStateNormal];
                    cell.identityBackBtn.enabled = true;
                }
                if (!cell.identityUpBtn.isEnabled && !cell.identityBackBtn.isEnabled) {
                    cell.identityLabel.textColor = UI_MAIN_COLOR;
                }
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
        [self getEduLevelListInfo:^{
            _colledgeView = [[[NSBundle mainBundle] loadNibNamed:@"ColledgeView" owner:self options:nil] lastObject];
            _colledgeView.frame = CGRectMake(0, 0, _k_w, _k_h);
            _colledgeView.edudataList = [_edudataList copy];
            _colledgeView.delegate = self;
            [_colledgeView show];
        }];
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
    [[MBPAlertView sharedMBPTextView] showIndeterminateOnly:self.view];
    [MGLicenseManager licenseForNetWokrFinish:^(bool License) {
        [[MBPAlertView sharedMBPTextView] removeWaitHud];
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
 
                                 }];
}
- (void)verifyIDCard:(UIImage *)image cardSide:(MGIDCardSide)cardSide
{
    __unsafe_unretained UserIdentityInformationVCModules *weakSelf = self;
    NSDictionary *paramDic = @{@"api_key":FaceIDAppKey,
                               @"api_secret":FaceIDAppSecret,
                               @"legality":@1};
    NSDictionary *imageDic = @{@"image":UIImagePNGRepresentation(image)};
    [[FXD_NetWorkRequestManager sharedNetWorkManager] POSTUpLoadImage:_detectIDCardOCR_url FilePath:imageDic parameters:paramDic finished:^(EnumServerStatus status, id object) {
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
    PserInfoViewModel * pserInfoM = [[PserInfoViewModel alloc]init];
    [pserInfoM setBlockWithReturnBlock:^(id returnValue) {
        BaseResultModel * baseRM =returnValue;
        if ([baseRM.errCode isEqualToString:@"0"]) {
            CustomerIDInfo * customerIDInfo = [[CustomerIDInfo alloc]initWithDictionary:(NSDictionary *)baseRM.data error:nil];
            if ([side isEqualToString:@"front"]) {
                _customerFrontIDParse = customerIDInfo;
            }
            if ([side isEqualToString:@"back"]){
                _customerBackIDParse = customerIDInfo;
            }
            [weakSelf setUserIDCardInfo];
        }else{
            [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:baseRM.friendErrMsg];
        }
    } WithFaileBlock:^{
    }];
    [pserInfoM saveUserIDCardImage:image carSide:side faceResult:result];
}

/**
 OCR识别结果处理
 */
- (void)setUserIDCardInfo
{
    if (_idOCRFrontParse != nil && _idOCRBackParse != nil) {
        NSString * prometStr = IDOCRMarkeords;
        NSString * alertContent = [NSString stringWithFormat:@"姓名：%@\n身份证号：%@\n%@",_customerFrontIDParse.customer_name_,_customerFrontIDParse.id_code_,prometStr];
        [[FXD_AlertViewCust sharedHHAlertView] showIdentiFXDAlertViewTitle:@"身份信息确认" content:alertContent cancelTitle:@"存在错误" sureTitle:@"确认无误" compleBlock:^(NSInteger index) {
            if (index == 0) {
                isEdit = true;
                ContentTableViewCell *cell = [self.tableView cellForRowAtIndexPath: [NSIndexPath indexPathForRow:0 inSection:1]];
                [cell.contentTextField becomeFirstResponder];
            }
        }];
        [dataListArr replaceObjectAtIndex:1 withObject:_customerFrontIDParse.customer_name_];
        [dataListArr replaceObjectAtIndex:2 withObject:_customerFrontIDParse.id_code_];
        [FXD_Utility sharedUtility].userInfo.userIDNumber = _customerFrontIDParse.id_code_;
        [FXD_Utility sharedUtility].userInfo.realName = _customerFrontIDParse.customer_name_;
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
        return isEdit;
    }
    if (textField.tag == 101) {
        return isEdit;
    }
    /*
    if (textField.tag == 100) {
        if (_customerFrontIDParse.editable_field_ && _customerFrontIDParse.editable_field_.length > 2) {
            if ([_customerFrontIDParse.editable_field_ containsString:@"customer_name_"]) {
                return true;
            }else {
                return false;
            }
        } else {
            return false;
        }
    }
    if (textField.tag == 101) {
        if (_customerFrontIDParse.editable_field_ && _customerFrontIDParse.editable_field_.length > 2) {
            if ([_customerFrontIDParse.editable_field_ containsString:@"id_code_"]) {
                return true;
            }else {
                return false;
            }
        } else {
            return false;
        }
    }
    */
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *stringLength=[NSString stringWithFormat:@"%@%@",textField.text,string];
    //身份证号可编辑时 限制
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
            [self getEduLevelListInfo:^{
                _colledgeView = [[[NSBundle mainBundle] loadNibNamed:@"ColledgeView" owner:self options:nil] lastObject];
                _colledgeView.frame = CGRectMake(0, 0, _k_w, _k_h);
                _colledgeView.edudataList = [_edudataList copy];
                _colledgeView.delegate = self;
                [_colledgeView show];
            }];
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

#pragma mark--UIPickerViewDelegate  省市区选择

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
    
    if (component==1) {
        
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
            regionResultModel = [[RegionSub alloc]initWithDictionary:_regionSub.sub[0] error:nil];
        }else{
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
    [self PostGetCityCode:loString];
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
