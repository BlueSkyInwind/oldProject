//
//  ProfessViewController.m
//  fxdProduct
//
//  Created by dd on 16/1/25.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "ProfessViewController.h"
#import "LabelCell.h"
#import "TelPhoneCompanyCell.h"
#import "NSString+Validate.h"
#import "CustomerCareerBaseClass.h"
#import "RegionBaseClass.h"
#import "RegionCodeBaseClass.h"
#import "GetCareerInfoViewModel.h"
#import "SaveCustomerCarrerViewModel.h"

#define FirstComponent 0
#define SubComponent 1
#define ThirdComponent 2
#define cyancColor rgb(0, 170, 238)
#define redColor rgb(252, 0, 6)

@interface ProfessViewController () <UITableViewDataSource,UITableViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate>

{
    NSArray *_dataArr;
    NSArray *_placeHoldArr;
    
    NSDictionary *_dict;
    NSMutableArray *_pickerArray;
    NSMutableArray *_subPickerArray;
    NSMutableArray *_thirdPickerArray;
    NSArray *_selectArray;
    NSInteger _pickerTag;
    NSMutableArray *_dataListArray;
    NSArray *_professionArray;
    NSMutableArray *datacolor1;
    NSInteger index;
    CustomerCareerBaseClass *_carrerInfoModel;
    RegionBaseClass *_reginBase;
    RegionSub *_regionSub;
    RegionResult *_regionResult;
    RegionCodeResult *_ciytCode;
}

@property (nonatomic , strong) UIPickerView *pickerView;
@end

@implementation ProfessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"资料修改";
    [self addBackItem];
    self.myTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    _dataArr = [NSArray array];
    _dataListArray = [NSMutableArray array];
    datacolor1 = [NSMutableArray array];
    _pickerArray = [NSMutableArray array];
    _subPickerArray = [NSMutableArray array];
    _thirdPickerArray = [NSMutableArray array];
    index = 0;
    for (int i=0; i<7; i++) {
        [_dataListArray addObject:@""];
        [datacolor1 addObject:cyancColor];
    }
    
    _placeHoldArr = @[@"工作单位",@"单位电话",@"工作行业",@"公司地址",@"详细地址"];
    _professionArray = @[@"生活/服务业",@"人力/行政/管理",@"销售/客服/采购/淘宝",
                         @"市场/媒介/广告/设计",@"生产/物流/质控/汽车",
                         @"网络/通信/电子",@"法律/教育/翻译/出版",@"财会/金融/保险",
                         @"医疗/制药/环保",@"其他"];
    self.toolBarView.alpha = 0;
    self.pickerView.alpha = 0;
    
    
    [self PostgetCustomerCarrer_jhtml];
    [_saveBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)btnClick
{

    if (![self isCanSelectBtn1]) {
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"资料修改不符合规范"];
        
    }else{
        [self PostGetCityCode:_dataListArray[6]];
       
    }
    

}

