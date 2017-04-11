//
//  UserContactsViewController.m
//  fxdProduct
//
//  Created by dd on 2017/2/22.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "UserContactsViewController.h"
#import "LabelCell.h"
#import "ContactClass.h"
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_9_0
#import <Contacts/Contacts.h>
#import <ContactsUI/ContactsUI.h>
#endif
#import <AddressBookUI/ABPeoplePickerNavigationController.h>
#import <AddressBook/ABPerson.h>
#import <AddressBookUI/ABPersonViewController.h>
#import "ContactList.h"
#import "ContactClass.h"
#import "Custom_BaseInfo.h"

#define CellBGColorNormal rgb(0, 170, 238)
#define CellBGColorRed rgb(252, 0, 6)

@interface UserContactsViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate,CNContactPickerDelegate,ABPeoplePickerNavigationControllerDelegate>
{
    NSArray *_placeHolderArr;
    NSArray *_contact1;
    NSArray *_contact2;
    NSInteger _pickerTag;
    NSMutableArray *dataListAll;
    NSMutableArray *dataColor;
    UIButton *_saveBtn;
    NSInteger _flagTag;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) UIPickerView *localPicker;

@end

@implementation UserContactsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    [self addBackItem];
    self.navigationItem.title = @"联系人信息";
    _placeHolderArr = @[@"从通讯录读取联系人会增加审核通过率",@"联系人关系",@"联系人1姓名",@"联系人1号码",@"联系人关系",@"联系人2姓名",@"联系人2号码"];
    _contact1 = @[@"父母",@"配偶"];
    _contact2 = @[@"同事",@"朋友"];
    _flagTag = 0;
    _toolbarCancelDone.hidden = true;
    if (UI_IS_IPHONE5) {
        self.automaticallyAdjustsScrollViewInsets = false;
    }
    NSString *device = [[UIDevice currentDevice] systemVersion];
    if (device.floatValue>10) {
        
        self.automaticallyAdjustsScrollViewInsets = true;
    }else{
        
        self.automaticallyAdjustsScrollViewInsets = false;
    }
    
    dataListAll = [NSMutableArray array];
    dataColor = [NSMutableArray array];
    for (int i = 0; i < 6; i++) {
        [dataColor addObject:CellBGColorNormal];
        [dataListAll addObject:@""];
    }
    
    [self configTableView];
    [self setDataInfo];
}

- (void)configTableView
{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TelPhoneCompanyCell class]) bundle:nil] forCellReuseIdentifier:@"TelPhoneCompanyCell"];
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

