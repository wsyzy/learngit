//
//  HTEarthViewController.m
//  物语
//
//  Created by QAQ on 2019/5/19.
//  Copyright © 2019 QAQ. All rights reserved.
//

#import "HTEarthViewController.h"
#import "HomeViewController.h"
#import "HTBookViewController.h"
#import "QueationViewController.h"
#import "VideoPickerViewController.h"

#define BTN_SIZE 70
@interface HTEarthViewController ()

@property (nonatomic,strong)UIImageView *petImageView;
@property (nonatomic,strong)UIImageView *earthImage;
@property (nonatomic,strong)UIButton *toHomeBtn;
@property (nonatomic,strong)UIButton *toBookBtn;

@end

@implementation HTEarthViewController

- (UIImageView *)petImageView
{
    
    if (!_petImageView) {
        _petImageView = [[UIImageView alloc]initWithFrame:CGRectMake(450, 220, 200, 200)];
        [_petImageView setImage:[UIImage imageNamed:@"HTE - pet.png"]];
        
    }
    return _petImageView;
}
- (UIImageView *)earthImage     //“3D”地球
{
    if (!_earthImage) {
        _earthImage = [[UIImageView alloc]initWithFrame:CGRectMake(50, 20, 350, 350)];
        [_earthImage setImage:[UIImage imageNamed:@"HTE - earth.png"]];
        _earthImage.userInteractionEnabled = YES;
        
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(200, 200, 40, 40)];
//        CGRect rect = [btn convertRect:btn.frame toView:_earthImage];
//        btn.frame = rect;
        [btn addTarget:self action:@selector(questionClick) forControlEvents:UIControlEventTouchUpInside];
        btn.backgroundColor = [UIColor blackColor];
        [_earthImage addSubview:btn];
    }
    return _earthImage;
}

- (UIButton *)toBookBtn     //跳转到故事书
{
    if (!_toBookBtn) {
        _toBookBtn = [[UIButton alloc]initWithFrame:CGRectMake(400, 40, BTN_SIZE, BTN_SIZE)];
        [_toBookBtn setImage:[UIImage imageNamed:@"universal.toBook.png"] forState:(UIControlStateNormal)];
        [_toBookBtn addTarget:self action:@selector(toBookBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _toBookBtn;
}

- (UIButton *)toHomeBtn     //跳转到小窝
{
    if (!_toHomeBtn) {
        _toHomeBtn = [[UIButton alloc]initWithFrame:CGRectMake(500, 40, BTN_SIZE, BTN_SIZE)];
        [_toHomeBtn setImage:[UIImage imageNamed:@"universal.toHome.png"] forState:(UIControlStateNormal)];
        [_toHomeBtn addTarget:self action:@selector(toHomeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _toHomeBtn;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    [bgImageView setImage:[UIImage imageNamed:@"HTEView.png"]];
    
    NSLog(@"width: %f ; hight: %f",[[UIScreen mainScreen]bounds].size.width,[[UIScreen mainScreen]bounds].size.height);
    
    [self.view addSubview:bgImageView];
    [self.view addSubview:self.petImageView];
    [self.view addSubview:self.earthImage];
    [self.view addSubview:self.toHomeBtn];
    [self.view addSubview:self.toBookBtn];
    
}


#pragma mark - 跳转
- (void)toHomeBtnClick      //跳转回小窝
{
    HomeViewController *homeViewController = [[HomeViewController alloc]init];
    [self presentViewController:homeViewController animated:YES completion:nil];
}
- (void)toBookBtnClick      //跳转回图书界面
{
    HTBookViewController *bookViewController = [[HTBookViewController alloc]init];
    [self presentViewController:bookViewController animated:YES completion:nil];
}

#pragma mark - 答题
-(void)questionClick
{
    VideoPickerViewController *videoCV = [[VideoPickerViewController alloc]init];
    [self presentViewController:videoCV animated:YES completion:nil];
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
