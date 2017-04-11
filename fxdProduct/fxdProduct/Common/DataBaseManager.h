//
//  DataBaseManager.h
//  fxdProduct
//
//  Created by zy on 15/11/10.
//  Copyright © 2015年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "testModelFmdb.h"

@interface DataBaseManager : NSObject
{
    FMDatabase *_db;
}
+(DataBaseManager *)shareManager;
//插入
- (void)insertWithModel:(testModelFmdb *)msg :(NSString *)UserNum;
//查询
- (NSArray *)selectAllModel:(NSString *)UserNum;
//删除
-(void)deleteWithModel:(testModelFmdb*)msg :(NSString *)UserNum;
//删除表
- (BOOL) deleteTable:(NSString *)UserNum;
//关闭
-(void)dbClose;
//开启
-(void)dbOpen:(NSString *)UserNum;
@end
