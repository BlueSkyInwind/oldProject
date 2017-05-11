//
//  BasicInfoViewController.m
//  fxdProduct
//
//  Created by dd on 16/1/25.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "BasicInfoViewController.h"
#import "LabelCell.h"
#import "ColledgeView.h"
#import "CustomerBaseInfoBaseClass.h"
#import "RegionBaseClass.h"
#import "ContactViewController.h"
#import "RegionCodeBaseClass.h"
#import "GetCustomerBaseViewModel.h"
#import "SaveCustomBaseViewModel.h"

#define FirstComponent 0
#define SubComponent 1
#define ThirdComponent 2
#define UI_MAIN_COLOR rgb(0, 170, 238)
#define redColor rgb(252, 0, 6)

@interface BasicInfoViewController () <UITableViewDataSource,UITableViewDelegate,ColledgeViewDelegate,
UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate,
ContactViewControllerDelegate>

{
    
    NSArray *_dataArr;
    NSArray *_placeHoldArr;
    ColledgeView *_colledgeView;
    NSMutableArray *dataListAll;
    NSMutableArray *dataColor;
    RegionCodeBaseClass *_regionCodeParse;
    RegionCodeResult *_cityCode;
    
    CustomerBaseInfoBaseClass *_customerBaseInfoModel;
    CustomerBaseInfoExt *_extTelphone;
    RegionBaseClass *_reginBase;
    RegionSub *_regionSub;
    RegionResult *_regionResult;
    
    NSArray *eduLevelArray;//学历数组
    //picview数据存储
    NSDictionary *_dict;
    NSMutableArray *_pickerArray;
    NSMutableArray *_subPickerArray;
    NSMutableArray *_thirdPickerArray;
    NSArray *_selectArray;
    NSInteger _pickerTag;
    NSArray *_contact1;
    NSArray *_contact2;
    NSInteger index;
}
//UIPickerView 1.loacl 所在地
@property (nonatomic, strong) UIPickerView *localPicker;

@end

@implementation BasicInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    dataListAll = [NSMutableArray new];
    dataColor = [NSMutableArray new];
    eduLevelArray = @[@"博士及以上",@"硕士",@"本科",@"大专",
                      @"高中",@"其他"];
    _pickerArray = [NSMutableArray array];
    _subPickerArray = [NSMutableArray array];
    _thirdPickerArray = [NSMutableArray array];
    _reginBase = [[RegionBaseClass alloc] init];
    _regionSub = [[RegionSub alloc] init];
    _regionResult = [[RegionResult alloc] init];
    index = 0;
    for(int i=0 ; i<15 ; i++)
    {
        [dataListAll addObject:@""];
        [dataColor addObject:UI_MAIN_COLOR];
    }
    [dataColor replaceObjectAtIndex:0 withObject:[UIColor grayColor]];
    [dataColor replaceObjectAtIndex:1 withObject:[UIColor grayColor]];
    [self PostPersonInfoMessage];
    [self addBackItem];
    self.navigationItem.title = @"资料修改";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _saveBtn.tag = 2;
    [_saveBtn addTarget:self action:@selector(cellBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    if([self isCanSelectBtn])
    {
        [_saveBtn setEnabled:YES];
    }else{
        [_saveBtn setEnabled:NO];
    }
    self.localPicker.hidden = YES;
    self.toolbarCancelDone.hidden = YES;
    
    _dataArr = [NSArray array];
    _placeHoldArr = @[@"真实姓名",@"身份证号",@"学历",@"现居地址",
                      @"居住地详址",@"联系人1",@"联系人姓名",@"联系人手机号",
                      @"联系人2",@"联系人姓名",@"联系人手机号"];
    _contact1 = @[@"父母",@"配偶"];
    _contact2 = @[@"同事",@"朋友"];
    
    self.myTable.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tabBarController.tabBar setHidden:YES];
}


