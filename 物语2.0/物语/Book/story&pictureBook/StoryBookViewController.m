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

@property (nonatomic,strong)UIImageView *backBtn;  //返回键

@end

@implementation StoryBookViewController

-(UIImageView *)backBtn
{
    if (!_backBtn) {
        _backBtn = [[UIImageView alloc]initWithFrame:CGRectMake(40, 40, 50, 50)];
        _backBtn.image  = [UIImage imageNamed:@"universal.back.png"];
        UITapGestureRecognizer *tapToBack = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(_backToShelf)];
        [_backBtn addGestureRecognizer:tapToBack];
    }
    return _backBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加返回按钮
    [self.view addSubview:_backBtn];
    
    //创建图书数据源
    _dataArray = [NSMutableArray array];
    
    //设置4页 2面
    contentImagesViewController *imageVC1 = [[contentImagesViewController alloc]init];
    imageVC1.image = [UIImage imageNamed:@"bookBG-left"];
   
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
    
    //设置返回键一直在图书的最上层
    [self.view bringSubviewToFront:_backBtn];
    
//设置第三个参数，传入的是对UIPageViewController的一些配置组成的字典, 这个key只有在style是翻书效果UIPageViewControllerTransitionStylePageCurl的时候才有作用, 它定义的是书脊的位置,值对应着UIPageViewControllerSpineLocation这个枚举项
    
    //设置书脊居中，双页显示
    NSDictionary *options =[NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:UIPageViewControllerSpineLocationMid] forKey: UIPageViewControllerOptionSpineLocationKey];
    
    //初始化UIPageViewController，设置为翻页效果和横屏
    _pageViewController = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:options];
    
    //指定数据、样式代理
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

//退场
-(void)_backToShelf
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//获取指定显示的 controller
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
// 返回前一个页面,如果返回为nil,那么UIPageViewController就会认为当前页面是第一个页面不可以向前滚动或翻页
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSInteger integer =  [self integerWithController:(contentImagesViewController *)viewController];
    integer--;
    if(integer == 0 || integer == NSNotFound){
        return nil;
    }
    return [self createImage:integer];
}

//下一个页面,返回为nil,那么UIPageViewController就会认为当前页面是最后一个页面不可以向后滚动或翻页
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

//设置UIPageViewController的方向
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
