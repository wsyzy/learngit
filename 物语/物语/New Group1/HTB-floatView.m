//
//  HTB-floatView.m
//  物语
//
//  Created by 叶子 on 2019/7/8.
//  Copyright © 2019 QAQ. All rights reserved.
//

#import "HTB-floatView.h"

@interface HTB_floatView()

@property (nonatomic,strong,readwrite) UIView *backgroundView;
@property (nonatomic,strong,readwrite) UIView *contentView;
@property (nonatomic,strong,readwrite) dispatch_block_t floatBlock;

@end

@implementation HTB_floatView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        [self addSubview:({
            _backgroundView = [[UIView alloc]initWithFrame:self.bounds];
            _backgroundView.backgroundColor = [UIColor whiteColor];
            _backgroundView.alpha = 0.5;
            [_backgroundView addGestureRecognizer:({
                UIGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissView)];
                tapGesture;
            })];
            _backgroundView;
        })];
        [self addSubview:({
            _contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
            _contentView.layer.cornerRadius = 50;
            _contentView.layer.masksToBounds = YES;
            _contentView.backgroundColor = [UIColor grayColor];
            _contentView.alpha = 0.5;
            _contentView;
        })];
        
    }
    return self;
}

-(void)showFloatViewFromPoint:(CGPoint)point
{
    _contentView.frame = CGRectMake(point.x, point.y, 0, 0);
    
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

@end
