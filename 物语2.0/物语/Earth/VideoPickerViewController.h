//
//  VideoPickerViewController.h
//  物语
//
//  Created by 新  叶子 on 2019/7/20.
//  Copyright © 2019 QAQ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VideoPickerViewController : UIViewController

#pragma mark - 公共方法,设置图片占位符和视频url
-(void)layoutWithVideoCoverUrl:(NSString *)videoCoverUrl videoUrl:(NSString *)videoUrl;

@end

NS_ASSUME_NONNULL_END