- (NSDictionary *)getProfessionInfo
{
    NSString *telString =[NSString stringWithFormat:@"%@-%@",_dataListArray[5],_dataListArray[1]];
    NSString *profefssiontag = @"";
    for (int i = 0; i < _professionArray.count; i++) {
        if ([_dataListArray[2] isEqualToString:_professionArray[i]]) {
            profefssiontag =[NSString stringWithFormat:@"%d",i+1];
        }
    }
        NSString *cityDetail = [_dataListArray[4] stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *companyString  = [_dataListArray[0] stringByReplacingOccurrencesOfString:@" " withString:@""];
    return @{@"organization_name_":companyString,
             @"organization_telephone_":telString,
             @"industry_":profefssiontag,
             @"province_":_ciytCode.provinceCode,
             @"city_":_ciytCode.cityCode,
             @"country_":_ciytCode.districtCode,
             @"organization_address_":cityDetail};
}

- (void)setValueOfProArr
{
    if (_carrerInfoModel.result.organizationName) {
        [_dataListArray replaceObjectAtIndex:0 withObject:_carrerInfoModel.result.organizationName];
    }
    if (_carrerInfoModel.result.organizationTelephone) {
        
        if ([_carrerInfoModel.result.organizationTelephone length]>9) {
            NSString *telString= _carrerInfoModel.result.organizationTelephone;
            NSArray *telArray = [telString componentsSeparatedByString:@"-"];
            if (telArray.count >1) {
                if ([telArray[0] isAreaCode]) {
                    [_dataListArray replaceObjectAtIndex:5 withObject:telArray[0]];
                }
                if ([telArray[1] length]>=7 && [telArray[1] length]<=8) {
                    [_dataListArray replaceObjectAtIndex:1 withObject:telArray[1]];
                }
                
            }else{
                telString = [_carrerInfoModel.result.organizationTelephone areaCodeFormat];
                NSArray *telArray1 = [telString componentsSeparatedByString:@"-"];
                if ([telArray1[0] isAreaCode]) {
                    [_dataListArray replaceObjectAtIndex:5 withObject:telArray1[0]];
                }
                if ([telArray1[1] length]>=7 && [telArray1[1] length]<=8) {
                    [_dataListArray replaceObjectAtIndex:1 withObject:telArray1[1]];
                }
            }
            
        }else{
            if ([_carrerInfoModel.result.organizationTelephone length]>=7 && [_carrerInfoModel.result.organizationTelephone length] <=8) {
                [_dataListArray replaceObjectAtIndex:1 withObject:_carrerInfoModel.result.organizationTelephone];
            }
        }
        
    }
    //行业
    if (_carrerInfoModel.result.industry) {
        NSInteger tagflag = [_carrerInfoModel.result.industry integerValue];
        for (int i = 1; i< 11; i++) {
            if (i == tagflag) {
                [_dataListArray replaceObjectAtIndex:2 withObject:_professionArray[i-1]];
            }
        }
    }
    if (_carrerInfoModel.result.cityName && _carrerInfoModel.result.provinceName && _carrerInfoModel.result.countryName) {
        
        NSString *addree = @"";
        NSString *add = [NSString stringWithFormat:@"%@/%@/%@",_carrerInfoModel.result.provinceName,
                         _carrerInfoModel.result.cityName,_carrerInfoModel.result.countryName];
        if ([_carrerInfoModel.result.cityName isEqualToString: _carrerInfoModel.result.provinceName]) {
            addree = [NSString stringWithFormat:@"%@/%@",
                      _carrerInfoModel.result.cityName,_carrerInfoModel.result.countryName];
        }else if ([_carrerInfoModel.result.cityName isEqualToString: _carrerInfoModel.result.countryName]){
            addree = [NSString stringWithFormat:@"%@/%@",_carrerInfoModel.result.provinceName,
                      _carrerInfoModel.result.cityName];
        }else{
            addree = [NSString stringWithFormat:@"%@/%@/%@",_carrerInfoModel.result.provinceName,
                      _carrerInfoModel.result.cityName,_carrerInfoModel.result.countryName];
        }
        [_dataListArray replaceObjectAtIndex:6 withObject:add];
        [_dataListArray replaceObjectAtIndex:3 withObject:addree];
    }else{
        if(_carrerInfoModel.result.city && _carrerInfoModel.result.province && _carrerInfoModel.result.country)
        {
            NSString *addree = [NSString stringWithFormat:@"%@/%@/%@",_carrerInfoModel.result.province,
                                _carrerInfoModel.result.city,_carrerInfoModel.result.country];
            [_dataListArray replaceObjectAtIndex:6 withObject:addree];
            [_dataListArray replaceObjectAtIndex:3 withObject:addree];
        }
    }
    
    if (_carrerInfoModel.result.organizationAddress) {
        [_dataListArray replaceObjectAtIndex:4 withObject:_carrerInfoModel.result.organizationAddress];
    }
}

//职业信息
-(BOOL)isCanSelectBtn1
{
    if ([_dataListArray[0] length]>1 && [_dataListArray[1] length]>1 && [_dataListArray[2] length]>1 && [_dataListArray[3] length]>1 && [_dataListArray[4] length]>1 && [_dataListArray[5] isAreaCode]) {
        return YES;
    }else {
        return NO;
    }
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
}

- (IBAction)pickerDone:(UIBarButtonItem *)sender {
    if (_pickerView.tag ==102) {
        if ([_dataListArray[2] isEqualToString:@""]) {
            [_dataListArray replaceObjectAtIndex:2 withObject:_professionArray[0]];
        }
        
    }else if(_pickerView.tag ==103){
        NSString *localString = @"";
        NSString *loString = @"";
        if (_thirdPickerArray.count > 0) {
            if ([[_pickerArray objectAtIndex:[self.pickerView selectedRowInComponent:0]] isEqualToString:[_subPickerArray objectAtIndex:[self.pickerView selectedRowInComponent:1]]]) {
                localString = [NSString stringWithFormat:@"%@/%@",[_subPickerArray objectAtIndex:[self.pickerView selectedRowInComponent:1]],[_thirdPickerArray objectAtIndex:[self.pickerView selectedRowInComponent:2]]];
                
                loString = [NSString stringWithFormat:@"%@/%@/%@",[_pickerArray objectAtIndex:[self.pickerView selectedRowInComponent:0]],[_subPickerArray objectAtIndex:[self.pickerView selectedRowInComponent:1]],[_thirdPickerArray objectAtIndex:[self.pickerView selectedRowInComponent:2]]];
            }else if ([[_subPickerArray objectAtIndex:[self.pickerView selectedRowInComponent:1]] isEqualToString:[_thirdPickerArray objectAtIndex:[self.pickerView selectedRowInComponent:2]]]){
                localString = [NSString stringWithFormat:@"%@/%@",[_pickerArray objectAtIndex:[self.pickerView selectedRowInComponent:0]],[_subPickerArray objectAtIndex:[self.pickerView selectedRowInComponent:1]]];
                loString = [NSString stringWithFormat:@"%@/%@/%@",[_pickerArray objectAtIndex:[self.pickerView selectedRowInComponent:0]],[_subPickerArray objectAtIndex:[self.pickerView selectedRowInComponent:1]],[_thirdPickerArray objectAtIndex:[self.pickerView selectedRowInComponent:2]]];
            } else if ([_pickerArray objectAtIndex:[self.pickerView selectedRowInComponent:0]] &&[_subPickerArray objectAtIndex:[self.pickerView selectedRowInComponent:1]] &&[_thirdPickerArray objectAtIndex:[self.pickerView selectedRowInComponent:2]]){
                localString = [NSString stringWithFormat:@"%@/%@/%@",[_pickerArray objectAtIndex:[self.pickerView selectedRowInComponent:0]],[_subPickerArray objectAtIndex:[self.pickerView selectedRowInComponent:1]],[_thirdPickerArray objectAtIndex:[self.pickerView selectedRowInComponent:2]]];
                loString = [NSString stringWithFormat:@"%@/%@/%@",[_pickerArray objectAtIndex:[self.pickerView selectedRowInComponent:0]],[_subPickerArray objectAtIndex:[self.pickerView selectedRowInComponent:1]],[_thirdPickerArray objectAtIndex:[self.pickerView selectedRowInComponent:2]]];
            }

        }
        
        [_dataListArray replaceObjectAtIndex:6 withObject:loString];
        [_dataListArray replaceObjectAtIndex:3 withObject:localString];
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
        
    }else{
        
    }
    
    [_myTable reloadData];
    [UIView animateWithDuration:0.5
                          delay:0
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.pickerView.alpha = 0;
                         self.toolBarView.alpha = 0;
                         self.pickerView.hidden = YES;
                         self.toolBarView.hidden = YES;
                     }
                     completion:^(BOOL finished){
                         
                     }];
}

