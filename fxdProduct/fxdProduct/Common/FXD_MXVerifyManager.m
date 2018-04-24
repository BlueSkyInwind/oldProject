//
//  FXD_MXVerifyManager.m
//  fxdProduct
//
//  Created by admin on 2017/12/25.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "FXD_MXVerifyManager.h"
@interface FXD_MXVerifyManager()
@property(nonatomic,copy)MXVerifyResult mxVerifyResult;

@end
@implementation FXD_MXVerifyManager

+ (FXD_MXVerifyManager *)sharedInteraction
{
    static FXD_MXVerifyManager *sharedInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

-(void)configMoxieSDKViewcontroller:(UIViewController *)vc  mxResult:(MXVerifyResult)mxResult{
    [self configMoxieSDK:vc];
    self.mxVerifyResult = ^(NSDictionary *resultDic) {
        mxResult(resultDic);
    };
}
//网银
- (void)Internetbank{
    @try {
        [MoxieSDK shared].taskType = @"bank";
        [[MoxieSDK shared] start];
    } @catch (NSException *exception) {
        DLog(@"%@", exception);
        return;
    } @finally {
    }
}
//邮箱导入
- (void)mailImportClick{
    @try {
        [MoxieSDK shared].taskType = @"email";
        [[MoxieSDK shared] start];
    } @catch (NSException *exception) {
        DLog(@"%@", exception);
        return;
    } @finally {
    }
}
//公积金导入
- (void)accumulationFundImportClick{
    @try {
        [MoxieSDK shared].taskType = @"fund";
        [[MoxieSDK shared] start];
    } @catch (NSException *exception) {
        DLog(@"%@", exception);
        return;
    } @finally {
    }
}
//社保导入
-(void)securityImportClick{
    @try {
        [MoxieSDK shared].taskType = @"security";
        [[MoxieSDK shared] start];
    } @catch (NSException *exception) {
        DLog(@"%@", exception);
        return;
    } @finally {
    }
}
-(void)configMoxieSDK:(UIViewController *)VC{
    /***必须配置的基本参数*/
    [MoxieSDK shared].delegate = self;
    [MoxieSDK shared].userId = [FXD_Utility sharedUtility].userInfo.juid;
    [MoxieSDK shared].apiKey = theMoxieApiKey;
    [MoxieSDK shared].fromController = VC;
    [MoxieSDK shared].useNavigationPush = NO;
    [self editSDKInfo];
};

#pragma MoxieSDK Result Delegate
-(void)receiveMoxieSDKResult:(NSDictionary*)resultDictionary{
    int code = [resultDictionary[@"code"] intValue];
    NSString *taskType = resultDictionary[@"taskType"];
    NSString *taskId = resultDictionary[@"taskId"];
    NSString *message = resultDictionary[@"message"];
    NSString *account = resultDictionary[@"account"];
    BOOL loginDone = [resultDictionary[@"loginDone"] boolValue];
    NSLog(@"get import result---code:%d,taskType:%@,taskId:%@,message:%@,account:%@,loginDone:%d",code,taskType,taskId,message,account,loginDone);
    if (self.mxVerifyResult != nil) {
        self.mxVerifyResult(resultDictionary);
    }
    //【登录中】假如code是2且loginDone为false，表示正在登录中
    if(code == 2 && loginDone == false){
        DLog(@"任务正在登录中，SDK退出后不会再回调任务状态，任务最终状态会从服务端回调，建议轮询APP服务端接口查询任务/业务最新状态");
    }
    //【采集中】假如code是2且loginDone为true，已经登录成功，正在采集中
    else if(code == 2 && loginDone == true){
        DLog(@"任务已经登录成功，正在采集中，SDK退出后不会再回调任务状态，任务最终状态会从服务端回调，建议轮询APP服务端接口查询任务/业务最新状态");
    }
    //【采集成功】假如code是1则采集成功（不代表回调成功）
    else if(code == 1){
        DLog(@"任务采集成功，任务最终状态会从服务端回调，建议轮询APP服务端接口查询任务/业务最新状态");
    }
    //【未登录】假如code是-1则用户未登录
    else if(code == -1){
        DLog(@"用户未登录");
    }
    //【任务失败】该任务按失败处理，可能的code为0，-2，-3，-4
    //0 其他失败原因
    //-2平台方不可用（如中国移动维护等）
    //-3魔蝎数据服务异常
    //-4用户输入出错（密码、验证码等输错后退出）
    else{
        DLog(@"任务失败");
    }
}
-(void)editSDKInfo{
    [MoxieSDK shared].navigationController.navigationBar.translucent = YES;
    [MoxieSDK shared].backImageName = @"return";
    [MoxieSDK shared].navigationController.navigationBar.tintColor = UI_MAIN_COLOR;
    [[MoxieSDK shared].navigationController.navigationBar setBackgroundColor:[UIColor whiteColor]];
    [MoxieSDK shared].navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],NSForegroundColorAttributeName, nil];
}







@end