- (void)setDataInfo
{
    if (_custom_baseInfo.result.contactBean.count > 1) {
        ContactBean *contact1 = _custom_baseInfo.result.contactBean[0];
        ContactBean *contact2 = _custom_baseInfo.result.contactBean[1];
        if ([contact1.relationship isEqualToString:@"1"] || [contact1.relationship isEqualToString:@"2"]) {
            if (contact1.relationship) {
                if ([contact1.relationship isEqualToString:@"1"]) {
                    [dataListAll replaceObjectAtIndex:0 withObject:@"父母"];
                }
                if ([contact1.relationship isEqualToString:@"2"]) {
                    [dataListAll replaceObjectAtIndex:0 withObject:@"配偶"];
                }
            }
            //姓名
            if (contact1.contactName && ![contact1.contactName isEqualToString:_custom_baseInfo.result.customerName]) {
                [dataListAll replaceObjectAtIndex:1 withObject:contact1.contactName];
            }
            //电话
            if (contact1.contactPhone && ![_custom_baseInfo.ext.mobilePhone isEqualToString:contact1.contactPhone]) {
                [dataListAll replaceObjectAtIndex:2 withObject:[self formatString:contact1.contactPhone]];
            }
            
            if (contact2.relationship) {
                if ([contact2.relationship isEqualToString:@"4"]) {
                    [dataListAll replaceObjectAtIndex:3 withObject:@"同事"];
                }
                if ([contact2.relationship isEqualToString:@"8"]) {
                    [dataListAll replaceObjectAtIndex:3 withObject:@"朋友"];
                }
            }
            //姓名
            if (contact2.contactName && ![contact2.contactName isEqualToString:_custom_baseInfo.result.customerName] && ![contact1.contactName isEqualToString:contact2.contactName]) {
                [dataListAll replaceObjectAtIndex:4 withObject:contact2.contactName];
            }
            //电话
            if (contact2.contactPhone && ![contact2.contactPhone isEqualToString:contact1.contactPhone] && ![_custom_baseInfo.ext.mobilePhone isEqualToString:contact2.contactPhone]) {
                [dataListAll replaceObjectAtIndex:5 withObject:[self formatString: contact2.contactPhone]];
            }
        }else {
            if (contact2.relationship) {
                if ([contact2.relationship isEqualToString:@"1"]) {
                    [dataListAll replaceObjectAtIndex:0 withObject:@"父母"];
                }
                if ([contact2.relationship isEqualToString:@"2"]) {
                    [dataListAll replaceObjectAtIndex:0 withObject:@"配偶"];
                }
            }
            //姓名
            if (contact2.contactName && ![_custom_baseInfo.result.countyName isEqualToString:contact2.contactName]) {
                [dataListAll replaceObjectAtIndex:1 withObject:contact2.contactName];
            }
            //电话
            if (contact2.contactPhone && ![_custom_baseInfo.ext.mobilePhone isEqualToString:contact2.contactPhone]) {
                [dataListAll replaceObjectAtIndex:2 withObject:[self formatString:contact2.contactPhone]];
            }
            
            
            if (contact1.relationship) {
                if ([contact1.relationship isEqualToString:@"4"]) {
                    [dataListAll replaceObjectAtIndex:3 withObject:@"同事"];
                }
                if ([contact1.relationship isEqualToString:@"8"]) {
                    [dataListAll replaceObjectAtIndex:3 withObject:@"朋友"];
                }
            }
            //姓名
            if (contact1.contactName && ![contact1.contactName isEqualToString:_custom_baseInfo.result.customerName] && ![contact1.contactName isEqualToString:contact2.contactName]) {
                [dataListAll replaceObjectAtIndex:4 withObject:contact1.contactName];
            }
            //电话
            if (contact1.contactPhone && ![_custom_baseInfo.ext.mobilePhone isEqualToString:contact1.contactPhone] && ![contact2.contactPhone isEqualToString:contact1.contactPhone]) {
                [dataListAll replaceObjectAtIndex:5 withObject:[self formatString: contact1.contactPhone]];
            }
        }
    }
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

- (NSDictionary *)getContactsInfo
{
    NSString *contactShip =@"";
    if ([dataListAll[0] isEqualToString:@"父母"]) {
        contactShip = @"1";
    }else if ([dataListAll[0] isEqualToString:@"配偶"]){
        contactShip = @"2";
    }
    NSString *contactShip1 = @"";
    if ([dataListAll[3] isEqualToString:@"朋友"]) {
        contactShip1 = @"8";
    }else if ([dataListAll[3] isEqualToString:@"同事"]){
        contactShip1 = @"4";
    }
    NSString *tel = [dataListAll[2] stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *tel1 = [dataListAll[5] stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSDictionary *paramDic = @{@"relationship_":contactShip,
                               @"contact_name_":dataListAll[1],
                               @"contact_phone_":tel,
                               @"relationship1_":contactShip1,
                               @"contact_name1_":dataListAll[4],
                               @"contact_phone1_":tel1};
    
    return paramDic;
}


#pragma mark - 联系人保存
- (void)saveBtnClick
{
    DLog(@"保存");
    
    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_customerContact_url] parameters:[self getContactsInfo] finished:^(EnumServerStatus status, id object) {
        if ([[object valueForKey:@"flag"] isEqualToString:@"0000"]) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow  message:[object valueForKey:@"msg"]];
            [self.navigationController popViewControllerAnimated:true];
        } else {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:[object valueForKey:@"msg"]];
        }
    } failure:^(EnumServerStatus status, id object) {
        
    }];
}

