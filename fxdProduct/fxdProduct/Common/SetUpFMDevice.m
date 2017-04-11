//
//  SetUpFMDevice.m
//  fxdProduct
//
//  Created by dd on 2017/2/12.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "SetUpFMDevice.h"
#import "FMDeviceManager.h"

@implementation SetUpFMDevice

+ (void)configFMDevice
{
    FMDeviceManager_t *manager = [FMDeviceManager sharedManager];
    
    NSMutableDictionary *options = [NSMutableDictionary dictionary];
    
    // SDK具有防调试功能，当使用xcode运行时，请取消此行注释，开启调试模式
    // 否则使用xcode运行会闪退，(但直接在设备上点APP图标可以正常运行)
    // 上线Appstore的版本，请记得删除此行，否则将失去防调试防护功能！
    [options setValue:@"allowd" forKey:@"allowd"];  // TODO
    
    // 指定对接同盾的测试环境，正式上线时，请删除或者注释掉此行代码，切换到同盾生产环境
    [options setValue:@"sandbox" forKey:@"env"]; // TODO
    
    // 指定合作方标识
    [options setValue:@"haoliwang" forKey:@"partner"];
    
    // 使用上述参数进行SDK初始化
    manager->initWithOptions(options);
}

@end