- (IBAction)pickerCancle:(UIBarButtonItem *)sender {
    [UIView animateWithDuration:0.5
                          delay:0
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.pickerView.alpha = 0;
                         self.toolBarView.alpha = 0;
                         self.pickerView.hidden = YES;
                         self.toolBarView.hidden = YES;
                     }
                     completion:^(BOOL finished){
                         
                     }];
}




#pragma mark - TableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _placeHoldArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1){
        TelPhoneCompanyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TelPhoneCompanyCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"TelPhoneCompanyCell" owner:self options:nil] lastObject];
        }
        cell.textfiledCode.text = _dataListArray[5];
        cell.textfiledCode.tag = 1005;
        cell.textfiledCode.delegate = self;
        cell.textfiledCode.keyboardType = UIKeyboardTypePhonePad;
        
        cell.textfiledTel.text = _dataListArray[indexPath.row];
        cell.textfiledTel.delegate = self;
        cell.textfiledTel.tag = indexPath.row + 1000;
        cell.textfiledTel.keyboardType = UIKeyboardTypePhonePad;
        [Tool setCorner:cell.viewCode borderColor:datacolor1[5]];
        [Tool setCorner:cell.viewTel borderColor:datacolor1[indexPath.row]];
        return cell;
    }else{
    static NSString *cellIdentifier = @"identifier";
    LabelCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"LabelCell" owner:self options:nil].lastObject;
    }
    cell.btn.hidden = YES;
    
    cell.btnSecory.hidden = YES;
    if (indexPath.row == 2 || indexPath.row == 3) {
        [cell.btn setBackgroundImage:[UIImage imageNamed:@"3_lc_icon_24"] forState:UIControlStateNormal];
        cell.btn.tag = 100 + indexPath.row;
        [cell.btn addTarget:self action:@selector(selectPicker:) forControlEvents:UIControlEventTouchUpInside];
        cell.btn.hidden = NO;
    }
    cell.textField.tag = 1000 + indexPath.row;
    cell.textField.delegate = self;
    cell.textField.text = _dataListArray[indexPath.row];
    cell.textField.placeholder = [_placeHoldArr objectAtIndex:indexPath.row];
    [Tool setCorner:cell.bgView borderColor:datacolor1[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    }
    return nil;
}

