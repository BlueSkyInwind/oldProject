//
//  ContactList.m
//  fxdProduct
//
//  Created by dd on 15/11/9.
//  Copyright © 2015年 dd. All rights reserved.
//

#import "PhoneContactsManager.h"
#import "Model.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@implementation PhoneContactsManager
{
    NSString *name;
    NSString *tel;
    NSMutableArray *contactArr;
}

- (NSMutableArray *)getContactList
{
    [self address];
    contactArr = [[NSMutableArray alloc]init];
    userSource = [[NSMutableArray alloc] init];
    for (char i = 'A'; i<='Z'; i++)
    {
        NSMutableArray *numarr = [[NSMutableArray alloc] init];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        for (int j=0; j<dataSource.count; j++)
        {
            Model *model = [dataSource objectAtIndex:j];
            //获取姓名首位
            NSString *string = [model.name substringWithRange:NSMakeRange(0, 1)];
            //将姓名首位转换成NSData类型
            NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
            //data的长度大于等于3说明姓名首位是汉字
            if (data.length >=3)
            {
                //将汉字首字母拿出
                char a = pinyinFirstLetter([model.name characterAtIndex:0]);
                
                //将小写字母转成大写字母
                char b = a-32;
                if (b == i)
                {
                    NSMutableArray *array = [[NSMutableArray alloc] init];
                    [array addObject:model.name];
                    if (model.phoneList != nil)
                    {
                        [array addObject:model.phoneList];
                    }
                    
                    [numarr addObject:array];
                    [dic setObject:numarr forKey:[NSNumber numberWithChar:i]];
                }
                
            }
            else
            {
                //data的长度等于1说明姓名首位是字母或者数字
                if (data.length == 1)
                {
                    //判断姓名首位是否位小写字母
                    NSString * regex = @"^[a-z]$";
                    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
                    BOOL isMatch = [pred evaluateWithObject:string];
                    if (isMatch == YES)
                    {
                        //NSLog(@"这是小写字母");
                        
                        //把大写字母转换成小写字母
                        char j = i+32;
                        //数据封装成NSNumber类型
                        NSNumber *num = [NSNumber numberWithChar:j];
                        //给a开空间，并且强转成char类型
                        char *a = (char *)malloc(2);
                        //将num里面的数据取出放进a里面
                        sprintf(a, "%c", [num charValue]);
                        //把c的字符串转换成oc字符串类型
                        NSString *str = [[NSString alloc]initWithUTF8String:a];
                        if ([string isEqualToString:str])
                        {
                            NSMutableArray *array = [[NSMutableArray alloc] init];
                            [array addObject:model.name];
                            if (model.phoneList != nil)
                            {
                                [array addObject:model.phoneList];
                            }
                            
                            [numarr addObject:array];
                            [dic setObject:numarr forKey:[NSNumber numberWithChar:i]];
                        }
                        
                    }
                    else
                    {
                        //判断姓名首位是否为大写字母
                        NSString * regexA = @"^[A-Z]$";
                        NSPredicate *predA = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexA];
                        BOOL isMatchA = [predA evaluateWithObject:string];
                        if (isMatchA == YES)
                        {
                            //NSLog(@"这是大写字母");
                            //
                            NSNumber *num = [NSNumber numberWithChar:i];
                            //给a开空间，并且强转成char类型
                            char *a = (char *)malloc(2);
                            //将num里面的数据取出放进a里面
                            sprintf(a, "%c", [num charValue]);
                            //把c的字符串转换成oc字符串类型
                            NSString *str = [[NSString alloc]initWithUTF8String:a];
                            if ([string isEqualToString:str])
                            {
                                
                                NSMutableArray *array = [[NSMutableArray alloc] init];
                                [array addObject:model.name];
                                if (model.phoneList != nil)
                                {
                                    [array addObject:model.phoneList];
                                }
                                
                                [numarr addObject:array];
                                [dic setObject:numarr forKey:[NSNumber numberWithChar:i]];
                            }
                        }
                    }
                }
            }
        }
        if (dic.count != 0)
        {
            [userSource addObject:dic];
        }
    }
    
    char n = '#';
    int cont = 0;
    for (int j=0; j<dataSource.count; j++)
    {
        Model *model = [dataSource objectAtIndex:j];
        //获取姓名的首位
        NSString *string = [model.name substringWithRange:NSMakeRange(0, 1)];
        //将姓名首位转化成NSData类型
        NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
        //判断data的长度是否小于3
        if (data.length < 3)
        {
            if (cont == 0)
            {
                dic1 = [[NSMutableDictionary alloc] init];
                numarr1 = [[NSMutableArray alloc] init];
                cont++;
            }
            if (data.length == 1)
            {
                //判断首位是否为数字
                NSString * regexs = @"^[0-9]$";
                NSPredicate *preds = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexs];
                BOOL isMatch = [preds evaluateWithObject:string];
                if (isMatch == YES)
                {
                    //如果姓名为数字
                    NSMutableArray *array = [[NSMutableArray alloc] init];
                    [array addObject:model.name];
                    if (model.phoneList != nil)
                    {
                        [array addObject:model.phoneList];
                    }
                    
                    [numarr1 addObject:array];
                    [dic1 setObject:numarr1 forKey:[NSNumber numberWithChar:n]];
                }
            }
            else
            {
                //如果姓名为空
                NSMutableArray *array = [[NSMutableArray alloc] init];
                model.name = @"无";
                [array addObject:model.name];
                if (model.phoneList != nil)
                {
                    [array addObject:model.phoneList];
                    [numarr1 addObject:array];
                    [dic1 setObject:numarr1 forKey:[NSNumber numberWithChar:n]];
                }
            }
        }
    }
    
    if (dic1.count != 0)
    {
        [userSource addObject:dic1];
    }
    
    
    for (NSDictionary *dic in userSource) {
        NSArray *arr = [[dic allValues] lastObject];
        for (NSArray *array in arr) {
            if (array.count != 1)
            {
                if ([[array objectAtIndex:0] isEqualToString:@"无"]) {
                    tel = [array objectAtIndex:1];
                }
                else
                {
                    name = [array objectAtIndex:0];
                    tel = [array objectAtIndex:1];
                }
            }
            else
            {
                name = [array lastObject];
            }
            NSDictionary *dic = @{@"detail_name_":name,
                                  @"telphone_no_":tel};
            [contactArr addObject:dic];
        }
    }
    
    NSArray *arr = [contactArr copy];
    NSMutableArray *conArr = [NSMutableArray array];
    if (arr.count <= 15) {
        for (NSInteger i = 0; i < arr.count; i++) {
            [conArr addObject:[arr objectAtIndex:i]];
        }
    } else {
        for (NSInteger i = 0; i < 15; i++) {
            int index = arc4random()%arr.count;
            [conArr addObject:[arr objectAtIndex:index]];
        }
    }
    
    
    return conArr;
}

