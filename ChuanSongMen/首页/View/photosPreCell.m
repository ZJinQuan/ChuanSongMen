//
//  photosPreCell.m
//  ChuanSongMen
//
//  Created by apple on 16/3/9.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "photosPreCell.h"
#import "UIView+Extension.h"
@implementation photosPreCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blueColor];
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.superview.superview.center.y - 115, KScrennWith, 230)];
        self.imageView = [[UIImageView alloc] initWithFrame:_scrollView.bounds];

        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
          //添加缩放手势
            UIPinchGestureRecognizer * pinchGesture = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(userPitchGesture:)];
        _scrollView.minimumZoomScale = 0.3;
        _scrollView.maximumZoomScale = 3;
            [self.imageView addGestureRecognizer:pinchGesture];
        
        [self addSubview:self.scrollView];
        [self addSubview:self.imageView];
    }
    return self;
}

/*缩放手势 实现方法*/
- (void)userPitchGesture:(UIPinchGestureRecognizer *)gesture{
    gesture.view.transform = CGAffineTransformScale(gesture.view.transform, gesture.scale, gesture.scale);//一个是宽scale,一个是高scale
    //每改变一次,缩放比归1
    if (gesture.scale < 1) {
        _scrollView.bouncesZoom = YES;
    }
    gesture.scale = 1.0;
}








@end
