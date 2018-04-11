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

/**
 站内信删除、清空
 
 @param delType 类型：1：删除，2：清空
 @param operUserMassgeId 站内信ID 删除时必要，清空时非必要
 */
-(void)delMsgDelType:(NSString *)delType operUserMassgeId:(NSString *)operUserMassgeId;

@end