#pragma mark - TableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
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
    }else{
        LabelCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"abcde%ld",indexPath.row]];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"LabelCell" owner:self options:nil] lastObject];
        }
        if(indexPath.row == 3 || indexPath.row == 6)
        {
            cell.textField.keyboardType =UIKeyboardTypePhonePad;
        }
        cell.textField.placeholder = _placeHolderArr[indexPath.row];
        cell.textField.tag = indexPath.row +10;
        cell.textField.delegate = self;
        cell.textField.text = dataListAll[indexPath.row-1];
        if (indexPath.row ==3 || indexPath.row == 6) {
            cell.btn.hidden = YES;
        }else{
            cell.btn.hidden = NO;
            cell.btn.tag = indexPath.row + 100;
            if (indexPath.row == 2 || indexPath.row == 5) {
                [cell.btn setBackgroundImage:[UIImage imageNamed:@"cotactIco"] forState:UIControlStateNormal];
            } else {
                [cell.btn setBackgroundImage:[UIImage imageNamed:@"3_lc_icon_25"] forState:UIControlStateNormal];
            }
            [cell.btn addTarget:self action:@selector(senderBtn:) forControlEvents:UIControlEventTouchUpInside];
        }
        cell.btnSecory.hidden =YES;
        [Tool setCorner:cell.bgView borderColor:dataColor[indexPath.row-1]];
        cell.selectionStyle  = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}

-(void)senderBtn:(UIButton *)sender
{
    switch (sender.tag) {
        case 101:
        {
            [self createPickViewShowWithTag:101];
        }
            break;
        case 104:
        {
            [self createPickViewShowWithTag:104];
        }
            break;
        case 102:
        {
            DLog(@"选择通讯录");
            _flagTag = 102;
            if (kiOS9Later) {
                CNContactPickerViewController * con = [[CNContactPickerViewController alloc] init];
                con.delegate = self;
                [self presentViewController:con animated:true completion:nil];
            } else {
                ABPeoplePickerNavigationController *nav = [[ABPeoplePickerNavigationController alloc] init];
                nav.peoplePickerDelegate = self;
                nav.predicateForSelectionOfPerson = [NSPredicate predicateWithValue:false];
                [self presentViewController:nav animated:YES completion:nil];
            }
            
        }
            break;
        case 105:
        {
            DLog(@"选择通讯录");
            _flagTag = 105;
            if (kiOS9Later) {
                CNContactPickerViewController * con = [[CNContactPickerViewController alloc] init];
                con.delegate = self;
                [self presentViewController:con animated:true completion:nil];
            } else {
                ABPeoplePickerNavigationController *nav = [[ABPeoplePickerNavigationController alloc] init];
                nav.peoplePickerDelegate = self;
                nav.predicateForSelectionOfPerson = [NSPredicate predicateWithValue:false];
                [self presentViewController:nav animated:YES completion:nil];
            }
            
        }
            break;
        default:
            break;
    }
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
    if (_pickerTag == 101) {
        if([dataListAll[0] isEqualToString:@""])
        {
            [dataListAll replaceObjectAtIndex:0 withObject:@"父母"];
        }
        [dataColor replaceObjectAtIndex:0 withObject:CellBGColorNormal];
    }else {
        if([dataListAll[3] isEqualToString:@""])
        {
            [dataListAll replaceObjectAtIndex:3 withObject:@"同事"];
        }
        [dataColor replaceObjectAtIndex:3 withObject:CellBGColorNormal];
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

#pragma mark - CNContactPickerDelegate
- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContactProperty:(CNContactProperty *)contactProperty
{
    CNContact *contact = contactProperty.contact;
    CNPhoneNumber *phoneNumber = contactProperty.value;
    NSString *fullName = [CNContactFormatter stringFromContact:contact style:CNContactFormatterStyleFullName];
    if (!fullName || [fullName isEqualToString:@""]) {
        fullName = @"";
    }
    NSString *phoneNumStr = @"";
    if (phoneNumber && ![phoneNumber isEqual:@""]) {
        phoneNumStr = [phoneNumber.stringValue stringByReplacingOccurrencesOfString:@"-" withString:@""];
        if ([phoneNumStr hasPrefix:@"+"]) {
            phoneNumStr = [phoneNumStr substringFromIndex:3];
        }
    }
    
    [picker dismissViewControllerAnimated:true completion:^{
        [self contactSelect:fullName phone:phoneNumStr];
        ContactClass *contact = [[ContactClass alloc] init];
        [self uploadUserContact:[contact getAllContact]];
    }];
}

#pragma mark - ABPeoplePickerNavigationControllerDelegate

- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
    [peoplePicker dismissViewControllerAnimated:YES completion:nil];
}

- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier {
    ABMultiValueRef phone = ABRecordCopyValue(person, kABPersonPhoneProperty);
    long index = ABMultiValueGetIndexForIdentifier(phone,identifier);
    NSString *firstName = CFBridgingRelease(ABRecordCopyValue(person, kABPersonFirstNameProperty));
    
    NSString *lastName = CFBridgingRelease(ABRecordCopyValue(person, kABPersonLastNameProperty));
    NSString *phoneNO = (__bridge NSString *)ABMultiValueCopyValueAtIndex(phone, index);
    
    NSString *fullName = [NSString stringWithFormat:@"%@%@",lastName==nil?@"":lastName,firstName==nil?@"":firstName];
    
    if ([phoneNO hasPrefix:@"+"]) {
        phoneNO = [phoneNO substringFromIndex:3];
    }
    
    phoneNO = [phoneNO stringByReplacingOccurrencesOfString:@"-" withString:@""];
    DLog(@"%@", phoneNO);
    if (phone && fullName) {
        [peoplePicker dismissViewControllerAnimated:YES completion:^{
            [self contactSelect:fullName phone:phoneNO];
            ContactList *contact = [[ContactList alloc] init];
            [self uploadUserContact:[contact getContactList]];
        }];
        return;
    }
}

- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person
{
    ABPersonViewController *personViewController = [[ABPersonViewController alloc] init];
    personViewController.displayedPerson = person;
    [peoplePicker pushViewController:personViewController animated:YES];
}


- (void)uploadUserContact:(NSArray *)conArr
{
    NSData *data = [NSJSONSerialization dataWithJSONObject:conArr options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSDictionary *dict = @{@"userContactsBaseBean":jsonStr};
    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_saveUserContacts_jhtml] parameters:dict finished:^(EnumServerStatus status, id object) {
        if (status == Enum_SUCCESS) {
            if ([[object objectForKey:@"flag"]isEqualToString:@"0000"]) {
                
            } else {
                
            }
        }
    } failure:^(EnumServerStatus status, id object) {
        
    }];
}


