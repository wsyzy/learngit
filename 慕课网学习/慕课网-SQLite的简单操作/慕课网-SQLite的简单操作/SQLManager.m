//
//  SQLManager.m
//  慕课网-SQLite的简单操作
//
//  Created by 叶子 on 2019/7/12.
//  Copyright © 2019 叶子. All rights reserved.
//

#import "SQLManager.h"

@implementation SQLManager

static SQLManager *manager = nil;

#define kNameFile (@"Student.sqlite")

+(SQLManager *)shareManager{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        manager = [[self alloc]init];
    });
    return manager;
}

//获取路径
-(NSString *)applicationDocumentsDirectoryFile{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString* documentDirectory = [paths firstObject];
    NSString* filePath = [documentDirectory stringByAppendingPathComponent:kNameFile];
    return filePath;
}


-(void)creatDataBaseTableIfNeeded{
    NSString *writeTablePath = [self applicationDocumentsDirectoryFile];
    NSLog(@"数据库的地址是：%@",[writeTablePath description]);
    //打开数据库,先判断是否打开成功,注意第一个d参数为数据库所在的完整路径，第二个位要打开的对象,SQLITE_OK表示打开成功
    if(sqlite3_open([writeTablePath UTF8String], &db) != SQLITE_OK){
        //失败
        NSAssert(NO,@"数据库打开失败!");
    }else{
        //若成功,开始建表
        char *err;
        NSString *createSQL = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS STUDENTNAME(ID TEXT PRIMARY KEY,name TEXT)"];
        /*第一个参数：db对象
         第二个参数：语句
         第三和第四参数：回调函数和回调函数传递的参数
         第五个参数：一个错误信息
        */
        //sqlite3_exec功能为执行sql语句，即其第二个参数
        if (sqlite3_exec(db, [createSQL UTF8String], NULL, NULL, &err)!= SQLITE_OK) {
            //若建表失败
            NSAssert1(NO,@"建表失败! %s",err);
        }
        sqlite3_close(db);  //操作完数据库后关闭
    }
}
//查询
- (StudentModel *)searchWithID:(StudentModel *)model
{
    NSString *path = [self applicationDocumentsDirectoryFile];//获取文件路径
    //打开数据库
    if (sqlite3_open([path UTF8String], &db) != SQLITE_OK) {
        NSAssert(NO,@"打开数据库失败！");
        
    }else{//若成功
        
        NSString *qsql = @"SELECT ID,name FROM StudentName where ID = ?";
        //1.预处理
        sqlite3_stmt *statement;//语句对象
        /*
         第一个参数：数据库对象
         第二个参数：SQL语句
         第三个参数：执行语句的长度，-1指全部长度
         第四个参数：语句对象
         第五个参数：没有执行的语句部分，此处为NULL
         */
        if ( sqlite3_prepare_v2(db, [qsql UTF8String], -1, &statement, NULL) != SQLITE_OK) {
            //查询（按主键查询）
            NSString *ID = model.ID;
            /*2.绑定
             第一个参数:语句对象
             第二个参数：参数开始执行的序号
             第三个参数：要绑定的值
             */
            sqlite3_bind_text(statement, 1, [ID UTF8String], -1, NULL);
            
            //3.遍历过程
            if ( sqlite3_step(statement) == SQLITE_ROW) { //有一个返回值，SQLITE_ROW常量表示查出来了
            /*4.提取数据
              第一个参数：语句对象
              第二个参数：字段的索引
             */
                char *ID = (char *)sqlite3_column_text(statement, 0);
                //数据转换
                NSString *IDStr = [[NSString alloc]initWithUTF8String:ID];
                char *name = (char *)sqlite3_column_text(statement, 1);
                NSString *nameStr = [[NSString alloc]initWithUTF8String:name];
                StudentModel *model = [[StudentModel alloc]init];
                
                model.ID = IDStr;
                model.name = nameStr;
                return model;
            }
        }
        
//销毁前面被sqlite3_prepare创建的准备语句，每个准备语句都必须使用这个函数去销毁以防止内存泄露。
        sqlite3_finalize(statement);
        
//关闭前面使用sqlite3_open打开的数据库连接，任何与这个连接相关的准备语句必须在调用这个关闭函数之前被释放
        sqlite3_close(db);
    }
    return 0;
}

//修改
-(int)insert:(StudentModel *)model
{
    NSString *path = [self applicationDocumentsDirectoryFile];
    if(sqlite3_open([path UTF8String], &db)!=SQLITE_OK){
        
    }else{
        //创建插入语句
        NSString *sql = @"INSERT OR REPLACE INTO StudentName(ID,name)VALUES(?,?)";
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(db, [sql UTF8String], -1, &statement, NULL)!= SQLITE_OK) {
            //绑定
            sqlite3_bind_text(statement, 1, [model.ID UTF8String], -1, NULL);
            sqlite3_bind_text(statement, 1, [model.name UTF8String], -1, NULL);
            if(sqlite3_step(statement) != SQLITE_OK)
            {
                NSLog(@"插入失败");
            }
        }
        sqlite3_finalize(statement);
        sqlite3_close(db);
    }
    return 0;
}


@end
