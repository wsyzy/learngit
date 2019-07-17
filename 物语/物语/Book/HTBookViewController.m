//
//  HTBViewController.m
//  物语
//
//  Created by QAQ on 2019/5/20.
//  Copyright © 2019 QAQ. All rights reserved.
//

#import "HTBookViewController.h"
#import "HomeViewController.h"
#import "HTEarthViewController.h"
#import "HTB-floatView.h"

#define BTN_SIZE 50     //按钮大小
#define Book_W 140   //书本宽度
#define Book_H 140   //书本高度
#define Book_origin_x 150
#define screenSize [UIScreen mainScreen].bounds.size
#define Cell @"cellIdentifier"

@interface HTBookViewController ()<UICollectionViewDelegate>

@property (nonatomic,strong)HTB_floatView *floatView;

@property (nonatomic,strong)UIButton *floatBtn;


@property (nonatomic,strong)UIButton *StoryBook1;
@property (nonatomic,strong)UIButton *StoryBook2;
@property (nonatomic,strong)UIButton *StoryBook3;

@property (nonatomic,strong)UIButton *pictureBook1;
@property (nonatomic,strong)UIButton *pictureBook2;
@property (nonatomic,strong)UIButton *pictureBook3;

@end

@implementation HTBookViewController

#pragma mark - 浮窗
- (HTB_floatView *)floatView
{
    if (!_floatView) {
        _floatView = [[HTB_floatView alloc]init];
        _floatView.delegate = self;
    }
    return _floatView;
}

#pragma  mark - 转场按钮
- (UIButton *)floatBtn     //浮窗
{
    if (!_floatBtn) {
        _floatBtn = [[UIButton alloc]initWithFrame:CGRectMake(590, 40, BTN_SIZE, BTN_SIZE)];
        [_floatBtn setImage:[UIImage imageNamed:@"universal.float.png"] forState:(UIControlStateNormal)];
        [_floatBtn addTarget:self action:@selector(floatBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _floatBtn;
}

#pragma mark - 图书
- (UIButton *)StoryBook1    //无锁
{
    if (!_StoryBook1) {
        _StoryBook1 = [[UIButton alloc]initWithFrame:CGRectMake(Book_origin_x, 50, Book_W, Book_H)];
        [_StoryBook1 setImage:[UIImage imageNamed:@"unlocked-storyBook"] forState:(UIControlStateNormal)];
        [_StoryBook1 addTarget:self action:@selector(toStory) forControlEvents:UIControlEventTouchUpInside];
    }
    return _StoryBook1;
}
- (UIButton *)StoryBook2
{
    if (!_StoryBook2) {
        _StoryBook2 = [[UIButton alloc]initWithFrame:CGRectMake(Book_origin_x + Book_W*(3/2), BTN_SIZE, Book_W, Book_H)];
        [_StoryBook2 setImage:[UIImage imageNamed:@"locked-storyBook1"] forState:(UIControlStateNormal)];
        [_StoryBook2 addTarget:self action:@selector(lockedAlert) forControlEvents:UIControlEventTouchUpInside];
    }
    return _StoryBook2;
}- (UIButton *)StoryBook3
{
    if (!_StoryBook3) {
        _StoryBook3 = [[UIButton alloc]initWithFrame:CGRectMake(Book_origin_x + Book_W*2, BTN_SIZE, Book_W, Book_H)];
        [_StoryBook3 setImage:[UIImage imageNamed:@"locked-storyBook2"] forState:(UIControlStateNormal)];
        [_StoryBook3 addTarget:self action:@selector(lockedAlert) forControlEvents:UIControlEventTouchUpInside];
    }
    return _StoryBook3;
}
- (UIButton *)pictureBook1    //无锁
{
    if (!_pictureBook1) {
        _pictureBook1 = [[UIButton alloc]initWithFrame:CGRectMake(Book_origin_x, BTN_SIZE*2 + Book_H, Book_W, Book_H)];
        [_pictureBook1 setImage:[UIImage imageNamed:@"unlocked-pictureBook"] forState:(UIControlStateNormal)];
        [_pictureBook1 addTarget:self action:@selector(toPicture) forControlEvents:UIControlEventTouchUpInside];
    }
    return _pictureBook1;
}
- (UIButton *)pictureBook2     //跳转到拍照识别
{
    if (!_pictureBook2) {
        _pictureBook2 = [[UIButton alloc]initWithFrame:CGRectMake(Book_origin_x + Book_W/(3/2), BTN_SIZE*2 + Book_H, Book_W, Book_H)];
        [_pictureBook2 setImage:[UIImage imageNamed:@"locked-pictureBook1"] forState:(UIControlStateNormal)];
        [_pictureBook2 addTarget:self action:@selector(lockedAlert) forControlEvents:UIControlEventTouchUpInside];
    }
    return _pictureBook2;
}
- (UIButton *)pictureBook3     //跳转到拍照识别
{
    if (!_pictureBook3) {
        _pictureBook3 = [[UIButton alloc]initWithFrame:CGRectMake(Book_origin_x + Book_W*2, BTN_SIZE*2 + Book_H, Book_W, Book_H)];
        [_pictureBook3 setImage:[UIImage imageNamed:@"locked-pictureBook2"] forState:(UIControlStateNormal)];
        [_pictureBook3 addTarget:self action:@selector(lockedAlert) forControlEvents:UIControlEventTouchUpInside];
    }
    return _pictureBook3;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    [bgImageView setImage:[UIImage imageNamed:@"HTBView.png"]];
    

    
    [self.view addSubview:bgImageView];
    [self.view addSubview:self.floatBtn];

    [self.view addSubview:self.StoryBook1];
    [self.view addSubview:self.StoryBook2];
    [self.view addSubview:self.StoryBook3];
    [self.view addSubview:self.pictureBook1];
    [self.view addSubview:self.pictureBook2];
    [self.view addSubview:self.pictureBook3];
    [self.view addSubview:self.floatView];
}


#pragma mark - 浮窗
-(void)floatBtnClick
{
    _floatView.frame  = self.view.bounds;
    CGRect rect = [_floatBtn convertRect:_floatBtn.frame toView:nil];
    [_floatView showFloatViewFromPoint:rect.origin];
}

#pragma mark - 图书事件
-(void)toStory
{
    NSLog(@"a story shows");
}

-(void)toPicture
{
    NSLog(@"a picture shows");
}

-(void)lockedAlert
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"该图书还没有解锁哦！" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:action];
    [self presentViewController:alertController animated:YES completion:nil];
}


#pragma mark - collectionView

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"test");
    HomeViewController *homeController = [[HomeViewController alloc]init];
    HTEarthViewController *earthController = [[HTEarthViewController alloc]init];
    switch (indexPath.item) {
        case 1:
            [self presentViewController:homeController animated:YES completion:nil];
            break;
        case 3:
            break;
            //        case 5:
            //            [cell.contentView addSubview:photoImage];
            //            break;
            //        case 8:
            //            [cell.contentView addSubview:backImage];
            //            break;
    }
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
