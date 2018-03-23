//
//  HG_Manager.m
//  fxdProduct
//
//  Created by sxp on 2017/10/20.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "HG_Manager.h"
#import "ComplianceViewModel.h"
#import "P2PViewController.h"
#import "FXD_HomePageVCModules.h"
#import "ActiveModel.h"

@implementation HG_Manager

+ (HG_Manager *)sharedHGManager
{
    static HG_Manager *sharedMBPInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedMBPInstance = [[self alloc] init];
    });
    return sharedMBPInstance;
}

#pragma mark - 合规改造老用户激活

-(void)hgUserActiveJumpP2pCtrlCapitalPlatform:(NSString *)capitalPlatform retUrl:(NSString *)retUrl vc:(id)vc{
    
    UIViewController *topRootViewController;
    
    if ([vc isKindOfClass: [FXD_HomePageVCModules class]]) {
        topRootViewController = (FXD_HomePageVCModules *)vc;
    }
    if ([vc isKindOfClass: [FXD_ToWithdrawFundsViewController class]]) {
        topRootViewController = (FXD_ToWithdrawFundsViewController *)vc;
    }
//    if ([vc isKindOfClass: [LoanMoneyViewController class]]) {
//        topRootViewController = (LoanMoneyViewController *)vc;
//    }
    ComplianceViewModel *complianceVM = [[ComplianceViewModel alloc]init];
    [complianceVM setBlockWithReturnBlock:^(id returnValue) {
        BaseResultModel * baseResultM = [[BaseResultModel alloc]initWithDictionary:(NSDictionary *)returnValue error:nil];
        if ([baseResultM.errCode isEqualToString:@"0"]) {
            ActiveModel * hgUserActiveModel = [[ActiveModel alloc]initWithDictionary:(NSDictionary *)baseResultM.data error:nil];

            NSString *url = [self buildForm:hgUserActiveModel.ServiceUrl params:hgUserActiveModel.InMap];
            P2PViewController *p2pVC = [[P2PViewController alloc] init];
            p2pVC.urlStr = hgUserActiveModel.ServiceUrl;
            p2pVC.jsContent = url;
            p2pVC.retUrl = retUrl;
            [topRootViewController.navigationController pushViewController:p2pVC animated:YES];
        }else if ([baseResultM.errCode isEqualToString:@"2"]){
            
            IntermediateViewController *controller = [[IntermediateViewController alloc]init];
            controller.type = @"2";
            [topRootViewController.navigationController pushViewController:controller animated:YES];
            
        }else{
            [[MBPAlertView sharedMBPTextView]showTextOnly:topRootViewController.view message:baseResultM.friendErrMsg];
        }
    } WithFaileBlock:^{

    }];
    [complianceVM hgUserActiveCapitalPlatform:capitalPlatform retUrl:retUrl];
    
    

}

#pragma mark - 合规改造新用户开户
-(void)hgUserRegJumpP2pCtrlBankNo:(NSString *)bankNo bankReservePhone:(NSString *)bankReservePhone bankShortName:(NSString *)bankShortName cardId:(NSString *)cardId cardNo:(NSString *)cardNo retUrl:(NSString *)retUrl smsSeq:(NSString *)smsSeq userCode:(NSString *)userCode verifyCode:(NSString *)verifyCode vc:(id)vc{
    
    UIViewController *topRootViewController;
    if ([vc isKindOfClass: [OpenAccountViewController class]]) {
        topRootViewController = (OpenAccountViewController *)vc;
    }
    ComplianceViewModel *complianceVM = [[ComplianceViewModel alloc]init];
    [complianceVM setBlockWithReturnBlock:^(id returnValue) {
        BaseResultModel * baseResultM = [[BaseResultModel alloc]initWithDictionary:(NSDictionary *)returnValue error:nil];
        if ([baseResultM.errCode isEqualToString:@"0"]) {
            SubmitInfoModel * hgUserRegModel = [[SubmitInfoModel alloc]initWithDictionary:(NSDictionary *)baseResultM.data error:nil];
            NSString *url = [self buildForm:hgUserRegModel.ServiceUrl params:hgUserRegModel.InMap];
            P2PViewController *p2pVC = [[P2PViewController alloc] init];
            p2pVC.jsContent = url;
            p2pVC.urlStr = hgUserRegModel.ServiceUrl;
            p2pVC.retUrl = retUrl;
            
            [topRootViewController.navigationController pushViewController:p2pVC animated:YES];
        }else if ([baseResultM.errCode isEqualToString:@"2"]){
            
            IntermediateViewController *controller = [[IntermediateViewController alloc]init];
            controller.type = @"2";
            [topRootViewController.navigationController pushViewController:controller animated:YES];
            
        }else{
            [[MBPAlertView sharedMBPTextView]showTextOnly:topRootViewController.view message:baseResultM.friendErrMsg];
        }
        
    } WithFaileBlock:^{
        
    }];
    [complianceVM hgSubmitAccountInfoBankNo:bankNo bankReservePhone:bankReservePhone bankShortName:bankShortName cardId:cardId cardNo:cardNo retUrl:retUrl smsSeq:smsSeq userCode:userCode verifyCode:verifyCode];
    
}

