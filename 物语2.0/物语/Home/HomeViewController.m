//
//  HomeViewController.m
//  物语
//
//  Created by QAQ on 2019/5/19.
//  Copyright © 2019 QAQ. All rights reserved.
//

//小窝--主界面
#import "HomeViewController.h"
#import "HTEarthViewController.h"
#import "HTTViewController.h"
#import "HTBookViewController.h"
#import "HTGiftViewController.h"

@interface HomeViewController ()

@property (nonatomic,strong)UIImageView *petImageView;
@property (nonatomic,strong)UIImageView *tableImageView;
@property (nonatomic,strong)UIButton *earthBtn;
@property (nonatomic,strong)UIButton *tvBtn;
@property (nonatomic,strong)UIButton *bookBtn;
@property (nonatomic,strong)UIButton *giftBtn;


@end

@implementation HomeViewController

#pragma mark - 懒加载UI
- (UIImageView *)petImageView       //宠物图片,enable
{
    if (!_petImageView) {
        _petImageView = [[UIImageView alloc]initWithFrame:CGRectMake(500, 260, 100, 80)];
        [_petImageView setImage:[UIImage imageNamed:@"home-pet.png"]];
    }
    return _petImageView;
}

- (UIImageView *)tableImageView     //书桌图片,enable
{
    if (!_tableImageView) {
        _tableImageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, 160, 200, 150)];
        [_tableImageView setImage:[UIImage imageNamed:@"home-table.png"]];
    }
    return _tableImageView;
}

- (UIButton *)bookBtn     //图书,button
{
    if (!_bookBtn) {
        _bookBtn = [[UIButton alloc]initWithFrame:CGRectMake(60, 80, 150, 80)];
        [_bookBtn setImage:[UIImage imageNamed:@"home-book.png"] forState:(UIControlStateNormal)];
        [_bookBtn addTarget:self action:@selector(bookBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bookBtn;
}

- (UIButton *)earthBtn      //地球,button
{
    if (!_earthBtn) {
        _earthBtn = [[UIButton alloc]initWithFrame:CGRectMake(250, 185, 100, 120)];
        [_earthBtn setImage:[UIImage imageNamed:@"home-earth.png"] forState:(UIControlStateNormal)];
        [_earthBtn addTarget:self action:@selector(earthBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _earthBtn;
}

- (UIButton *)tvBtn     //电视,button
{
    if (!_tvBtn) {
        _tvBtn = [[UIButton alloc]initWithFrame:CGRectMake(480, 20, 150, 150)];
        [_tvBtn setImage:[UIImage imageNamed:@"home-tv.png-1"] forState:(UIControlStateNormal)];
        [_tvBtn addTarget:self action:@selector(tvBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _tvBtn;
}

- (UIButton *)giftBtn     //礼物
{
    if (!_giftBtn) {
        _giftBtn = [[UIButton alloc]initWithFrame:CGRectMake(250, 230, 100, 100)];
        [_giftBtn setImage:[UIImage imageNamed:@"home - gift.png"] forState:(UIControlStateNormal)];
        [_giftBtn addTarget:self action:@selector(giftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _giftBtn;
}


//父视图上添加视图
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //小窝背景图
    UIImageView *homeImage = [[UIImageView alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    [homeImage setImage:[UIImage imageNamed:@"homeView.png"]];
    
    NSLog(@"width: %f, height: %f",[[UIScreen mainScreen]bounds].size.width,[[UIScreen mainScreen]bounds].size.height);
    
    [self.view addSubview:homeImage];
    [self.view addSubview:self.petImageView];
    [self.view addSubview:self.tableImageView];
    [self.view addSubview:self.earthBtn];
    [self.view addSubview:self.tvBtn];
    [self.view addSubview:self.bookBtn];
    [self.view addSubview:self.giftBtn];
    
}


//pragma mark - button click action
- (void)earthBtnClick       //地球跳转
{
    HTEarthViewController *earthViewController = [[HTEarthViewController alloc]init];
    [self presentViewController:earthViewController animated:YES completion:nil];
}
- (void)tvBtnClick       //电视跳转
{
    HTTViewController *tvViewController = [[HTTViewController alloc]init];
    [self presentViewController:tvViewController animated:YES completion:nil];
}
- (void)bookBtnClick       //图书跳转
{
    HTBookViewController *bookViewController = [[HTBookViewController alloc]init];
    [self presentViewController:bookViewController animated:YES completion:nil];
}
- (void)giftBtnClick       //图书跳转
{
        HTGiftViewController *giftViewController = [[HTGiftViewController alloc]init];
        [self presentViewController:giftViewController animated:YES completion:nil];
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