- (void)contactSelect:(NSString *)name phone:(NSString *)phoneNum
{
    if (_flagTag == 102) {
        if ([CheckUtils checkUserName:name]) {
            if ([dataListAll[4] isEqualToString:name]) {
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"两个联系人名称不能一致"];
                [dataColor replaceObjectAtIndex:1 withObject:CellBGColorRed];
            } else {
                [dataListAll replaceObjectAtIndex:1 withObject:name];
                [dataColor replaceObjectAtIndex:1 withObject:CellBGColorNormal];
            }
            
        } else {
            [dataListAll replaceObjectAtIndex:1 withObject:@""];
            [dataColor replaceObjectAtIndex:1 withObject:CellBGColorRed];
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入正确的联系人姓名"];
            [_tableView reloadData];
            return;
        }
        
        if ([CheckUtils checkTelNumber:phoneNum]) {
            if ([phoneNum isEqualToString:dataListAll[5]]) {
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"两个联系人号码不能一致"];
                [dataColor replaceObjectAtIndex:2 withObject:CellBGColorRed];
            } else if ([phoneNum isEqualToString:[Utility sharedUtility].userInfo.userMobilePhone]) {
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"联系人号码不能与本人号码一致"];
                [dataColor replaceObjectAtIndex:2 withObject:CellBGColorRed];
            }
            else {
                [dataListAll replaceObjectAtIndex:2 withObject:phoneNum];
                [dataColor replaceObjectAtIndex:2 withObject:CellBGColorNormal];
            }
            
        } else {
            [dataListAll replaceObjectAtIndex:2 withObject:@""];
            [dataColor replaceObjectAtIndex:2 withObject:CellBGColorRed];
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入正确的手机号"];
        }
        
        [_tableView reloadData];
    }
    if (_flagTag == 105) {
        if ([CheckUtils checkUserName:name]) {
            if ([dataListAll[1] isEqualToString:name]) {
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"两个联系人名称不能一致"];
                [dataColor replaceObjectAtIndex:4 withObject:CellBGColorRed];
            } else {
                [dataListAll replaceObjectAtIndex:4 withObject:name];
                [dataColor replaceObjectAtIndex:4 withObject:CellBGColorNormal];
            }
        } else {
            [dataListAll replaceObjectAtIndex:4 withObject:@""];
            [dataColor replaceObjectAtIndex:4 withObject:CellBGColorRed];
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入正确的联系人姓名"];
            [_tableView reloadData];
            return;
        }
        
        if ([CheckUtils checkTelNumber:phoneNum]) {
            if ([dataListAll[2] isEqualToString:phoneNum]) {
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"两个联系人号码不能一致"];
                [dataColor replaceObjectAtIndex:5 withObject:CellBGColorRed];
            }else if ([phoneNum isEqualToString:[Utility sharedUtility].userInfo.userMobilePhone]) {
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"两个联系人号码不能一致"];
                [dataColor replaceObjectAtIndex:2 withObject:CellBGColorRed];
            }
            else {
                [dataListAll replaceObjectAtIndex:5 withObject:phoneNum];
                [dataColor replaceObjectAtIndex:5 withObject:CellBGColorNormal];
            }
        } else {
            [dataListAll replaceObjectAtIndex:5 withObject:@""];
            [dataColor replaceObjectAtIndex:5 withObject:CellBGColorRed];
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入正确的手机号"];
        }
        
        [_tableView reloadData];
    }
}


