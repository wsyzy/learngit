//
//  HTB-floatView.h
//  物语
//
//  Created by 叶子 on 2019/7/8.
//  Copyright © 2019 QAQ. All rights reserved.
//

#import <UIKit/UIKit.h>

//@protocol FloatViewController
//@required
//-(void)dismissView;
//
//@end

NS_ASSUME_NONNULL_BEGIN

@interface HTB_floatView : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource>
-(void)dismissView;
- (void)showFloatViewFromPoint:(CGPoint)point;
@property (nonatomic, weak, nullable) id <UICollectionViewDelegate> delegate;
@property (nonatomic, weak, nullable) id <UICollectionViewDataSource> dataSource;
//@property (nonatomic, weak, nullable) id <FloatViewController> dismissDelegate;

@end

NS_ASSUME_NONNULL_END