#pragma mark - TableviewDelegate

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
    static NSString *labelCellID = @"identifier";
    LabelCell *cell = [tableView dequeueReusableCellWithIdentifier:labelCellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"LabelCell" owner:self options:nil].lastObject;
    }
    
    cell.textField.tag = 100 + indexPath.row;
    cell.textField.delegate = self;
    cell.textField.placeholder = [_placeHoldArr objectAtIndex:indexPath.row];
    cell.btnSecory.hidden = YES;
    cell.btn.hidden = YES;
    cell.textField.text = dataListAll[indexPath.row];
    if (indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 5
        || indexPath.row == 6 || indexPath.row ==8 || indexPath.row == 9) {
        cell.btn.hidden = NO;
        cell.btn.tag = 100 + indexPath.row;
        [cell.btn addTarget:self action:@selector(cellBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    if (indexPath.row == 7 || indexPath.row == 10) {
        cell.textField.keyboardType = UIKeyboardTypePhonePad;
    }
    if([self isCanSelectBtn])
    {
        [_saveBtn setEnabled:YES];
    }else{
        [_saveBtn setEnabled:NO];
    }
    [cell.btn setBackgroundImage:[UIImage imageNamed:@"3_lc_icon_24"] forState:UIControlStateNormal];
    [Tool setCorner:cell.bgView borderColor:dataColor[indexPath.row]];
    cell.selectionStyle  = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField.tag == 100 || textField.tag == 101 || textField.tag == 102 || textField.tag == 103 || textField.tag == 105 || textField.tag == 108) {
        return NO;
    }
    
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag == 103) {
        if (textField.text.length <2) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请选择正确的现居住地"];
            [dataColor replaceObjectAtIndex:3 withObject:redColor];
        }else{
            [dataListAll replaceObjectAtIndex:3 withObject:textField.text];
            [dataColor replaceObjectAtIndex:3 withObject:UI_MAIN_COLOR];
        }
    }
    if (textField.tag == 104) {
        DLog(@"----%d",[CheckUtils checkUserDetail:textField.text]);
        NSString *dat = [textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        if (![CheckUtils checkUserDetail:dat] || [CheckUtils checkNumber1_30wei:dat]) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请选择正确的居住地详址"];
            [dataColor replaceObjectAtIndex:4 withObject:redColor];
        }else{
            [dataListAll replaceObjectAtIndex:4 withObject:textField.text];
            [dataColor replaceObjectAtIndex:4 withObject:UI_MAIN_COLOR];
        }
    }
    if (textField.tag == 105) {
        if (![CheckUtils checkUserName:textField.text]) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入正确的联系人关系"];
            [dataColor replaceObjectAtIndex:5 withObject:redColor];
        }else{
            [dataListAll replaceObjectAtIndex:5 withObject:textField.text];
            [dataColor replaceObjectAtIndex:5 withObject:UI_MAIN_COLOR];
        }
    }
    if (textField.tag == 106) {
        DLog(@"--%d",[CheckUtils checkUserName:textField.text]);
        if (![CheckUtils checkUserName:textField.text] || [dataListAll[0] isEqualToString:textField.text]) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入正确的联系人姓名"];
            [dataColor replaceObjectAtIndex:6 withObject:redColor];
            
        }else{
            [dataListAll replaceObjectAtIndex:6 withObject:textField.text];
            [dataColor replaceObjectAtIndex:6 withObject:UI_MAIN_COLOR];
            
        }
    }
    if (textField.tag == 107) {
        NSString *tel = [textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        if (![CheckUtils checkTelNumber:tel] || [tel isEqualToString:_extTelphone.mobilePhone]) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入正确的联系人手机号"];
            [dataColor replaceObjectAtIndex:7 withObject:redColor];
            
        }else{
            [dataListAll replaceObjectAtIndex:7 withObject:textField.text];
            [dataColor replaceObjectAtIndex:7 withObject:UI_MAIN_COLOR];
            
        }
    }
    if (textField.tag == 108) {
        if (![CheckUtils checkUserName:textField.text]) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入正确的联系人关系"];
            [dataColor replaceObjectAtIndex:8 withObject:redColor];
        }else{
            [dataListAll replaceObjectAtIndex:8 withObject:textField.text];
            [dataColor replaceObjectAtIndex:8 withObject:UI_MAIN_COLOR];
        }
    }
    if (textField.tag == 109) {
        if (![CheckUtils checkUserName:textField.text] || [dataListAll[0] isEqualToString:textField.text] || [dataListAll[6] isEqualToString:textField.text]) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入正确的联系人姓名"];
            [dataColor replaceObjectAtIndex:9 withObject:redColor];
            
        }else{
            [dataListAll replaceObjectAtIndex:9 withObject:textField.text];
            [dataColor replaceObjectAtIndex:9 withObject:UI_MAIN_COLOR];
            
        }
    }
    if (textField.tag == 110) {
        NSString *tel = [textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        if (![CheckUtils checkTelNumber:tel] || [tel isEqualToString:_extTelphone.mobilePhone] || [dataListAll[7] isEqualToString:textField.text]) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入正确的联系人手机号"];
            [dataColor replaceObjectAtIndex:10 withObject:redColor];
            
        }else{
            [dataListAll replaceObjectAtIndex:10 withObject:textField.text];
            [dataColor replaceObjectAtIndex:10 withObject:UI_MAIN_COLOR];
            
        }
    }
    [_myTable reloadData];
    
}


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSLog(@"%@",NSStringFromRange(range));
    if (textField.tag == 107 || textField.tag == 110) {
        NSString* text = textField.text;
        //删除
        if([string isEqualToString:@""]){
            //删除一位
            if(range.length == 1){
                //最后一位,遇到空格则多删除一次
                if (range.location == text.length-1 ) {
                    if ([text characterAtIndex:text.length-1] == ' ') {
                        [textField deleteBackward];
                    }
                    return YES;
                }
                //从中间删除
                else{
                    NSInteger offset = range.location;
                    if (range.location < text.length && [text characterAtIndex:range.location] == ' ' && [textField.selectedTextRange isEmpty]) {
                        [textField deleteBackward];
                        offset --;
                    }
                    [textField deleteBackward];
                    textField.text = [self parseString:textField.text];
                    UITextPosition *newPos = [textField positionFromPosition:textField.beginningOfDocument offset:offset];
                    textField.selectedTextRange = [textField textRangeFromPosition:newPos toPosition:newPos];
                    return NO;
                }
            } else if (range.length > 1) {
                BOOL isLast = NO;
                //如果是从最后一位开始
                if(range.location + range.length == textField.text.length ){
                    isLast = YES;
                }
                [textField deleteBackward];
                textField.text = [self parseString:textField.text];
                NSInteger offset = range.location;
                if (range.location == 3 || range.location == 8) {
                    offset ++;
                } if (isLast) {
                    //光标直接在最后一位了
                }else{
                    UITextPosition *newPos = [textField positionFromPosition:textField.beginningOfDocument offset:offset];
                    textField.selectedTextRange = [textField textRangeFromPosition:newPos toPosition:newPos];
                }
                return NO;
            } else{
                return YES;
            }
        } else if(string.length >0){
            //限制输入字符个数
            if (([self noneSpaseString:textField.text].length + string.length - range.length > 11) ) {
                return NO;
            }
            //判断是否是纯数字(千杀的搜狗，百度输入法，数字键盘居然可以输入其他字符)
            //            if(![string isNum]){
            //                return NO;
            //            }
            [textField insertText:string];
            textField.text = [self parseString:textField.text];
            NSInteger offset = range.location + string.length;
            if (range.location == 3 || range.location == 8) {
                offset ++;
            }
            UITextPosition *newPos = [textField positionFromPosition:textField.beginningOfDocument offset:offset];
            textField.selectedTextRange = [textField textRangeFromPosition:newPos toPosition:newPos];
            return NO;
        }else{
            return YES;
        }
    }
    return YES;
}



