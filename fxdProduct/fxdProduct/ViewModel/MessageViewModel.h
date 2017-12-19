//
//  MessageViewModel.h
//  fxdProduct
//
//  Created by sxp on 2017/12/6.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "FXD_ViewModelBaseClass.h"

@interface MessageViewModel : FXD_ViewModelBaseClass


/**
 站内信用户未读信息统计接口
 */
-(void)countStationLetterMsg;


/**
 站内信未读已读列表

 @param pageNum 当前页
 @param pageSize 翻页数
 */
-(void)showMsgPreviewPageNum:(NSString *)pageNum pageSize:(NSString *)pageSize;

@end
