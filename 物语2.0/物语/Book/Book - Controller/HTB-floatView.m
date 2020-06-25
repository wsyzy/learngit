//
//  HTB-floatView.m
//  物语
//
//  Created by 叶子 on 2019/7/8.
//  Copyright © 2019 QAQ. All rights reserved.
//

#import "HTB-floatView.h"
#import "HTBookViewController.h"
#import "HomeViewController.h"
#import "HTEarthViewController.h"

@interface HTB_floatView()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UIView *backgroundView;
@property (nonatomic,strong) UICollectionView *contentView;

@end

@implementation HTB_floatView

#define Cell @"cellIdentifier"

-(void)viewDidLoad
{
    [self.view addSubview:({
        _backgroundView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _backgroundView.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5];
        _backgroundView.userInteractionEnabled = YES;
        UIGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissView)];
        [_backgroundView addGestureRecognizer:tapGesture];
        _backgroundView;
    }
         )];
        [self.view addSubview:({
            UICollectionViewFlowLayout *flowLayOut = [[UICollectionViewFlowLayout alloc]init];
            flowLayOut.itemSize = CGSizeMake(90, 90);
            flowLayOut.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
            flowLayOut.minimumLineSpacing = 5;
            flowLayOut.minimumInteritemSpacing = 5;
            
            _contentView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:flowLayOut];
            _contentView.backgroundColor = [[UIColor grayColor]colorWithAlphaComponent:0.5];
            _contentView.delegate = self.delegate;
            _contentView.dataSource = self.dataSource;
            [_contentView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:Cell];
            _contentView.layer.cornerRadius = 150;
            _contentView.layer.masksToBounds = YES;
            _contentView;
        })];
    
}

-(void)showFloatViewFromPoint:(CGPoint)point
{
    _contentView.frame = CGRectMake(point.x, point.y, 0, 0);
    //keywindow表示当前的window
    [[UIApplication sharedApplication].keyWindow addSubview:self.view];
    
    [UIView animateWithDuration:1.f delay:0.f usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.contentView.frame = CGRectMake((self.view.bounds.size.width - 300) / 2, (self.view.bounds.size.height - 300) / 2, 300, 300);
    } completion:nil];
}

#pragma mark - 手势交互实现
-(void)dismissView
{
    if (self.view) {
        [self.view removeFromSuperview];
    }
}


@end
