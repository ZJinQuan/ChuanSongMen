//
//  PhotosPreviewVC.m
//  ChuanSongMen
//
//  Created by apple on 16/3/9.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "PhotosPreviewVC.h"
#import "photosPreCell.h"
#import "UIView+Extension.h"
@interface PhotosPreviewVC ()<UIScrollViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, assign) int currenIndex;
@end

@implementation PhotosPreviewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
      self.titleLable.text = [NSString stringWithFormat:@"图片预览%d/%ld", _currentPhotoIndex, _totalPhotoNumber];

    [self initMainScrollView];
    [self scrollViewOffset];
}

#pragma mark ========= 跳转到哪个页面 =======
- (void)scrollViewOffset {
    //跳转到哪个页面
    [_scrollViews setContentOffset:CGPointMake(_scrollViews.bounds.size.width * _currentPhotoIndex, 0) animated:YES];
}
#pragma mark ========= 跳转到哪个页面 =======
- (void)initMainScrollView {
    _scrollViews = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, KScrennWith, KScrennHeight - 40)];
    [self.view addSubview:_scrollViews];
    _scrollViews.tag = 2001;
    _scrollViews.delegate = self;
    _scrollViews.pagingEnabled = YES;
    _scrollViews.bounces = NO;
    _scrollViews.contentSize = CGSizeMake(KScrennWith * _totalPhotoNumber, _scrollViews.bounds.size.height);
    [self initSubScrollView];
}
- (void)initSubScrollView {
    for (int i = 0; i < _imageArray.count; i++) {
        //用来存放单个图片
        UIScrollView * subSV = [[UIScrollView alloc] initWithFrame:CGRectMake(KScrennWith * i, 0, KScrennWith, _scrollViews.bounds.size.height)];
        [_scrollViews addSubview:subSV];
    
        subSV.minimumZoomScale = 0.5;
        subSV.maximumZoomScale = 2.0;
        subSV.delegate = self;
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:subSV.bounds];
        imageView.userInteractionEnabled = YES;
        imageView.image = _imageArray[i];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftPage)];
        // 设置快速手势的方向向下
        swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
        [imageView addGestureRecognizer:swipeDown];
        imageView.tag = 1000;
        [subSV addSubview:imageView];
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark ========设置导航栏按钮 ===========================
- (void)initBaseNavigationLeftBar{
    _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _leftButton.frame = CGRectMake(10, 20 + 5, 40, 30);
    [_leftButton setTitle:@"取消" forState:UIControlStateNormal];
    [_leftButton addTarget:self action:@selector(leftPage) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_leftButton];
}
- (void)initBaseNavigationRightBar{
    _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightButton.frame = CGRectMake(KScrennWith -10 - 40, 20 + 5, 40, 30);
    [_rightButton setTitle:@"删除" forState:UIControlStateNormal];    [_rightButton addTarget:self action:@selector(rightPage) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_rightButton];
}

- (void)leftPage{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)rightPage{
    [self.imageArray removeObjectAtIndex:self.currenIndex];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"删除了图片" object:self.imageArray];
    [self.navigationController popViewControllerAnimated:YES];
    
}



#pragma mark ====== 滑动视图代理 ========================
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView.tag == 2001) {
        self.currentPhotoIndex = scrollView.contentOffset.x / KScrennWith;
        self.titleLable.text = [NSString stringWithFormat:@"图片预览%d/%ld", self.currentPhotoIndex + 1, _totalPhotoNumber];
    }
}





#pragma mark ======== 这是通过手势放大或缩小图片 ==============
- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    if (scrollView.zoomScale<=1.0) {
        UIImageView *imageView = (UIImageView *)[scrollView viewWithTag:1000];
        imageView.center = CGPointMake(scrollView.bounds.size.width/2, scrollView.bounds.size.height/2);
    }
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    UIImageView *imageView = (UIImageView *)[scrollView viewWithTag:1000];
    return imageView;
}




@end
