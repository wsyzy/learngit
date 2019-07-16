//
//  ViewController.m
//  慕课网--多媒体开发
//
//  Created by 叶子 on 2019/7/14.
//  Copyright © 2019 叶子. All rights reserved.
//

#import "takeAudiosViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>

@interface takeAudiosViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

//图片采集器
@property (nonatomic,strong) UIImagePickerController *pickerController;
//显示图片
@property (strong, nonatomic) IBOutlet UIImageView *presentImage;

@end

@implementation takeAudiosViewController

-(UIImagePickerController *)pickerController
{
    if (!_pickerController) {
        _pickerController = [[UIImagePickerController alloc]init];
        
        //1.设置数据源类型
        _pickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        
        //2.设置媒体类型(总共两种类型：图片或视频)
        //_bridge将C语言类型的kUTTypeImage(图片类型)桥接为NSString类型
        _pickerController.mediaTypes = [NSArray arrayWithObject:(
                                                                 __bridge NSString*)kUTTypeImage];
        
        //3.设置代理
        _pickerController.delegate = self;
    }
    return _pickerController;
}

//采集图片
- (IBAction)BtnClick:(UIButton *)sender {
    //先判断是否可以通过摄像头来采集
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        self.pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    //通过图库来采集
    else{
        self.pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    //弹出pickerViewController
    [self presentViewController:_pickerController animated:YES completion:nil];
}


//完成采集图片后的处理
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey, id> *)info
{
    //从info里获取媒体类型
    NSString *type = info[UIImagePickerControllerMediaType];
    //如果媒体类型是图片类型
    if ([type isEqualToString:(__bridge NSString*)kUTTypeImage]) {
        //从info里获取采集图片
        UIImage *image = info[UIImagePickerControllerOriginalImage];
        //显示到UI界面
        self.presentImage.image = image;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

//取消采集图片后的处理
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"Cancle");
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}


@end
