//
//  VideoPickerViewController.m
//  物语
//
//  Created by 新  叶子 on 2019/7/20.
//  Copyright © 2019 QAQ. All rights reserved.
// 看视频

#import "VideoPickerViewController.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MobileCoreServices/MobileCoreServices.h>

static float current;
static float total;

@interface VideoPickerViewController ()<UINavigationControllerDelegate>

@property(nonatomic,strong,readwrite) UIImageView *coverView;   //视频占位图
@property(nonatomic,strong,readwrite) UIImageView *playButton; //视频播放按钮
@property(nonatomic,strong,readwrite) NSString *videoUrl;
@property(nonatomic,strong,readwrite) AVPlayerItem *avPlayerItem;
@property(nonatomic,strong,readwrite) AVPlayer *avPlayer;
@property(nonatomic,strong,readwrite) AVPlayerLayer *avPlayerLayer;

@property (nonatomic,strong,readwrite)UIView *container; //播放器容器
@property (nonatomic,strong,readwrite)UIButton *playOrPause; //播放/暂停按钮
@property (nonatomic,strong,readwrite)UIProgressView *progress;//播放进度
@property (nonatomic,strong,readwrite)UIImageView *backBtn;//播放进度
@property (nonatomic,strong,readwrite)UIButton *volumeBtn;//播放进度



@end


@implementation VideoPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect frame = [[UIScreen mainScreen]bounds];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:({
        _container = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height-50)];
        _container;
    })];
    
    [_container addSubview:({
        _coverView = [[UIImageView alloc]init];
        _coverView.frame = _container.bounds;
        _coverView.image = [UIImage imageNamed:@"videoCover"];
        _coverView.userInteractionEnabled = YES;
        _coverView;
    })];
    
    [_coverView addSubview:({
        _playButton = [[UIImageView alloc]initWithFrame:CGRectMake((_coverView.bounds.size.width-50)/2,(_coverView.bounds.size.height-80)/2,50,50)];
        _playButton.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapToPlay = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(_startPlay)];
        [_playButton addGestureRecognizer:tapToPlay];
        _playButton.image = [UIImage imageNamed:@"startButton"];
        _playButton;
    })];
    [_coverView addSubview:({
        _backBtn = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 50, 50)];
        _backBtn.image = [UIImage imageNamed:@"universal.back.png"];
        UITapGestureRecognizer *tapToBack = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(_backToEarth)];
        [_backBtn addGestureRecognizer:tapToBack];
        _backBtn;
    })];
    [self.view addSubview:({
        //进度条为圆角矩形，默认设定的高度为其背景高度
        _progress = [[UIProgressView alloc]initWithFrame:CGRectMake(0,_container.bounds.size.height, _container.bounds.size.width, 10)];
        //更改进度条高度
        _progress.transform = CGAffineTransformMakeScale(1.0f,3.0f);
        //未走过的进度条
        _progress.trackTintColor = [UIColor grayColor];
        //已走过的进度条
        _progress.progressTintColor = [UIColor cyanColor];
//        _progress.progress = 0;
        _progress;
    })];
    [self.view addSubview:({
        _playOrPause = [[UIButton alloc]initWithFrame:CGRectMake(50, _container.bounds.size.height+15, 30, 30)];
        [_playOrPause setImage:[UIImage imageNamed:@"video-pause"] forState:UIControlStateNormal];
        [_playOrPause addTarget:self action:@selector(_playOrPause:) forControlEvents:UIControlEventTouchUpInside];
        _playOrPause.showsTouchWhenHighlighted = YES;
        _playOrPause;
    })];
    [self.view addSubview:({
        _volumeBtn = [[UIButton alloc]initWithFrame:CGRectMake(_container.frame.size.width-80, _container.frame.size.height+15, 30, 30)];
         [_volumeBtn setImage:[UIImage imageNamed:@"video-volume"] forState:UIControlStateNormal];
        _volumeBtn;
    })];
    
    //监听事件：视频播放停止时
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(_playToEnd) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
}

