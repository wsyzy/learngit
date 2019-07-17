//
//  HTB-floatView.h
//  物语
//
//  Created by 叶子 on 2019/7/8.
//  Copyright © 2019 QAQ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HTB_floatView : UIView<UICollectionViewDelegate,UICollectionViewDataSource>

- (void)showFloatViewFromPoint:(CGPoint)point;
@property (nonatomic, weak, nullable) id <UICollectionViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