#pragma mark - 获取通讯录里联系人姓名和手机号
- (void)address
{
    dataSource = [[NSMutableArray alloc] init];
    
    //    NSMutableArray *contactsdata= [[NSMutableArray alloc] init];
    //这个变量用于记录授权是否成功，即用户是否允许我们访问通讯录
    int __block tip=0;
    //新建一个通讯录类
    ABAddressBookRef addressBooks = nil;
    
    //判断是否在ios6.0版本以上
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0){
        addressBooks =  ABAddressBookCreateWithOptions(NULL, NULL);
        //获取通讯录权限
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        
        ABAddressBookRequestAccessWithCompletion(addressBooks, ^(bool granted, CFErrorRef error){
            //greanted为YES是表示用户允许，否则为不允许
            if (!granted) {
                tip = 1;
            }
            dispatch_semaphore_signal(sema);});
        
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    }else{
        CFErrorRef* error=nil;
        addressBooks = ABAddressBookCreateWithOptions(NULL, error);
    }
    if (tip) {
        //做一个友好的提示
        UIAlertView * alart = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"为了您的申请通过率更高请您设置允许APP访问您的通讯录   设置>通用>隐私" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alart show];
        return;
    }
    
    //获取通讯录中的所有人
    CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople(addressBooks);
    //通讯录中人数
    CFIndex nPeople = ABAddressBookGetPersonCount(addressBooks);
    
    //循环，获取每个人的个人信息
    for (NSInteger i = 0; i < nPeople; i++)
    {
        //新建一个addressBook model类
        Model *addressBook = [[Model alloc] init];
        //获取个人
        ABRecordRef person = CFArrayGetValueAtIndex(allPeople, i);
        //获取个人名字
        CFTypeRef abName = ABRecordCopyValue(person, kABPersonFirstNameProperty);
        CFTypeRef abLastName = ABRecordCopyValue(person, kABPersonLastNameProperty);
        CFStringRef abFullName = ABRecordCopyCompositeName(person);
        NSString *nameString = (__bridge NSString *)abName;
        NSString *lastNameString = (__bridge NSString *)abLastName;
        
        if ((__bridge id)abFullName != nil) {
            nameString = (__bridge NSString *)abFullName;
        }else {
            if ((__bridge id)abLastName != nil){
                nameString = [NSString stringWithFormat:@"%@ %@", nameString, lastNameString];
            }
        }
        addressBook.name = nameString;
        
        ABPropertyID multiProperties[] = {
            kABPersonPhoneProperty,
            kABPersonEmailProperty
        };
        NSInteger multiPropertiesTotal = sizeof(multiProperties) / sizeof(ABPropertyID);
        for (NSInteger j = 0; j < multiPropertiesTotal; j++) {
            ABPropertyID property = multiProperties[j];
            ABMultiValueRef valuesRef = ABRecordCopyValue(person, property);
            NSInteger valuesCount = 0;
            if (valuesRef != nil) valuesCount = ABMultiValueGetCount(valuesRef);
            
            if (valuesCount == 0) {
                CFRelease(valuesRef);
                continue;
            }
            //获取电话号码和email
            for (NSInteger k = 0; k < valuesCount; k++) {
                CFTypeRef value = ABMultiValueCopyValueAtIndex(valuesRef, k);
                switch (j) {
                    case 0: {// Phone number
                        addressBook.phoneList = (__bridge NSString*)value;
//                        NSLog(@"%@",addressBook.phoneList);
                        break;
                    }
                        //                    case 1: {// Email
                        //                        addressBook.email = (__bridge NSString*)value;
                        //                        break;
                        //                    }
                }
                CFRelease(value);
            }
            CFRelease(valuesRef);
        }
        //将个人信息添加到数组中，循环完成后addressBookTemp中包含所有联系人的信息
        [dataSource addObject:addressBook];
        
        if (abName) CFRelease(abName);
        if (abLastName) CFRelease(abLastName);
        if (abFullName) CFRelease(abFullName);
    }
    
}


@end