- (void)selectPicker:(UIButton *)sender
{
    [self.view endEditing:YES];
    [_pickerView removeFromSuperview];
    if (sender.tag == 102) {
        DLog(@"102");
        
    [UIView animateWithDuration:0.5
                              delay:0
                            options: UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, _k_h-183, _k_w, 183)];
                             self.pickerView.delegate = self;
                             self.pickerView.dataSource = self;
                             self.pickerView.backgroundColor = [UIColor whiteColor];
                             self.pickerView.hidden = NO;
                             self.toolBarView.hidden = NO;
                             self.pickerView.alpha = 1;
                             self.toolBarView.alpha = 1;
                             self.pickerView.tag =102;
                             [self.view addSubview:_pickerView];
                             
                         }
                         completion:^(BOOL finished){
                             
                         }];

    }
    if (sender.tag == 103) {
        if (_pickerArray.count != 34) {
            [self PostGetCity];
        }
        [UIView animateWithDuration:0.5
                              delay:0
                            options: UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, _k_h-183, _k_w, 183)];
                             self.pickerView.delegate = self;
                             self.pickerView.dataSource = self;
                             self.pickerView.backgroundColor = [UIColor whiteColor];
                             self.pickerView.hidden = NO;
                             self.toolBarView.hidden = NO;
                             self.pickerView.alpha = 1;
                             self.toolBarView.alpha = 1;
                             self.pickerView.tag =103;
                             [self.view addSubview:_pickerView];
                             
                         }
                         completion:^(BOOL finished){
                             
                         }];
        
    }
}


