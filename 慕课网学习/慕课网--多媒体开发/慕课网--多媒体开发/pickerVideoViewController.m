//
//  pickerVideoViewController.m
//  慕课网--多媒体开发
//
//  Created by 叶子 on 2019/7/15.
//  Copyright © 2019 叶子. All rights reserved.
//

#import "pickerVideoViewController.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface pickerVideoViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    //将视频路径定义为成员变量
    NSURL *mediaURL;
}

//采集视频
@property (nonatomic,strong)UIImagePickerController *picker;
//播放视频
@property (nonatomic,strong)AVPlayerViewController *playerController;

@end

@implementation pickerVideoViewController

-(UIImagePickerController *)picker
{
    if (!_picker) {
        _picker = [[UIImagePickerController alloc]init];
        
        //采集源类型
        _picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        //媒体类型
        _picker.mediaTypes = [NSArray arrayWithObject:(__bridge NSString *)kUTTypeMovie];
        
        //内置摄像头录制的动画的视频质量设置
        _picker.videoQuality = AVAudioQualityHigh;
        
        //设置代理
        _picker.delegate = self;
    }
    return _picker;
}

-(AVPlayerViewController *)playerController
{
    if (!_playerController) {
        
        _playerController = [[AVPlayerViewController alloc]init];
        
        //创建avplayer对象，用来播放视频 -- 视频文件路径
        _playerController.player = [[AVPlayer alloc]initWithURL: mediaURL];
        
        //播放窗口大小
        //1.全屏大小
//        [self presentViewController:self.playerController animated:YES completion:nil];
        //2.小屏播放
//        self.picker.view.frame = CGRectMake(20, 20, 400, 400);
        [self.view addSubview:self.playerController.view];
    }
    return _playerController;
}

//采集视频
- (IBAction)pick:(UIButton *)sender {
    //如果摄像头可用，从摄像头采集视频数据
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        self.picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    [self presentViewController:self.picker animated:YES completion:nil];
}

//播放视频
- (IBAction)playClick:(UIButton *)sender {
    [self.playerController.player play];
}


//采集媒体数据完成之后的回调处理
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey, id> *)info
{
    //获取媒体类型
    NSString *type = info[UIImagePickerControllerMediaType];
    //如果是视频类型
    if ([type isEqualToString:(__bridge NSString *)kUTTypeMovie]) {
        //获取视频媒体的路径
        mediaURL = info[UIImagePickerControllerMediaURL];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

//取消采集后的处理
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"Cancle take video");
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
