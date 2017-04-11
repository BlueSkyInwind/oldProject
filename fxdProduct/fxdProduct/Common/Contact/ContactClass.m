//
//  ContactClass.m
//  fxdProduct
//
//  Created by dd on 2017/2/20.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "ContactClass.h"

@implementation ZXPersonTemp


@end

@interface ContactClass()<CNContactPickerDelegate>

@end


@implementation ContactClass

- (void)showUserContact
{
    CNContactPickerViewController * con = [[CNContactPickerViewController alloc] init];
    con.delegate = self;
    [_parentVC presentViewController:con animated:YES completion:nil];
}

- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContactProperty:(CNContactProperty *)contactProperty
{
    CNContact *contact = contactProperty.contact;
    CNPhoneNumber *phoneNumber = contactProperty.value;
    NSString *fullName = [CNContactFormatter stringFromContact:contact style:CNContactFormatterStyleFullName];
    NSString *phoneNumStr = [phoneNumber.stringValue stringByReplacingOccurrencesOfString:@"-" withString:@""];
    [picker dismissViewControllerAnimated:true completion:^{
        [self.delegate GetContactName:fullName TelPhone:phoneNumStr andFlagTure:_tagFlage];
    }];
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
//        NSString *fullName = [CNContactFormatter stringFromContact:contact style:CNContactFormatterStyleFullName];
//        if (!fullName || [fullName isEqualToString:@""]) {
//            fullName = @"";
//        }
        
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
        
//        for (CNLabeledValue *labeledValue in phoneNums) {
//            // 获取电话号码的KEY
//            NSString *phoneLabel = labeledValue.label;
//            
//            // 获取电话号码
//            CNPhoneNumber *phoneNumer = labeledValue.value;
//            NSString *phoneValue = phoneNumer.stringValue;
//            
//            NSLog(@"%@ %@", phoneLabel, phoneValue);
//            ZXPersonTemp *person = [[ZXPersonTemp alloc] init];
//            person.name = [NSString stringWithFormat:@"%@%@",lastname,firstname];
//            person.phone = phoneValue;
////            [_addressBookArray addObject:person];
//        }
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
