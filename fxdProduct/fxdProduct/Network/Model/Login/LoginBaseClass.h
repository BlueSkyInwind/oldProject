//
//  LoginBaseClass.h
//
//  Created by dd  on 16/3/7
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginResult.h"
#import "LoginBaseClass.h"

@class LoginResult;

@interface LoginBaseClass : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) LoginResult *result;
@property (nonatomic, strong) NSString *flag;
@property (nonatomic, strong) NSString *msg;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end


/*
 {
 "result": {
 "creditBankName": "sasas",
 "creditCardNo": "sasa",
 "soundRecordingPath": "aaa",
 "creditBankNo": "asasa",
 "debitCardNo": "asasa",
 "debitBankName": "asasa",
 "bankNo": "asasa",
 "createDate": "2016-03-07 16:04:38",
 "updateId": 10046301,
 "lastUpdateDate": "2016-03-07 17:00:14",
 "isValid": "0",
 "id": 10046301,
 "userName": "18624381230",
 "realName": "大哥",
 "headPortraitPath": "http://192.168.15.139:8080/ImageServer/18624381230/2016-03-07/1457341214383userCardImage.png",
 "identityId": "125368093211235468",
 "address": "湖南省/湘潭市/雨湖区 政府路",
 "contactName": "我",
 "contactName2": "你",
 "contactPhone": "18625569900",
 "contactPhone2": "18800663399",
 "phontNum": "18624381230",
 "identityPositivePath": "http://192.168.15.139:8080/ImageServer/18624381230/2016-03-07/1457341193118userCardImage.png",
 "identityCounterPath": "http://192.168.15.139:8080/ImageServer/18624381230/2016-03-07/1457341205220userCardImage.png",
 "holdIdentityPhonePath": "http://192.168.15.139:8080/ImageServer/18624381230/2016-03-07/1457341214383userCardImage.png",
 "integral": 0,
 "creditLine": 0,
 "equipmentNum": "C5914A95-F93F-4A51-9E25-DD5E94CC901F",
 "platformSource": "4001",
 "lastLoginDate": "2016-03-07 00:00:00",
 "creditLev": "3061",
 "company": "政府机构",
 "lastLoginIp": "192.168.2.2",
 "uuid": "D89CA367-CD94-4A57-9015-F19FE7C39992",
 "clientId": "8cefc557e5e75f34501995d2b58131ab",
 "degree": "20",
 "unitAddress": "湖南省/湘潭市/雨湖区 政府路机构主席明石手",
 "unitTelephone": "1234567",
 "career": "生活/服务业",
 "contactRelationship": "父母",
 "contactRelationship2": "朋友",
 "registerPlatformSource": "4001"
 },
 "flag": "0000",
 "msg": ""
 }
 */