-(void)deallocObserser{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    [_avPlayerItem removeObserver:self forKeyPath:@"status"];
    [_avPlayerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
}

-(void)addProgressObserver{
    __weak typeof(self) weakSelf = self;
    //监听播放进度，在主线程中一秒回调一次
    [_avPlayer addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        //        NSLog(@"播放进度：%@",@(CMTimeGetSeconds(time)));
        //        [_progress setProgress:(CMTimeGetSeconds(time)/videoDuration) animated:YES];
        current = CMTimeGetSeconds(time);
        total = CMTimeGetSeconds([weakSelf.avPlayerItem duration]);
        NSLog(@"当前已经播放%.2fs.",current);
        if (current) {
            [weakSelf.progress setProgress:(current/total) animated:YES];
        }
    }];
}
#pragma mark - 公共方法,设置图片占位符和视频url
-(void)layoutWithVideoCoverUrl:(NSString *)videoCoverUrl videoUrl:(NSString *)videoUrl{
//    _coverView.image = [UIImage imageNamed:videoCoverUrl];
    _playButton.image = [UIImage imageNamed:@"startButton"];
    _videoUrl = videoUrl;
}

//点击手势开始播放
-(void)_startPlay{
    
    NSURL *videoURL = [NSURL URLWithString:_videoUrl];
    AVAsset *avAsset = [AVAsset assetWithURL:videoURL];
    _avPlayerItem = [AVPlayerItem playerItemWithAsset:avAsset];
    
    //监听视频状态的更新
    [_avPlayerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    [_avPlayerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    
    _avPlayer = [AVPlayer playerWithPlayerItem:_avPlayerItem];
    //进度条更新
    [self addProgressObserver];
    _avPlayerLayer = [AVPlayerLayer playerLayerWithPlayer:_avPlayer];
    _avPlayerLayer.frame = _coverView.bounds;
    [_coverView.layer addSublayer:_avPlayerLayer];
    
    [_avPlayer play];
}

//暂停/继续播放
-(void)_playOrPause:(UIButton *)sender{
    if (_avPlayer.rate == 0) {
       [sender setImage:[UIImage imageNamed:@"video-playing"] forState:UIControlStateNormal];
        [_avPlayer play];
    }else if(_avPlayer.rate == 1){
        [sender setImage:[UIImage imageNamed:@"video-pause"] forState:UIControlStateNormal];
        [_avPlayer pause];
    }
}
//视频播放停止后
-(void)_playToEnd{
    [_avPlayerLayer removeFromSuperlayer];
    _avPlayerItem = nil;
    _avPlayer = nil;
    [_playOrPause setImage:[UIImage imageNamed:@"video-pause"] forState:UIControlStateNormal];
    [self deallocObserser];
//    [_avPlayer seekToTime:CMTimeMake(0, 1)];
//    [_avPlayer  play];
    NSLog(@"play to end");
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"status"]) {
        //缓冲完成，开始播放
        if (((NSNumber *)[change objectForKey:NSKeyValueChangeNewKey]).integerValue == AVPlayerItemStatusReadyToPlay) {
            [_progress setProgress:0];
            [_playOrPause setImage:[UIImage imageNamed:@"video-playing"] forState:UIControlStateNormal];
            [_avPlayer play];
        }else{
            NSLog(@"播放错误");
        }
    }else if ([keyPath isEqualToString:@"loadedTimeRanges"]){
//        NSLog(@"缓冲状态：%@",[change objectForKey:NSKeyValueChangeNewKey]);
//        NSArray *array = _avPlayerItem.loadedTimeRanges;
//        CMTimeRange timeRange = [array.firstObject CMTimeRangeValue];//本次缓冲时间范围
//        float startSeconds = CMTimeGetSeconds(timeRange.start);
//        float durationSeconds = CMTimeGetSeconds(timeRange.duration);
//        NSTimeInterval totalBuffer = startSeconds + durationSeconds;//缓冲总长度
//        NSLog(@"共缓冲：%.2f",totalBuffer);
    }
}
-(void)_backToEarth{
    [self deallocObserser];
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