-(NSString*)noneSpaseString:(NSString*)string {
    return [string stringByReplacingOccurrencesOfString:@" " withString:@""];
}


- (NSString*)parseString:(NSString*)string {
    if (!string) {
        return nil;
    }
    NSMutableString* mStr = [NSMutableString stringWithString:[string stringByReplacingOccurrencesOfString:@" " withString:@""]];
    if (mStr.length >3) {
        [mStr insertString:@" " atIndex:3];
    }if(mStr.length > 8) {
        [mStr insertString:@" " atIndex:8];
    }
    return mStr;
}


//判断第一页的参数 给人信息
-(BOOL)isCanSelectBtn{
    
    if ([CheckUtils checkUserName:[dataListAll objectAtIndex:0]] && [CheckUtils checkUserIdCard:[dataListAll objectAtIndex:1]] && [[dataListAll objectAtIndex:2] length] >1 && [[dataListAll objectAtIndex:3] length] >2 && [[dataListAll objectAtIndex:4] length] >=2 && [CheckUtils checkUserName:[dataListAll objectAtIndex:5]] && [CheckUtils checkUserName:[dataListAll objectAtIndex:6]] && [CheckUtils checkTelNumber:[[dataListAll objectAtIndex:7] stringByReplacingOccurrencesOfString:@" " withString:@""]] && [CheckUtils checkUserName:[dataListAll objectAtIndex:8]] && [CheckUtils checkUserName:[dataListAll objectAtIndex:9]] && [CheckUtils checkTelNumber:[[dataListAll objectAtIndex:10] stringByReplacingOccurrencesOfString:@" " withString:@""]]) {
        
        for(int i=2 ; i<15 ; i++)
        {
            [dataColor replaceObjectAtIndex:i withObject:UI_MAIN_COLOR];
        }

        
        return YES;
    }else {
        return NO;
    }
}

