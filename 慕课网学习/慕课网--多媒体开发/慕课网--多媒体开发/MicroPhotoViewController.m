//
//  MicroPhotoViewController.m
//  慕课网--多媒体开发
//
//  Created by 叶子 on 2019/7/15.
//  Copyright © 2019 叶子. All rights reserved.
//

#import "MicroPhotoViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

@interface MicroPhotoViewController ()

//创建录音器对象
@property (nonatomic,strong)AVAudioRecorder *recorder;
//创建播放器对象
@property (nonatomic,strong)AVAudioPlayer *player;

@end

@implementation MicroPhotoViewController

-(AVAudioRecorder *)recorder
{
    if (!_recorder ) {
        //创建recorder时的第一个参数：设置录音保存路径
        NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/record"];
        
        //创建recorder时的第二个参数：录音设置（字典形式）
        NSMutableDictionary *settingDictionary = [[NSMutableDictionary alloc]init];
            //录音采样率
        [settingDictionary setValue:[NSNumber numberWithInt:44100] forKey:AVSampleRateKey];
            //录音格式
        [settingDictionary setValue:[NSNumber numberWithInt:1] forKey:AVFormatIDKey];
            //录音质量
        [settingDictionary setValue:[NSNumber numberWithInt:AVAudioQualityHigh] forKey:AVVideoQualityKey];
        
        _recorder = [[AVAudioRecorder alloc]initWithURL:[NSURL fileURLWithPath:path] settings:settingDictionary error:nil];
        //准备录音
        [_recorder prepareToRecord];
    }
    return _recorder;
}
    
-(AVAudioPlayer *)player
{
    if (!_player) {
        //创建player时的第一个参数：设置录音播放路径（这里的路径即为刚刚录音的保存路径）
        NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/record"];
//        NSString *path = [NSBundle mainBundle]pathForResource:@"" ofType:<#(nullable NSString *)#>];
        
        //创建播放器
        _player = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:path] error:nil];
       
        //准备播放
        [_player prepareToPlay];
    }
    return _player;
}


- (IBAction)BtnClick:(UIButton *)sender {
    if(sender.isSelected == NO){
        //开始录音
        [self.recorder record];
        sender.selected = YES;
    }else{
        //停止录音
        [self.recorder stop];
        sender.selected = NO;
    }
}
- (IBAction)playBtn:(UIButton *)sender {
    //开始播放
    [self.player play];
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
