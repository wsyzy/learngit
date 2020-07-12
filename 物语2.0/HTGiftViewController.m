//
//  HTGiftViewController.m
//  物语
//
//  Created by QAQ on 2020/6/25.
//  Copyright © 2020 QAQ. All rights reserved.
//

#import "HTGiftViewController.h"

@interface HTGiftViewController ()
@property(nonatomic,strong)UIButton *backBtn;
@end

@implementation HTGiftViewController

- (UIButton *)backBtn     //返回键,返回主页
{
    if (!_backBtn) {
        _backBtn = [[UIButton alloc]initWithFrame:CGRectMake(30, 30, 50, 50)];
        [_backBtn setImage:[UIImage imageNamed:@"universal.back.png"] forState:(UIControlStateNormal)];
        [_backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    [bgImageView setImage:[UIImage imageNamed:@"HTG-background.png"]];
    [self.view addSubview:bgImageView];
    [self.view addSubview:self.backBtn];
}

//返回按钮
- (void)backBtnClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