#pragma mark - 创建PIckView --UIPickerViewDelegate
-(void)createPickViewShowWithTag:(NSInteger)tag
{
    [self.view endEditing:YES];
    [self setRomovePickView];
    switch (tag) {
            
        case 103://现在居住地址
        {
            _pickerTag = tag;
            _localPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, _k_h-183, _k_w, 183)];
            _localPicker.backgroundColor = [UIColor whiteColor];
            _localPicker.dataSource = self;
            _localPicker.delegate = self;
            [self.view addSubview:_localPicker];
        }
            break;
        case 105://现在居住地址
        {
            _pickerTag = tag;
            _localPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, _k_h-183, _k_w, 183)];
            _localPicker.backgroundColor = [UIColor whiteColor];
            _localPicker.dataSource = self;
            _localPicker.delegate = self;
            [self.view addSubview:_localPicker];
        }
            break;
        case 108://现在居住地址
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
    if (_pickerTag == 105 || _pickerTag == 108) {
        return 1;
    }
    return 3;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    if (_pickerTag == 105 || _pickerTag == 108) {
        return 60.0;
    }
    return 44.0;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (_pickerTag == 105 || _pickerTag == 108) {
        return _contact2.count;
    }else{
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

#pragma mark--UIPickerViewDelegate
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (_pickerTag == 105) {
        return [_contact1 objectAtIndex:row];
    }else if (_pickerTag == 108) {
        return [_contact2 objectAtIndex:row];
    }else{
        if (component==FirstComponent) {
            return [_pickerArray objectAtIndex:row];
        }
        
        if (component==SubComponent) {
            if (_subPickerArray.count-1 < row) {
                return _subPickerArray[0];
            }
            return [_subPickerArray objectAtIndex:row];
        }
        
        if (component==ThirdComponent) {
            if (_thirdPickerArray.count-1 < row) {
               return [_thirdPickerArray objectAtIndex:0];
            }
            return [_thirdPickerArray objectAtIndex:row];
        }
    }
    return nil;
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    //    NSLog(@"row is %ld,Component is %ld",row,component);
    if (_pickerTag == 105) {
        [dataListAll replaceObjectAtIndex:5 withObject:_contact1[row]];
    }else if(_pickerTag == 108){
        [dataListAll replaceObjectAtIndex:8 withObject:_contact2[row]];
    }else{
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
                //取出区
                [_thirdPickerArray addObject:[regionResultModel.sub[j] objectForKey:@"name"]];
                
            }
            [pickerView selectRow:0 inComponent:2 animated:YES];
        }
        
        [pickerView reloadComponent:2];
    }
    
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if (_pickerTag == 105 || _pickerTag == 108) {
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

- (NSDictionary *)getInfoMsg
{
    NSString *degree = @"";
    for (int i = 0; i < eduLevelArray.count; i++) {
        if ([eduLevelArray[i] isEqualToString:dataListAll[2]]) {
            degree = [NSString stringWithFormat:@"%d",i+1];
        }
    }
    NSString *contactShip =@"";
    if ([dataListAll[5] isEqualToString:@"父母"]) {
        contactShip = @"1";
    }else if ([dataListAll[5] isEqualToString:@"配偶"]){
        contactShip = @"2";
    }
    NSString *contactShip1 = @"";
    if ([dataListAll[8] isEqualToString:@"朋友"]) {
        contactShip1 = @"8";
    }else if ([dataListAll[8] isEqualToString:@"同事"]){
        contactShip1 = @"4";
    }
    NSString *addressDetail = [dataListAll[4] stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *tel1 = [dataListAll[7] stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *tel2 = [dataListAll[10] stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    
    return @{@"customer_name_":[dataListAll objectAtIndex:0],
             @"id_type_":@"1",
             @"id_code_":[dataListAll objectAtIndex:1],
             @"education_level_":degree,
             @"province_":_cityCode.provinceCode,
             @"city_":_cityCode.cityCode,
             @"county_":_cityCode.districtCode,
             @"home_address_":addressDetail,
             @"relationship_":contactShip,
             @"contact_name_":[dataListAll objectAtIndex:6],
             @"contact_phone_":tel1,
             @"relationship1_":contactShip1,
             @"contact_name1_":[dataListAll objectAtIndex:9],
             @"contact_phone1_":tel2
             };
    
}


#pragma mark-> action
- (void)cellBtnClick:(UIButton *)sender
{
    switch (sender.tag) {
        case 2:
        {
            DLog(@"保存");
            [self PostGetCityCode:dataListAll[11]];
            
        }
            break;
        case 102://学历
        {
            _colledgeView = [[[NSBundle mainBundle] loadNibNamed:@"ColledgeView" owner:self options:nil] lastObject];
            _colledgeView.frame = CGRectMake(0, 0, _k_w, _k_h);
            _colledgeView.delegate = self;
            [_colledgeView show];
        }
            break;
        case 103:
            DLog(@"现居地址");
            if (_pickerArray.count != 34) {
                [self PostGetCity];
            }
            
            [self createPickViewShowWithTag:103];
            break;
        case 105:
            DLog(@"联系人");
            [self createPickViewShowWithTag:105];
            break;
            
        case 108:
        {
            DLog(@"联系人2");
            [self createPickViewShowWithTag:108];
        }
            break;
        case 106:{
            ContactViewController *conVC = [ContactViewController new];
            conVC.delegate = self;
            conVC.tagFlage = 207;
            [self.navigationController pushViewController:conVC animated:YES];
        }break;
        case 109:{
            ContactViewController *conVC = [ContactViewController new];
            conVC.delegate = self;
            conVC.tagFlage = 210;
            [self.navigationController pushViewController:conVC animated:YES];
        }break;
        default:
            break;
    }
    
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

#pragma mark->ColledgeViewDelegate
-(void)ColledgeDelegateNString:(NSString *)CollString andIndex:(NSIndexPath *)indexPath
{
    [dataListAll replaceObjectAtIndex:2 withObject:CollString];
    //    [dataColor replaceObjectAtIndex:2 withObject:UI_MAIN_COLOR];
    [_myTable reloadData];
}
- (IBAction)cancleBtn:(id)sender {
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

- (IBAction)donebtn:(id)sender {
    [self.view endEditing:YES];
    if (_pickerTag == 103) {
        
        NSString *localString = @"";
        NSString *loString = @"";
        if (_thirdPickerArray.count > 0) {
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
        
        [dataListAll replaceObjectAtIndex:11 withObject:loString];
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
        
    }
    if (_pickerTag == 105) {
        if([dataListAll[5] isEqualToString:@""])
        {
            [dataListAll replaceObjectAtIndex:5 withObject:@"父母"];
        }
        [dataColor replaceObjectAtIndex:5 withObject:UI_MAIN_COLOR];
    }
    if (_pickerTag == 108) {
        if([dataListAll[8] isEqualToString:@""])
        {
            [dataListAll replaceObjectAtIndex:8 withObject:@"同事"];
        }
        [dataColor replaceObjectAtIndex:8 withObject:UI_MAIN_COLOR];
    }
    
    [_myTable reloadData];
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

//个人基本信息
- (void)setValueOfDataArr
{
    if (_customerBaseInfoModel.result.customerName) {
        [dataListAll replaceObjectAtIndex:0 withObject:_customerBaseInfoModel.result.customerName];
    }
    if (_customerBaseInfoModel.result.idCode) {
        [dataListAll replaceObjectAtIndex:1 withObject:_customerBaseInfoModel.result.idCode];
    }
    //学历
    NSInteger eduLevel = [_customerBaseInfoModel.result.educationLevel floatValue];
    for (int i = 1; i<7; i++) {
        if (i == eduLevel) {
            [dataListAll replaceObjectAtIndex:2 withObject:eduLevelArray[i-1]];
        }
    }
    if (_customerBaseInfoModel.result.provinceName && _customerBaseInfoModel.result.cityName && _customerBaseInfoModel.result.countyName) {
        NSString *proviece_city = @"";
        NSString *poro = [NSString stringWithFormat:@"%@/%@/%@",_customerBaseInfoModel.result.provinceName,_customerBaseInfoModel.result.cityName,_customerBaseInfoModel.result.countyName];;
        
        if ([_customerBaseInfoModel.result.provinceName isEqualToString: _customerBaseInfoModel.result.cityName]) {
            proviece_city = [NSString stringWithFormat:@"%@/%@",_customerBaseInfoModel.result.cityName,_customerBaseInfoModel.result.countyName];
        }else if ([_customerBaseInfoModel.result.countyName isEqualToString: _customerBaseInfoModel.result.cityName]){
            proviece_city = [NSString stringWithFormat:@"%@/%@",_customerBaseInfoModel.result.provinceName,_customerBaseInfoModel.result.cityName];
        }else{
            proviece_city = [NSString stringWithFormat:@"%@/%@/%@",_customerBaseInfoModel.result.provinceName,_customerBaseInfoModel.result.cityName,_customerBaseInfoModel.result.countyName];
        }
        
        [dataListAll replaceObjectAtIndex:11 withObject:poro];
        [dataListAll replaceObjectAtIndex:3 withObject:proviece_city];
    }else{
        //现居地址
        if (_customerBaseInfoModel.result.province && _customerBaseInfoModel.result.city && _customerBaseInfoModel.result.county) {
            NSString *proviece_city = [NSString stringWithFormat:@"%@/%@/%@",_customerBaseInfoModel.result.province,_customerBaseInfoModel.result.city,_customerBaseInfoModel.result.county];
            [dataListAll replaceObjectAtIndex:11 withObject:proviece_city];
            [dataListAll replaceObjectAtIndex:3 withObject:proviece_city];
        }
        
    }
    //详细
    if (_customerBaseInfoModel.result.homeAddress) {
        
        [dataListAll replaceObjectAtIndex:4 withObject:_customerBaseInfoModel.result.homeAddress];
    }
    
    if (_customerBaseInfoModel.result.contactBean.count >= 2) {
        CustomerBaseInfoContactBean *contactBeanModel= _customerBaseInfoModel.result.contactBean[0];
        CustomerBaseInfoContactBean *contactBeanModel1= _customerBaseInfoModel.result.contactBean[1];
        if ([contactBeanModel.relationship isEqualToString:@"1"] || [contactBeanModel.relationship isEqualToString:@"2"]) {
            if (contactBeanModel.relationship) {
                if ([contactBeanModel.relationship isEqualToString:@"1"]) {
                    [dataListAll replaceObjectAtIndex:5 withObject:@"父母"];
                }
                if ([contactBeanModel.relationship isEqualToString:@"2"]) {
                    [dataListAll replaceObjectAtIndex:5 withObject:@"配偶"];
                }
                
            }
            //姓名
            if (contactBeanModel.contactName) {
                [dataListAll replaceObjectAtIndex:6 withObject:contactBeanModel.contactName];
            }
            //电话
            if (contactBeanModel.contactPhone) {
                [dataListAll replaceObjectAtIndex:7 withObject:[self formatString:contactBeanModel.contactPhone]];
            }
            
            
            if (contactBeanModel1.relationship) {
                if ([contactBeanModel1.relationship isEqualToString:@"4"]) {
                    [dataListAll replaceObjectAtIndex:8 withObject:@"同事"];
                }
                if ([contactBeanModel1.relationship isEqualToString:@"8"]) {
                    [dataListAll replaceObjectAtIndex:8 withObject:@"朋友"];
                }
                
            }
            //姓名
            if (contactBeanModel1.contactName) {
                [dataListAll replaceObjectAtIndex:9 withObject:contactBeanModel1.contactName];
            }
            //电话
            if (contactBeanModel1.contactPhone) {
                [dataListAll replaceObjectAtIndex:10 withObject:[self formatString: contactBeanModel1.contactPhone]];
            }
            
        }else{
            if (contactBeanModel1.relationship) {
                if ([contactBeanModel1.relationship isEqualToString:@"1"]) {
                    [dataListAll replaceObjectAtIndex:5 withObject:@"父母"];
                }
                if ([contactBeanModel1.relationship isEqualToString:@"2"]) {
                    [dataListAll replaceObjectAtIndex:5 withObject:@"配偶"];
                }
                
            }
            //姓名
            if (contactBeanModel1.contactName) {
                [dataListAll replaceObjectAtIndex:6 withObject:contactBeanModel1.contactName];
            }
            //电话
            if (contactBeanModel1.contactPhone) {
                [dataListAll replaceObjectAtIndex:7 withObject:[self formatString:contactBeanModel1.contactPhone]];
            }
            
            
            if (contactBeanModel.relationship) {
                if ([contactBeanModel.relationship isEqualToString:@"4"]) {
                    [dataListAll replaceObjectAtIndex:8 withObject:@"同事"];
                }
                if ([contactBeanModel.relationship isEqualToString:@"8"]) {
                    [dataListAll replaceObjectAtIndex:8 withObject:@"朋友"];
                }
                
            }
            //姓名
            if (contactBeanModel.contactName) {
                [dataListAll replaceObjectAtIndex:9 withObject:contactBeanModel.contactName];
            }
            //电话
            if (contactBeanModel.contactPhone) {
                [dataListAll replaceObjectAtIndex:10 withObject:[self formatString: contactBeanModel.contactPhone]];
            }
            
        }

    }
    
        [_myTable reloadData];
    
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

#pragma mark->获取个人信息
-(void)PostPersonInfoMessage
{
    GetCustomerBaseViewModel *customBaseViewModel = [[GetCustomerBaseViewModel alloc] init];
    [customBaseViewModel setBlockWithReturnBlock:^(id returnValue) {
        _customerBaseInfoModel = returnValue;
        if ([_customerBaseInfoModel.flag isEqualToString:@"0000"]) {
            _extTelphone = _customerBaseInfoModel.ext;
            [self setValueOfDataArr];
        }
    } WithFaileBlock:^{
        
    }];
    [customBaseViewModel fatchCustomBaseInfo:nil];
    
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


#pragma mark-> 通讯录协议

-(void)GetContactName:(NSString *)name TelPhone:(NSString *)telph andFlagTure:(NSInteger)flagInteger
{
    if ([CheckUtils checkTelNumber:telph] && ![telph isEqualToString:_extTelphone.mobilePhone]) {
        if (flagInteger == 207) {
            if([CheckUtils checkUserName:name]){
                [dataListAll replaceObjectAtIndex:6 withObject:name];
                [dataColor replaceObjectAtIndex:6 withObject:UI_MAIN_COLOR];
            }else{
                NSString *na = @"";
                if (name) {
                    na = name;
                }
                [dataListAll replaceObjectAtIndex:6 withObject:na];
                [dataColor replaceObjectAtIndex:6 withObject:redColor];
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入正确的联系人姓名"];
            }
            
            [dataListAll replaceObjectAtIndex:7 withObject:[self formatString:telph]];
            
            [dataColor replaceObjectAtIndex:7 withObject:UI_MAIN_COLOR];
        }
        if (flagInteger == 210) {
            if ([CheckUtils checkUserName:name]) {
                [dataListAll replaceObjectAtIndex:9 withObject:name];
                [dataColor replaceObjectAtIndex:9 withObject:UI_MAIN_COLOR];
            }else{
                NSString *na = @"";
                if (name) {
                    na = name;
                }
                [dataColor replaceObjectAtIndex:9 withObject:redColor];
                [dataListAll replaceObjectAtIndex:9 withObject:na];
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入正确的联系人姓名"];

            }
            
            [dataListAll replaceObjectAtIndex:10 withObject:[self formatString:telph]];
            
            [dataColor replaceObjectAtIndex:10 withObject:UI_MAIN_COLOR];
        }
        
    }else{
        NSString *na = @"";
        if (name) {
            na = name;
        }
        
        NSString *tel = @"";
        if (telph) {
            tel = telph;
        }

        if (flagInteger == 207) {
            [dataListAll replaceObjectAtIndex:6 withObject:na];
            [dataListAll replaceObjectAtIndex:7 withObject:tel];
            [dataColor replaceObjectAtIndex:6 withObject:redColor];
            [dataColor replaceObjectAtIndex:7 withObject:redColor];
        }
        if (flagInteger == 210) {
            [dataColor replaceObjectAtIndex:9 withObject:redColor];
            [dataColor replaceObjectAtIndex:10 withObject:redColor];
            [dataListAll replaceObjectAtIndex:9 withObject:na];
            [dataListAll replaceObjectAtIndex:10 withObject:tel];
        }
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请选取通讯录中的手机号"];
    }
    [_myTable reloadData];
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
                [self PostGetInfoMesage];
                
            } else {
                
            }
        }
    } failure:^(EnumServerStatus status, id object) {
        
    }];
}

#pragma mark ->保存信息
-(void)PostGetInfoMesage
{
    if (![_cityCode.provinceCode isEqualToString:@""] && ![_cityCode.cityCode isEqualToString:@""] && ![_cityCode.districtCode isEqualToString:@""]) {
        NSDictionary *dicParam = [self getInfoMsg];
        
        SaveCustomBaseViewModel *saveCustomBaseViewModel = [[SaveCustomBaseViewModel alloc] init];
        [saveCustomBaseViewModel setBlockWithReturnBlock:^(id returnValue) {
            if ([[returnValue objectForKey:@"flag"]isEqualToString:@"0000"]) {
                [self.navigationController popViewControllerAnimated:YES];
            } else {
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:[returnValue objectForKey:@"msg"]];
            }
        } WithFaileBlock:^{
            
        }];
        [saveCustomBaseViewModel saveCustomBaseInfo:dicParam];
    }else{
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请重新选择省市区"];
    }
    
}

@end