#pragma mark - 创建PIckView --UIPickerViewDelegate
-(void)createPickViewShowWithTag:(NSInteger)tag
{
    [self.view endEditing:YES];
    [self setRomovePickView];
    
    _pickerTag = tag;
    _localPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, _k_h-183, _k_w, 183)];
    _localPicker.backgroundColor = [UIColor whiteColor];
    _localPicker.dataSource = self;
    _localPicker.delegate = self;
    [self.view addSubview:_localPicker];
}

#pragma mark--UIPickerViewDataSource
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 60.f;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _contact2.count;
}

#pragma mark--UIPickerViewDelegate
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (_pickerTag == 101) {
        return [_contact1 objectAtIndex:row];
    }else {
        return [_contact2 objectAtIndex:row];
    }
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (_pickerTag == 101) {
        [dataListAll replaceObjectAtIndex:0 withObject:_contact1[row]];
    }else {
        [dataListAll replaceObjectAtIndex:3 withObject:_contact2[row]];
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return 300.f;
}


-(void)setRomovePickView
{
    _toolbarCancelDone.hidden = NO;
    [self.view bringSubviewToFront:_toolbarCancelDone];
    _toolbarCancelDone.backgroundColor =  rgb(241, 241, 241);
    [_localPicker removeFromSuperview];
}

