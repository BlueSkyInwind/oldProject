//
//  DataBaseManager.m
//  fxdProduct
//
//  Created by zy on 15/11/10.
//  Copyright © 2015年 dd. All rights reserved.
//

#import "DataBaseManager.h"

@implementation DataBaseManager

-(id)init
{
    if(self=[super init])
    {
        //获取沙盒
        NSArray *sandArray=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *sandString=[sandArray objectAtIndex:0];
        NSString *sqlPath=[NSString stringWithFormat:@"%@/%@",sandString,@"db.sqlite"];
        _db=[[FMDatabase alloc]initWithPath:sqlPath];
    }
    return self;
}

//获取单例对象
+(DataBaseManager *)shareManager
{
    static DataBaseManager *db=nil;
    @synchronized(self) {
        if(!db)
        {
            db=[[DataBaseManager alloc]init];
        }
    }
    return db;
}

//打开数据库
-(void)dbOpen:(NSString *)UserNum
{
    BOOL isOpen = [_db open];
    if(isOpen)
    {
         NSString *createTable=[NSString stringWithFormat:@"create table if not exists User%@ (msId integer primary key autoincrement ,titleStr varchar(256), dateStr varchar(256) ,contentStr varChar(256))",UserNum];
        //创建表
        BOOL isCreate=[_db executeUpdate:createTable];
        //如果执行失败打印错误信息
        if (!isCreate) {
            DLog(@"create = %@",_db.lastErrorMessage);
        }
    }
}

//插入
- (void)insertWithModel:(testModelFmdb *)msg :(NSString *)UserNum
{
    NSString *insertSql = [NSString stringWithFormat:@"insert into User%@(titleStr,dateStr,contentStr) values(?,?,?)",UserNum];
    
    //指向sql语句,参数不能是基础数据类型
    BOOL isInsert = [_db executeUpdate:insertSql,msg.title,msg.date,msg.content];
    if (!isInsert) {
        DLog(@"insert = %@",_db.lastErrorMessage);
    }
}

//查询
- (NSArray *)selectAllModel:(NSString *)UserNum
{
    NSString *selectSql = [NSString stringWithFormat:@"select * from User%@",UserNum];
    NSMutableArray *dataArr = [NSMutableArray array];
    FMResultSet *set = [_db executeQuery:selectSql];
    //在while循环中 set会依次代表查询结果中所有的数据
    while (set.next) {
        testModelFmdb *msg=[[testModelFmdb alloc]init];
        msg.msgId=[set stringForColumn:@"msId"];
        msg.title=[set stringForColumn:@"titleStr"];
        msg.date=[set stringForColumn:@"dateStr"];
        msg.content=[set stringForColumn:@"contentStr"];
        [dataArr addObject:msg];
    }
    return dataArr;
}

-(void)deleteWithModel:(testModelFmdb*)msg :(NSString *)UserNum
{
    NSString *deleteSQL=[NSString stringWithFormat:@"delete from User%@ where msId =%@",UserNum,msg.msgId];
    BOOL isDelete=[_db executeUpdate:deleteSQL];
    if(!isDelete)
    {
        DLog(@"delete = %@",_db.lastErrorMessage);
    }
}

- (BOOL) deleteTable:(NSString *)UserNum
{
    NSString *sqlstr = [NSString stringWithFormat:@"DROP TABLE User%@", UserNum];
    if (![_db executeUpdate:sqlstr])
    {
        DLog(@"Delete table error!");
        return NO;
    }
    return YES;
}

-(void)dbClose
{
    [_db close];
}
@end
