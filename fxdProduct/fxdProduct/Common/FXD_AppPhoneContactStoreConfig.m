//
//  FXD_AppPhoneContactStoreConfig.m
//  fxdProduct
//
//  Created by admin on 2017/12/21.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "FXD_AppPhoneContactStoreConfig.h"

@implementation FXD_AppPhoneContactStoreConfig

+ (FXD_AppPhoneContactStoreConfig *)shared
{
    static dispatch_once_t predicate;
    static FXD_AppPhoneContactStoreConfig *_storeConfig = nil;
    dispatch_once(&predicate, ^{
        _storeConfig = [[FXD_AppPhoneContactStoreConfig alloc] init];
    });
    return _storeConfig;
}

/**
 查询权限

 @param vc 当前视图
 */
-(void)pushContactStoreForm:(UIViewController *)vc Complitioner:(SelectResultContactor)complition{

    if (kiOS9Later) {
        CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
        switch (status) {
            case CNAuthorizationStatusAuthorized: {
                DLog(@"Authorized:");
                [self newGoUserContactList:vc];
            }
                break;
            case CNAuthorizationStatusDenied:{
                DLog(@"Denied");
                [self popuserAuthAlert];
            }
                break;
            case CNAuthorizationStatusRestricted:{ DLog(@"Restricted"); } break;
            case CNAuthorizationStatusNotDetermined:{
                DLog(@"NotDetermined");
                [self requestUserAuth];
            }
                break;
        }
    } else {
        ABAuthorizationStatus ABstatus = ABAddressBookGetAuthorizationStatus();
        switch (ABstatus) {
            case kABAuthorizationStatusAuthorized: {
                DLog(@"Authorized");
                [self oldGoUserContactList:vc];
            }
                break;
            case kABAuthorizationStatusDenied: {
                DLog(@"Denied'");
                [self popuserAuthAlert];
            }
                break;
            case kABAuthorizationStatusNotDetermined: {
                DLog(@"not Determined");
                [self requestUserAuth];
            }
                break;
            case kABAuthorizationStatusRestricted: DLog(@"Restricted"); break; default: break;
        }
    }
    self.selectResult = ^(NSString *fullName, NSString *phoneNum) {
        complition(fullName,phoneNum);
    };
}

-(void)oldGoUserContactList:(UIViewController *)vc{
    ABPeoplePickerNavigationController *nav = [[ABPeoplePickerNavigationController alloc] init];
    nav.peoplePickerDelegate = self;
    nav.predicateForSelectionOfPerson = [NSPredicate predicateWithValue:true];
    [vc presentViewController:nav animated:YES completion:nil];
}

-(void)newGoUserContactList:(UIViewController *)vc{
    _contactPickerVC = [[CNContactPickerViewController alloc] init];
    _contactPickerVC.delegate = self;
    _contactPickerVC.predicateForSelectionOfProperty =  [NSPredicate predicateWithValue:true];
    [vc presentViewController:_contactPickerVC animated:true completion:nil];
}

/**
 请求授权
 */
-(void)requestUserAuth{
    if (kiOS9Later) {
        ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
            if (!granted){
                DLog(@"Authorized");
                CFRelease(addressBook);
                [self popuserAuthAlert];
            }
        });
    }else{
        CNContactStore *contactStore = [[CNContactStore alloc] init];
        [contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (!granted) {
                DLog(@"Authorized");
                [self popuserAuthAlert];
            }
        }];
    }
}

-(void)popuserAuthAlert{
    [[FXD_AlertViewCust sharedHHAlertView] showFXDAlertViewTitle:@"通讯录授权" content:obtainUserContactMarkeords attributeDic:nil TextAlignment:NSTextAlignmentLeft cancelTitle:@"取消" sureTitle:@"去设置" compleBlock:^(NSInteger index) {
        if (index == 1) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }
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
        if (self.selectResult) {
            self.selectResult(fullName,phoneNumStr);
        }
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
            if (self.selectResult) {
                self.selectResult(fullName,phoneNO);
            }
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

- (NSArray *)getAllContact
{
    // 创建通信录对象
    CNContactStore *contactStore = [[CNContactStore alloc] init];
    
    // 创建获取通信录的请求对象
    // 拿到所有打算获取的属性对应的key
    NSArray *keys = @[CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey];
    
    // 创建CNContactFetchRequest对象
    CNContactFetchRequest *request = [[CNContactFetchRequest alloc] initWithKeysToFetch:keys];
    
    NSMutableArray *contactArr = [NSMutableArray array];
    // 遍历所有的联系人
    [contactStore enumerateContactsWithFetchRequest:request error:nil usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
        // 获取联系人的姓名
        NSString *lastname = contact.familyName;
        NSString *firstname = contact.givenName;
        DLog(@"%@ %@", lastname, firstname);
        lastname = lastname?lastname:@"";
        firstname = firstname?firstname:@"";
        NSString *fullName = [NSString stringWithFormat:@"%@%@",firstname,lastname];
        
        // 获取联系人的电话号码
        NSArray *phoneNums = contact.phoneNumbers;
        CNLabeledValue *labeledValue = phoneNums.lastObject;
        CNPhoneNumber *phoneNumber = labeledValue.value;
        NSString *phoneValue = phoneNumber.stringValue;
        phoneValue = phoneValue == nil?@"":phoneValue;
        if (phoneValue && ![phoneValue isEqual:@""]) {
            phoneValue = [phoneValue stringByReplacingOccurrencesOfString:@"-" withString:@""];
            if ([phoneValue hasPrefix:@"+"]) {
                phoneValue = [phoneValue substringFromIndex:3];
            }
        }
        
        NSDictionary *dic = @{@"detail_name_":fullName,
                              @"telphone_no_":phoneValue};
        [contactArr addObject:dic];
        
    }];
    
    NSMutableArray *subArr = [NSMutableArray array];
    if (contactArr.count <= 15) {
        return contactArr.copy;
    } else {
        for (int i = 0; i < 15; i++) {
            int index = arc4random()%contactArr.count;
            [subArr addObject:contactArr[index]];
        }
        return subArr;
    }
}


@end
