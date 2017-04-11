//
//  ContactClass.h
//  fxdProduct
//
//  Created by dd on 2017/2/20.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactProtocol.h"
#import <Contacts/Contacts.h>
#import <ContactsUI/ContactsUI.h>

@class ZXPersonTemp;

@interface ZXPersonTemp : NSObject
@property (nonatomic , copy) NSString *phone;
@property (nonatomic , copy) NSString *name;
@end

@interface ContactClass : UIViewController

@property (nonatomic, strong) UIViewController *parentVC;

@property (nonatomic, weak) id<ContactProtocol> delegate;

@property (nonatomic, assign) NSInteger tagFlage;

- (void)showUserContact;

- (NSArray *)getAllContact;

@end
