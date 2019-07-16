//
//  DetailViewController.m
//  慕课网-SQLite的简单操作
//
//  Created by 叶子 on 2019/7/12.
//  Copyright © 2019 叶子. All rights reserved.
//

#import "AddViewController.h"
#import "StudentModel.h"
#import "SQLManager.h"

@interface AddViewController ()

@end

@implementation AddViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if (segue.identifier == @"addUser") {
//写入数据库
        
        //通过model传值
        StudentModel *model = [[StudentModel alloc]init];
        model.ID = self.IDField.text;
        model.name = self.NameField.text;
        
        [[SQLManager shareManager]insert:model];
    }
}

@end