-(void)hgChangeBankCardBankNo:(NSString *)bankNo bankReservePhone:(NSString *)bankReservePhone bankShortName:(NSString *)bankShortName cardNo:(NSString *)cardNo retUrl:(NSString *)retUrl orgSmsCode:(NSString *)orgSmsCode orgSmsSeq:(NSString *)orgSmsSeq smsSeq:(NSString *)smsSeq userCode:(NSString *)userCode verifyCode:(NSString *)verifyCode vc:(id)vc{
    
    UIViewController *topRootViewController;
    if ([vc isKindOfClass: [OpenAccountViewController class]]) {
        topRootViewController = (OpenAccountViewController *)vc;
    }
    ComplianceViewModel *complianceVM = [[ComplianceViewModel alloc]init];
    [complianceVM setBlockWithReturnBlock:^(id returnValue) {
        BaseResultModel * baseResultM = [[BaseResultModel alloc]initWithDictionary:(NSDictionary *)returnValue error:nil];
        if ([baseResultM.errCode isEqualToString:@"0"]) {
            
            for (UIViewController* vc1 in topRootViewController.rt_navigationController.rt_viewControllers) {
                if ([vc1 isKindOfClass:[FXD_ToWithdrawFundsViewController class]]) {
                    FXD_ToWithdrawFundsViewController *controller = (FXD_ToWithdrawFundsViewController *)vc1;
                    [topRootViewController.navigationController popToViewController:controller animated:YES];
                }
            }
        }else{
            
            [[MBPAlertView sharedMBPTextView]showTextOnly:topRootViewController.view message:baseResultM.friendErrMsg];
            [topRootViewController.navigationController popViewControllerAnimated:YES];
        }
        
    } WithFaileBlock:^{
        
    }];
    [complianceVM hgChangeBankCardBankNo:bankNo bankReservePhone:bankReservePhone bankShortName:bankShortName cardNo:cardNo retUrl:retUrl orgSmsCode:orgSmsCode orgSmsSeq:orgSmsSeq smsSeq:smsSeq userCode:userCode verifyCode:verifyCode];
}


-(void)hgGetProductNewProtocolApplicationId:(NSString *)applicationId inverBorrowId:(NSString *)inverBorrowId periods:(NSString *)periods productId:(NSString *)productId productType:(NSString *)productType protocolType:(NSString *)protocolType stagingType:(NSString *)stagingType vc:(id)vc{
    
    ComplianceViewModel *complianceVM = [[ComplianceViewModel alloc]init];
    [complianceVM setBlockWithReturnBlock:^(id returnValue) {
        
        UIViewController *topRootViewController;
        if ([vc isKindOfClass: [OpenAccountViewController class]]) {
            topRootViewController = (OpenAccountViewController *)vc;
        }
        
        BaseResultModel * baseResultM = [[BaseResultModel alloc]initWithDictionary:(NSDictionary *)returnValue error:nil];
        if ([baseResultM.errCode isEqualToString:@"0"]) {
            
        }else{
            
            [[MBPAlertView sharedMBPTextView]showTextOnly:topRootViewController.view message:baseResultM.friendErrMsg];
            
        }
    } WithFaileBlock:^{
        
    }];
    [complianceVM hgGetProductNewProtocolApplicationId:applicationId inverBorrowId:inverBorrowId periods:periods productId:productId productType:productType protocolType:protocolType stagingType:stagingType];
    
}


-(NSString *)buildForm:(NSString *)path params:(NSDictionary *)params{
    
    NSMutableString * metaStr = [[NSMutableString alloc]initWithString:@"<form name=\"kun_form\" method=\"post\" action=\""];
    [metaStr appendString:path];
    [metaStr appendString:@"\">\n"];
    [metaStr appendString:[self buildHiddenFields:params]];
    [metaStr appendString:@"<input type=\"submit\" value=\"submit\" style=\"display:none\" >\n"];
    [metaStr appendString:@"</form>\n"];
    [metaStr appendString:@"<script>document.forms[0].submit();</script>"];
    return metaStr;
}

-(NSString *)buildHiddenFields:(NSDictionary *)dic{
    if (dic == nil || dic.allKeys.count == 0) {
        return @"";
    }

    NSMutableString * metaStr = [[NSMutableString alloc]initWithString:@""];
    NSArray * array = dic.allKeys;
    for (NSString * key  in array) {
        NSString * value = dic[key];
        if (key == nil || value == nil) {
            continue;
        }
        [metaStr appendString:[self buildHiddenField:key value:value]];
    }
    return metaStr;
}

-(NSString *)buildHiddenField:(NSString *)key value:(NSString *)value{
    
    NSMutableString * metaStr = [[NSMutableString alloc]initWithString:@"<input type=\"hidden\" name=\""];
    [metaStr appendString:key];
    [metaStr appendString:@"\" value=\""];
    NSMutableString * str = [[NSMutableString alloc]initWithString:value];
    [str stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"];
    [metaStr appendString:str];
    [metaStr appendString:@"\">\n"];
    return [metaStr copy];
}




@end
