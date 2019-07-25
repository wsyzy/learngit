//
//  contentImagesViewController.m
//  物语
//
//  Created by 新  叶子 on 2019/7/20.
//  Copyright © 2019 QAQ. All rights reserved.
//

#import "contentImagesViewController.h"

@interface contentImagesViewController ()

@property (nonatomic,strong)UIButton *backBtn;

@end

@implementation contentImagesViewController

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
    _imageView = [[UIImageView alloc]initWithFrame:(self.view.bounds)];
    _imageView.image = _image;
    //    _imageView.center = self.view.center;
    _imageView.contentMode = UIViewContentModeScaleToFill;
//    _imageView.userInteractionEnabled = YES;
    //    _imageView.backgroundColor = [UIColor redColor];
    self.imageView.clipsToBounds = YES;
    self.view.clipsToBounds = YES;
    [self.view addSubview:_imageView];
    [self.view addSubview:_backBtn];
    [self.imageView addSubview:_backBtn];
    [self.imageView bringSubviewToFront:_backBtn];
}

-(void)dismissView
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
