//
//  ContactList.h
//  fxdProduct
//
//  Created by dd on 15/11/9.
//  Copyright © 2015年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhoneContactsManager : NSObject
{
    NSMutableArray *dataSource;
    NSMutableArray *userSource;
    NSMutableArray *numarr1;
    NSMutableDictionary *dic1;
}

- (NSMutableArray *)getContactList;

@end
