//
//  TakePhotosViewController.m
//  物语
//
//  Created by 新  叶子 on 2019/7/17.
//  Copyright © 2019 QAQ. All rights reserved.
//

#import "TakePhotosViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface TakePhotosViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property(nonatomic,strong)UIButton *backBtn;

@end

@implementation TakePhotosViewController

-(UIImagePickerController *)imagePickerController
{
    if (!_imagePickerController) {
        _imagePickerController = [[UIImagePickerController alloc]init];
        _imagePickerController.delegate = self.delegate;
        _imagePickerController.mediaTypes = [NSArray arrayWithObject:(__bridge NSString*)kUTTypeImage];
    }
    return _imagePickerController;
}

-(UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
    }
    return _imageView;
}

-(UIButton *)backBtn
{
    if(!_backBtn){
        _backBtn = [[UIButton alloc]initWithFrame:CGRectMake(40, 40, 50, 50)];
        [_backBtn.imageView setImage:[UIImage imageNamed:@"universal.back.png"]];
        [_backBtn addTarget:self action:@selector(dismissView) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self) {
        [self.view addSubview:_imageView];
        [self.view addSubview:_backBtn];
    }
    
    // Do any additional setup after loading the view.
}

-(void)dismissView
{
    [self dismissViewControllerAnimated:YES completion:nil];
}





//采集图片

@end
