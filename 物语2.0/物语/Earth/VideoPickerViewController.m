//
//  VideoPickerViewController.m
//  物语
//
//  Created by 新  叶子 on 2019/7/20.
//  Copyright © 2019 QAQ. All rights reserved.
//

#import "VideoPickerViewController.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface VideoPickerViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    //将视频路径定义为成员变量
    NSURL *mediaURL;
}
//播放视频
@property (nonatomic,strong)AVPlayerViewController *playerController;

@end

@implementation VideoPickerViewController

-(AVPlayerViewController *)playerController
{
    if (!_playerController) {
        
        _playerController = [[AVPlayerViewController alloc]init];
        
        mediaURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"IMG_0277" ofType:nil]];
        
        //创建avplayer对象，用来播放视频 -- 视频文件路径
        _playerController.player = [[AVPlayer alloc]initWithURL:mediaURL];
        [self addChildViewController:_playerController];
        [self.view addSubview:self.playerController.view];
       
    }
    return _playerController;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.playerController.player play];
}


@end
