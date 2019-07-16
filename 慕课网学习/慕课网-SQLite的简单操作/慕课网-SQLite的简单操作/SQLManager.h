//
//  SQLManager.h
//  慕课网-SQLite的简单操作
//
//  Created by 叶子 on 2019/7/12.
//  Copyright © 2019 叶子. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StudentModel.h"
#import <sqlite3.h>

NS_ASSUME_NONNULL_BEGIN

@interface SQLManager : NSObject{
    sqlite3 *db;
}

+(SQLManager *)shareManager;

//根据主键查询model
-(StudentModel *)searchWithID:(StudentModel *)model;

//插入对象
-(int)insert:(StudentModel *)model;

@end

NS_ASSUME_NONNULL_END
