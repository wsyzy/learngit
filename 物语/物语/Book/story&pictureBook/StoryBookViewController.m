//
//  StoryBookViewController.m
//  物语
//
//  Created by 新  叶子 on 2019/7/20.
//  Copyright © 2019 QAQ. All rights reserved.
//

#import "StoryBookViewController.h"
#import "contentImagesViewController.h"

@interface StoryBookViewController ()

@property (nonatomic,strong)UIButton *backBtn;

@end

@implementation StoryBookViewController

-(UIButton *)backBtn
{
    if (!_backBtn) {
        _backBtn = [[UIButton alloc]initWithFrame:CGRectMake(40, 40, 50, 50)];
        [_backBtn.imageView setImage:[UIImage imageNamed:@"universal.back.png"]];
        [_backBtn addTarget:self action:@selector(dismissView) forControlEvents:UIControlEventTouchUpInside];
        _backBtn.backgroundColor =[UIColor redColor];
    }
    return _backBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view bringSubviewToFront:_backBtn];
    //创建数据源
    _dataArray = [NSMutableArray array];
    contentImagesViewController *imageVC1 = [[contentImagesViewController alloc]init];
    imageVC1.image = [UIImage imageNamed:@"bookBG-left"];
    [imageVC1.view bringSubviewToFront:_backBtn];
    contentImagesViewController *imageVC2 = [[contentImagesViewController alloc]init];
    imageVC2.image = [UIImage imageNamed:@"bookBG-right"];
    contentImagesViewController *imageVC3 = [[contentImagesViewController alloc]init];
    imageVC3.image = [UIImage imageNamed:@"bookBG-left"];
    contentImagesViewController *imageVC4 = [[contentImagesViewController alloc]init];
    imageVC4.image = [UIImage imageNamed:@"bookBG-right"];
    [_dataArray addObject:imageVC1];
    [_dataArray addObject:imageVC2];
    [_dataArray addObject:imageVC3];
    [_dataArray addObject:imageVC4];
    
    
    //设置第三个参数
    NSDictionary *options =[NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:UIPageViewControllerSpineLocationMid] forKey: UIPageViewControllerOptionSpineLocationKey];
    
    //初始化UIPageViewController
    _pageViewController = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:options];
    
    //指定代理
    _pageViewController.dataSource = self;
    _pageViewController.delegate = self;
    
    //设置frame
    _pageViewController.view.frame = self.view.bounds;
    
    //是否双面显示
    _pageViewController.doubleSided = YES;
    
    self.view.clipsToBounds = YES;
    //设置首页显示数据
    contentImagesViewController *imageViewController1 = [self createImage:0];
    contentImagesViewController *imageViewController2 = [self createImage:1];
    
    NSArray *array = [NSArray arrayWithObjects:imageViewController1,imageViewController2, nil];
    [_pageViewController setViewControllers:array direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    self.view.clipsToBounds = YES;
    //添加pageViewController到Controller
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.view bringSubviewToFront:_backBtn];
}



-(void)dismissView
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//获取指定显示的controller
-(contentImagesViewController *)createImage:(NSInteger)integer
{
    return [_dataArray objectAtIndex:integer];
}

//获取controller元素下标
-(NSInteger)integerWithController:(contentImagesViewController *)VC
{
    return [_dataArray indexOfObject:VC];
}

#pragma mark - UIPageViewControllerDataSource

//显示前一页
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSInteger integer =  [self integerWithController:(contentImagesViewController *)viewController];
    if(integer == 0 || integer == NSNotFound){
        return nil;
    }
    integer--;
    return [self createImage:integer];
}

//显示后一页
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSInteger integer = [self integerWithController:(contentImagesViewController *)viewController];
    if(integer ==NSNotFound){
        return nil;
    }
    integer++;
    if(integer == _dataArray.count){
        return nil;
    }
    return [self createImage:integer];
}

//返回页控制器中页的数量
-(NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return _dataArray.count;
}

//返回页控制器中当前页的索引
-(NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}

#pragma mark - UIPageViewControllerDelegate


//设置PUIPageViewController的方向
- (UIInterfaceOrientationMask)pageViewControllerSupportedInterfaceOrientations:(UIPageViewController *)pageViewController
{
    return UIInterfaceOrientationMaskLandscape;
}

////翻页控制器将要翻页时执行的方法
//- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers
//{
//
//}

//防止上一个动画还没有结束，下一个动画就开始了
//当用户从一个页面转到下一个或者前一个页面，或者用户开始从一个页面转向另一个页面的中途后悔，并撤销返回到了之前的页面时，将会调用这个方法
-(void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    if(finished && completed)
    {
        //无论有无翻页，只要动画结束就恢复交互
        pageViewController.view.userInteractionEnabled = YES;
    }
}

@end
