//
//  LargerImgVC.m
//  BlueClient
//
//  Created by femtoapp's macbook pro  on 16/1/13.
//  Copyright © 2016年 马远征. All rights reserved.
//

#import "LargerImgVC.h"
#import "ImageModel.h"
@interface LargerImgVC () <UIScrollViewDelegate,UIActionSheetDelegate>
@property (nonatomic, strong) UIScrollView * scrollViews;
@property (nonatomic, assign) CGFloat offSet;
@property (nonatomic, strong) NSMutableArray * dataArr;
@property (nonatomic,strong) UILabel *bottomLabel;

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation LargerImgVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self addBottomView];
    [self setImgObject];
    
    [self initMainScrollView];
    
    [self scrollViewOffset];
}

- (void)addBottomView{
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, KScrennHeight - 40, KScrennWith, 40)];
    bottomView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:bottomView];
    _bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(KScrennWith/ 2 - 60, 5, 120, 30)];
    _bottomLabel.text = [NSString stringWithFormat:@"%ld/%lu", _currentIndex + 1, (unsigned long)_imgDataArr.count];
    _bottomLabel.textColor = [UIColor whiteColor];
    _bottomLabel.font = [UIFont systemFontOfSize:17];
    _bottomLabel.textAlignment = NSTextAlignmentCenter;
    [bottomView addSubview:_bottomLabel];
}



#pragma mark ========= 把模型都取出来 =======
- (void)setImgObject {

    _dataArr = [NSMutableArray array];
    for (ImageModel * models in _imgDataArr) {
        
        [_dataArr addObject:models];
    }
}
#pragma mark ========= 跳转到哪个页面 =======
- (void)scrollViewOffset {
    //跳转到哪个页面
    [_scrollViews setContentOffset:CGPointMake(_scrollViews.bounds.size.width * _currentIndex, 0) animated:YES];
}
#pragma mark ========= 跳转到哪个页面 =======
- (void)initMainScrollView {
    _scrollViews = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, KScrennWith, KScrennHeight - 40)];
    [self.view addSubview:_scrollViews];
    _scrollViews.tag = 2001;
    _scrollViews.delegate = self;
    _scrollViews.pagingEnabled = YES;
    _scrollViews.bounces = NO;
    _scrollViews.contentSize = CGSizeMake(KScrennWith * _imgDataArr.count, _scrollViews.bounds.size.height);
    [self initSubScrollView];
}
- (void)initSubScrollView {

    for (int i = 0; i < _imgDataArr.count; i++) {
        
        ImageModel * models = _dataArr[i];
        //用来存放单个图片
        UIScrollView * subSV = [[UIScrollView alloc] initWithFrame:CGRectMake(KScrennWith * i, 0, KScrennWith, _scrollViews.bounds.size.height)];
        
        [_scrollViews addSubview:subSV];
        

        subSV.minimumZoomScale = 0.5;
        subSV.maximumZoomScale = 2.0;
        subSV.delegate = self;
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:subSV.bounds];
        [subSV addSubview:imageView];
        
        imageView.userInteractionEnabled = YES;
        [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:BasePicAppending@"%@",models.url]] placeholderImage:[UIImage imageNamed:@"pic1@2x"]];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
//        
//        UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        // 设置快速手势的方向向下
//        swipeDown.direction = UISwipeGestureRecognizerDirectionUp;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [_scrollViews addGestureRecognizer:tap];
        imageView.tag = 1000;
        self.imageView = imageView;
        
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction)];
        
        [_scrollViews addGestureRecognizer:longPress];
    }
}
#pragma  mark ========== 手势 ============
- (void)tapAction:(UISwipeGestureRecognizer *)swipe
{
    
    // 判断手势的方向
//    if (swipe.direction == UISwipeGestureRecognizerDirectionUp)
//    {
//        // 动画
//        [UIView beginAnimations:nil context:NULL];
//        // 多久之后执行动画
//        //        [UIView setAnimationDelay:1];
//        // 动画持续时间
//        [UIView setAnimationDuration:0.1];
//        
//        // 代码写在中间...
//        CGRect rect = _scrollViews.frame;
//        rect.origin.y = -300;
//        _scrollViews.frame = rect;
//        
//        // 提交动画
//        [UIView commitAnimations];
//
//    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) longPressAction{
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"收藏", @"保存到手机", @"举报", nil];
    
    [sheet showInView:self.imageView];
}

#pragma mark - subSV delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.tag == 2001) {
        int currentIndex = (int)scrollView.contentOffset.x / KScrennWith;
         _bottomLabel.text = [NSString stringWithFormat:@"%d/%lu", currentIndex + 1, (unsigned long)_imgDataArr.count];
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

#pragma mark UIActionSheetDelegate

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    switch (buttonIndex) {
        case 0:
            NSLog(@"收藏");
            break;
        case 1:
            NSLog(@"保存到手机");
            
            UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
            
            break;
        case 2:
            NSLog(@"举报");
            break;
            
        default:
            break;
    }
    
}

- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    NSString *message = @"";
    
    if (!error) {
        [self showMessage:@"成功保存到相册"];
        message = @"成功保存到相册";
    }else
    {
        message = [error description];
    }
    NSLog(@"message is %@",message);
}

@end
