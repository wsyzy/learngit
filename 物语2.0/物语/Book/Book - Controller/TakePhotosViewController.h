//
//  TakePhotosViewController.h
//  物语
//
//  Created by 新  叶子 on 2019/7/17.
//  Copyright © 2019 QAQ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TakePhotosViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, weak, nullable) id <UIImagePickerControllerDelegate> delegate;
@property (nonatomic,strong)UIImagePickerController *imagePickerController;
@property (nonatomic,strong)UIImageView *imageView;

@end

NS_ASSUME_NONNULL_END
