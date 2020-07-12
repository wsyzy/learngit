//
//  StoryBookViewController.h
//  物语
//
//  Created by 新  叶子 on 2019/7/20.
//  Copyright © 2019 QAQ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface StoryBookViewController : UIViewController<UIPageViewControllerDataSource,UIPageViewControllerDelegate>

@property (nonatomic,strong)UIPageViewController *pageViewController;
@property (nonatomic,strong)NSMutableArray *dataArray;

@end

NS_ASSUME_NONNULL_END
