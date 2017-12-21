//
//  FXD_AppPhoneContactStoreConfig.h
//  fxdProduct
//
//  Created by admin on 2017/12/21.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_9_0
#import <Contacts/Contacts.h>
#import <ContactsUI/ContactsUI.h>
#endif
#import <AddressBookUI/ABPeoplePickerNavigationController.h>
#import <AddressBook/ABPerson.h>
#import <AddressBookUI/ABPersonViewController.h>

typedef void(^SelectResultContactor)(NSString* fullName,NSString * phoneNum);

@interface FXD_AppPhoneContactStoreConfig : NSObject<CNContactPickerDelegate,ABPeoplePickerNavigationControllerDelegate>{
    
   
}
@property (nonatomic,copy) SelectResultContactor  selectResult;
@property(nonatomic,strong)CNContactPickerViewController * contactPickerVC;

+ (FXD_AppPhoneContactStoreConfig *)shared;

/**
 查询权限
 
 @param vc 当前视图
 */
-(void)pushContactStoreForm:(UIViewController *)vc Complitioner:(SelectResultContactor)complition;

/**
 获取所有的联系人

 @return 联系人数组
 */
- (NSArray *)getAllContact;

@end
