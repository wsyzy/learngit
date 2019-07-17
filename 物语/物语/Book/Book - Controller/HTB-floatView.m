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

-(UIView *)backgroundView
{
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _backgroundView.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5];
        _backgroundView.userInteractionEnabled = YES;
        UIGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissView)];
        [_backgroundView addGestureRecognizer:tapGesture];
    }
    return _backgroundView;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        [self addSubview:_backgroundView];
        [self addSubview:({
            UICollectionViewFlowLayout *flowLayOut = [[UICollectionViewFlowLayout alloc]init];
            flowLayOut.itemSize = CGSizeMake(90, 90);
            flowLayOut.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
            flowLayOut.minimumLineSpacing = 5;
            flowLayOut.minimumInteritemSpacing = 5;
            
            _contentView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:flowLayOut];
            _contentView.backgroundColor = [[UIColor grayColor]colorWithAlphaComponent:0.5];
            _contentView.delegate = self.delegate;
            _contentView.dataSource = self;
            [_contentView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:Cell];
            _contentView.layer.cornerRadius = 150;
            _contentView.layer.masksToBounds = YES;
            _contentView;
        })];
        
    }
    return self;
}

-(void)showFloatViewFromPoint:(CGPoint)point
{
    _contentView.frame = CGRectMake(point.x, point.y, 0, 0);
    //keywindow表示当前的window
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    [UIView animateWithDuration:1.f delay:0.f usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.contentView.frame = CGRectMake((self.bounds.size.width - 300) / 2, (self.bounds.size.height - 300) / 2, 300, 300);
    } completion:nil];
}

#pragma mark - 手势交互实现
-(void)dismissView
{
    [self removeFromSuperview];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 9;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:Cell forIndexPath:indexPath];
    if (!cell) {
        cell = [[UICollectionViewCell alloc]init];
    }
    UIImageView *homeImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 70, 70)];
    [homeImage setImage:[UIImage imageNamed:@"universal.toHome.png"]];
    
    UIImageView *earthImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 70, 70)];
    [earthImage setImage:[UIImage imageNamed:@"universal.toEarth.png"]];
    
    UIImageView *photoImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 70, 70)];
    [photoImage setImage:[UIImage imageNamed:@"universal.toPhoto.png"]];
    
    UIImageView *backImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 70, 70)];
    [backImage setImage:[UIImage imageNamed:@"universal.toHome.png"]];
    
    switch (indexPath.item) {
        case 1:
            [cell.contentView addSubview:homeImage];
            break;
        case 3:
            [cell.contentView addSubview:earthImage];
            break;
        case 5:
            [cell.contentView addSubview:photoImage];
            break;
        case 7:
            [cell.contentView addSubview:backImage];
            break;
    }
    return cell;
}
@end