#pragma mark - UIPickerViewDelegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (pickerView.tag == 102) {
        return 1;
    }
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView.tag == 102) {
        return _professionArray.count;
    }
    if (pickerView.tag == 103)
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
    }
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView.tag == 102) {
        return [_professionArray objectAtIndex:row];
    }
    if (pickerView.tag == 103){
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
            if(_thirdPickerArray.count - 1 < row)
            {
                return _thirdPickerArray[0];
            }
            return [_thirdPickerArray objectAtIndex:row];
        }
    }
        return nil;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView.tag == 102) {
        [_dataListArray replaceObjectAtIndex:2 withObject:_professionArray[row]];
    }
    if (pickerView.tag == 103){
        if (component == 0) {
            index = row;
            //第一个省的所有区
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
    
}


- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if (pickerView.tag ==102) {
        return _k_w;
    }
    if (pickerView.tag == 103){
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

#pragma mark->UITextFieldDelegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField.tag == 1002 || textField.tag == 1003) {
        return NO;
    }
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    //第三页的部分
    if (textField.tag == 1000) {
        if (![CheckUtils checkUserName:textField.text]) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入正确的单位名称"];
            [datacolor1 replaceObjectAtIndex:0 withObject:redColor];
        }else{
            [_dataListArray replaceObjectAtIndex:0 withObject:textField.text];
            [datacolor1 replaceObjectAtIndex:0 withObject:cyancColor];
        }
    }
    if (textField.tag == 1001) {
        if (![self isCommonString:textField.text]) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入正确的单位电话"];
            [datacolor1 replaceObjectAtIndex:1 withObject:redColor];
        }else{
            [_dataListArray replaceObjectAtIndex:1 withObject:textField.text];
            [datacolor1 replaceObjectAtIndex:1 withObject:cyancColor];
        }
    }
    if (textField.tag == 1002) {
        if (textField.text.length < 5) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请选择正确的行业/职业"];
            [datacolor1 replaceObjectAtIndex:2 withObject:redColor];
        }else{
            [_dataListArray replaceObjectAtIndex:2 withObject:textField.text];
            [datacolor1 replaceObjectAtIndex:2 withObject:cyancColor];
        }
    }
    if (textField.tag == 1003) {
        if (textField.text.length < 5) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请选择正确的单位所在地"];
            [datacolor1 replaceObjectAtIndex:3 withObject:redColor];
        }else{
            [_dataListArray replaceObjectAtIndex:3 withObject:textField.text];
            [datacolor1 replaceObjectAtIndex:3 withObject:cyancColor];
        }
    }
    if (textField.tag == 1004) {
        NSString *datail = [textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        if (![CheckUtils checkUserDetail:datail] || [CheckUtils checkNumber1_30wei:datail]) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入正确的单位详址"];
            [datacolor1 replaceObjectAtIndex:4 withObject:redColor];
        }else{
            [_dataListArray replaceObjectAtIndex:4 withObject:textField.text];
            [datacolor1 replaceObjectAtIndex:4 withObject:cyancColor];
        }
    }
    if (textField.tag == 1005) {
        if (![textField.text isAreaCode]) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入正确的区号"];
            [datacolor1 replaceObjectAtIndex:5 withObject:redColor];
        }else{
            [_dataListArray replaceObjectAtIndex:5 withObject:textField.text];
            [datacolor1 replaceObjectAtIndex:5 withObject:cyancColor];

        }
    }
    [_myTable reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

#pragma mark-> PostgetCustomerCarrer_jhtml 获取职业信息

-(void)PostgetCustomerCarrer_jhtml
{
    GetCareerInfoViewModel *careerInfoViewModel = [[GetCareerInfoViewModel alloc] init];
    [careerInfoViewModel setBlockWithReturnBlock:^(id returnValue) {
        _carrerInfoModel = returnValue;
        if ([_carrerInfoModel.flag isEqualToString:@"0000"]) {
            //给职业信息赋值
            [self setValueOfProArr];
            [_myTable reloadData];
        }
    } WithFaileBlock:^{
        
    }];
    [careerInfoViewModel fatchCareerInfo:nil];
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
                
                [_pickerView reloadAllComponents];
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
                RegionCodeBaseClass *regionCodeParse = [RegionCodeBaseClass modelObjectWithDictionary:object];
                
                _ciytCode = regionCodeParse.result;
                [self PostSaveProfreeInfoMessage];
                
            } else {
            }
        }
    } failure:^(EnumServerStatus status, id object) {
        
    }];
    
}

#pragma mark -> 保存职业信息
-(void)PostSaveProfreeInfoMessage
{
    if (![_ciytCode.provinceCode isEqualToString:@""] && ![_ciytCode.cityCode isEqualToString:@""]&& ![_ciytCode.districtCode isEqualToString:@""]) {
        NSDictionary *paramDic = [self getProfessionInfo];
        SaveCustomerCarrerViewModel *saveCustomerCarrerViewModel = [[SaveCustomerCarrerViewModel alloc] init];
        [saveCustomerCarrerViewModel setBlockWithReturnBlock:^(id returnValue) {
            if ([[returnValue objectForKey:@"flag"]isEqualToString:@"0000"]) {
                
                [self.navigationController popViewControllerAnimated:YES];
            } else {
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:[returnValue objectForKey:@"msg"]];
            }
        } WithFaileBlock:^{
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"数据获取失败!"];
        }];
        [saveCustomerCarrerViewModel saveCustomCarrer:paramDic];
    }else{
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请重新选择省市区"];
    }
    
    

}

@end