#pragma mark - UITextFieldDelegate

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField.tag == 11 || textField.tag == 14) {
        return NO;
    }
    
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.tag == 13 || textField.tag == 16) {
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

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag == 11) {
        if (![CheckUtils checkUserName:textField.text]) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入正确的联系人关系"];
            [dataColor replaceObjectAtIndex:0 withObject:CellBGColorRed];
        }else{
            [dataListAll replaceObjectAtIndex:0 withObject:textField.text];
            [dataColor replaceObjectAtIndex:0 withObject:CellBGColorNormal];
        }
    }
    if (textField.tag == 12) {
        if (![CheckUtils checkUserNameHanzi:textField.text]) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入正确的联系人姓名"];
            [dataColor replaceObjectAtIndex:1 withObject:CellBGColorRed];
            
        }
        else if ([textField.text isEqualToString:dataListAll[4]]){
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"联系人名称不能与本人一致"];
            [dataColor replaceObjectAtIndex:1 withObject:CellBGColorRed];
        }
        else{
            [dataListAll replaceObjectAtIndex:1 withObject:textField.text];
            [dataColor replaceObjectAtIndex:1 withObject:CellBGColorNormal];
            
        }
    }
    if (textField.tag == 13) {
        NSString *telString = [textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        if (![CheckUtils checkTelNumber:telString]) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入正确的联系人手机号"];
            [dataColor replaceObjectAtIndex:2 withObject:CellBGColorRed];
            
        }else if ([telString isEqualToString:[Utility sharedUtility].userInfo.userMobilePhone]){
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"联系人号码不能与本人一致"];
            [dataColor replaceObjectAtIndex:2 withObject:CellBGColorRed];
        }
        else{
            [dataListAll replaceObjectAtIndex:2 withObject:textField.text];
            [dataColor replaceObjectAtIndex:2 withObject:CellBGColorNormal];
            
        }
    }
    if (textField.tag == 14) {
        if (![CheckUtils checkUserName:textField.text]) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入正确的联系人关系"];
            [dataColor replaceObjectAtIndex:3 withObject:CellBGColorRed];
        }else{
            [dataListAll replaceObjectAtIndex:3 withObject:textField.text];
            [dataColor replaceObjectAtIndex:3 withObject:CellBGColorNormal];
        }
    }
    if (textField.tag == 15) {
        if (![CheckUtils checkUserNameHanzi:textField.text]) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入正确的联系人姓名"];
            [dataColor replaceObjectAtIndex:4 withObject:CellBGColorRed];
            
        }else if ([dataListAll[0] isEqualToString:textField.text]){
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"联系人名称不能与本人一致"];
            [dataColor replaceObjectAtIndex:4 withObject:CellBGColorRed];
        }else if ([dataListAll[1] isEqualToString:textField.text]){
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"两个联系人名称不能一致"];
            [dataColor replaceObjectAtIndex:4 withObject:CellBGColorRed];
        }else{
            [dataListAll replaceObjectAtIndex:4 withObject:textField.text];
            [dataColor replaceObjectAtIndex:4 withObject:CellBGColorNormal];
            
        }
    }
    if (textField.tag == 16) {
        NSString *telString = [textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        if (![CheckUtils checkTelNumber:telString] ) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入正确的联系人手机号"];
            [dataColor replaceObjectAtIndex:5 withObject:CellBGColorRed];
            
        }else if ([telString isEqualToString:[Utility sharedUtility].userInfo.userMobilePhone]){
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"联系人号码不能与本人一致"];
            [dataColor replaceObjectAtIndex:5 withObject:CellBGColorRed];
        }else if ([textField.text isEqualToString:dataListAll[2]]){
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"两个联系人号码不能一致"];
            [dataColor replaceObjectAtIndex:5 withObject:CellBGColorRed];
        }else{
            [dataListAll replaceObjectAtIndex:5 withObject:textField.text];
            [dataColor replaceObjectAtIndex:5 withObject:CellBGColorNormal];
        }
    }
    if (textField.tag < 17 && textField.tag > 10) {
        if ([self isCanSelectBtn]) {
            NSIndexPath *indexPat=[NSIndexPath indexPathForRow:textField.tag -10 inSection:0];
            NSArray *indexArray=[NSArray arrayWithObject:indexPat];
            [_tableView reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationAutomatic];
        }else{
            NSIndexPath *indexPath_1=[NSIndexPath indexPathForRow:textField.tag -10 inSection:0];
            NSArray *indexArray=[NSArray arrayWithObject:indexPath_1];
            [_tableView reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    }
}

- (BOOL)isCanSelectBtn
{
    //    && ![tel1 isEqualToString:_TelPhoneExt.mobilePhone]
    //    && ![dataListAll[0] isEqualToString:dataListAll[6]]
    NSString *tel1 = [dataListAll[2] stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *tel2 = [dataListAll[5] stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([CheckUtils checkUserName:[dataListAll objectAtIndex:0]] && [[dataListAll objectAtIndex:1] length] >=1 && [CheckUtils checkTelNumber:tel1] && [CheckUtils checkUserName:[dataListAll objectAtIndex:4]] && [[dataListAll objectAtIndex:4] length] >=1 && [CheckUtils checkTelNumber:tel2]  && ![dataListAll[1] isEqualToString:dataListAll[4]] && ![dataListAll[2] isEqualToString:dataListAll[5]]) {
        return YES;
    } else {
        return NO;
    }
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
