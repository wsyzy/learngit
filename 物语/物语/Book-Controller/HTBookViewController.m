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

@interface HTBookViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong)UIButton *floatBtn;
@property (nonatomic,strong)UIButton *toHomeBtn;
@property (nonatomic,strong)UIButton *toEarthBtn;
@property (nonatomic,strong)UIButton *toPhotoBtn;

@end

@implementation HTBookViewController

- (UIButton *)floatBtn     //浮窗
{
    if (!_floatBtn) {
        _floatBtn = [[UIButton alloc]initWithFrame:CGRectMake(610, 20, 40, 40)];
        [_floatBtn setImage:[UIImage imageNamed:@"universal.float.png"] forState:(UIControlStateNormal)];
        [_floatBtn addTarget:self action:@selector(floatBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _floatBtn;
}

- (UIButton *)toHomeBtn     //跳转回小窝
{
    if (!_toHomeBtn) {
        _toHomeBtn = [[UIButton alloc]initWithFrame:CGRectMake(610, 70, 40, 40)];
        [_toHomeBtn setImage:[UIImage imageNamed:@"universal.bookToHome.png"] forState:(UIControlStateNormal)];
        [_toHomeBtn addTarget:self action:@selector(toHomeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _toHomeBtn;
}
- (UIButton *)toEarthBtn     //跳转回地球
{
    if (!_toEarthBtn) {
        _toEarthBtn = [[UIButton alloc]initWithFrame:CGRectMake(610, 120, 40, 40)];
        [_toEarthBtn setImage:[UIImage imageNamed:@"universal.backToEarth.png"] forState:(UIControlStateNormal)];
        [_toEarthBtn addTarget:self action:@selector(toEarthBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _toEarthBtn;
}
- (UIButton *)toPhotoBtn     //跳转到拍照识别
{
    if (!_toPhotoBtn) {
        _toPhotoBtn = [[UIButton alloc]initWithFrame:CGRectMake(610, 170, 40, 40)];
        [_toPhotoBtn setImage:[UIImage imageNamed:@"universal.photo.png"] forState:(UIControlStateNormal)];
//        [_toPhotoBtn addTarget:self action:@selector(toPhotoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _toPhotoBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    [bgImageView setImage:[UIImage imageNamed:@"HTBView.png"]];
//    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
//    flowLayout.minimumInteritemSpacing = 70;
//    flowLayout.minimumLineSpacing = 100;
//    flowLayout.itemSize = CGSizeMake(130, 100);
//
//    UICollectionView *bookCollectionViewController = [[UICollectionView alloc]initWithFrame:CGRectMake(200, 50, 500, 310) collectionViewLayout:flowLayout];
//    bookCollectionViewController.delegate = self;
//    bookCollectionViewController.dataSource = self;
//
//    [bookCollectionViewController registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"bookCollectionViewCell"];
    
    [self.view addSubview:bgImageView];
    [self.view addSubview:self.floatBtn];
    [self.view addSubview:self.toHomeBtn];
    [self.view addSubview:self.toEarthBtn];
    [self.view addSubview:self.toPhotoBtn];
//    [self.view addSubview:bookCollectionViewController];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return  20;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"bookCollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
    
}

#pragma mark - 浮窗
-(void)floatBtnClick
{
    HTB_floatView *floatView = [[HTB_floatView alloc]initWithFrame:self.view.bounds];
    CGRect rect = [_floatBtn convertRect:_floatBtn.frame toView:nil];
    [floatView showFloatViewFromPoint:rect.origin];
}

#pragma mark - 转场
- (void)toHomeBtnClick
{
    HomeViewController *homeViewController = [[HomeViewController alloc]init];
    [self presentViewController:homeViewController animated:YES completion:nil];
}

- (void)toEarthBtnClick
{
    HTEarthViewController *earthViewController = [[HTEarthViewController alloc]init];
    [self presentViewController:earthViewController animated:YES completion:nil];
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
