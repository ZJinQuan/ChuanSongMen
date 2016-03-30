//
//  BaseViewController.m
//  JinKouDai
//
//  Created by femto01 on 15/9/9.
//  Copyright (c) 2015年 femto. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = RGB(245, 245, 245);
    self.navigationController.navigationBar.tintColor = navBarColor(0.0, 116.0, 180.0);
#pragma mark ---初始化导航栏左右侧按钮 ================================
    [self initBaseNavigationLeftBar];
    [self initBaseNavigationRightBar];
    _app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
#pragma mark =======设置导航栏标题 ===================
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    titleLabel.text = @"";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLable = titleLabel;
    self.navigationItem.titleView = titleLabel;
}





- (UIViewController *)appRootViewController
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}

/**
 @Description   提示信息
 @Parameter     信息内容
 @Return        no
 */
- (void)showMessage:(NSString *)string {
    LPPopup *popup = [LPPopup popupWithText:string];
    popup.textColor = [UIColor blackColor];
    [popup showInView:self.view
        centerAtPoint:self.view.center
             duration:1
             completion:nil];
}

#pragma mark -
#pragma mark - HUD
//隐藏加载
- (void)hideHUD
{
    [self.hud hide:YES];
}

//显示加载
- (void)showHUD:(NSString *)title
{
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    self.hud = [MBProgressHUD showHUDAddedTo:app.window animated:YES];
    self.hud.color = RGB(88, 97, 111);
    self.hud.labelText = title;
}


/**
 *  退出键盘
 */
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //获取整个屏幕任意的触摸对象
    UITouch * touch = [touches anyObject];
    //有触摸事件
    if (touch.tapCount >= 1) {
        [self.view endEditing:YES];
    }
}

/* 设置导航栏左边按钮*/
- (void)initBaseNavigationLeftBar{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 20, 20);
    [backButton setBackgroundImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backToLastPage) forControlEvents:UIControlEventTouchUpInside];
    self.backBtn = backButton;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
}

/*设置导航栏右边按钮*/
- (void)initBaseNavigationRightBar{
    
}


/*返回上一页*/
- (void)backToLastPage{
    [self.navigationController popViewControllerAnimated:YES];
    
}

//调整一些控件的圆角度
- (void)changeLayerOfSomeControl:(UIView *)control{
    control.layer.cornerRadius = 5;
    control.layer.masksToBounds = YES;
}
//调整一些控件的边宽和边色
- (void)changeBorderOfSomeControl:(UIView *)control borderColor:(UIColor *)borderColor borderWidth:(int)borderWidth{
    control.layer.borderColor = [borderColor CGColor];
    control.layer.borderWidth = borderWidth;
}


/*手机号码验证 MODIFIED BY HELENSONG*/
- (BOOL)isValidateMobile:(NSString *)mobile{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((17[0-9])|(13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

/*邮箱验证 MODIFIED BY HELENSONG*/
-(BOOL)isValidateEmail:(NSString *)email{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}



#pragma mark ==========  把当前时间转换为紧凑字符串 ================
- (NSString *)getNowDate{
    NSDate* dat = [NSDate date];
    NSTimeZone *zone2 = [NSTimeZone systemTimeZone];
    NSInteger interval2 = [zone2 secondsFromGMTForDate: dat];
    NSDate *localeDate2 = [dat  dateByAddingTimeInterval: interval2];
    NSString *str = [NSString stringWithFormat:@"%@", localeDate2];
    NSString *yearStr = [str substringToIndex:4];
    NSString *monthStr = [str substringWithRange:NSMakeRange(5, 2)];
    NSString *dayStr = [str substringWithRange:NSMakeRange(8, 2)];
    NSString *hoursStr = [str substringWithRange:NSMakeRange(11, 2)];
    NSString *minutesStr = [str substringWithRange:NSMakeRange(14, 2)];
    NSString *secondsStr = [str substringWithRange:NSMakeRange(17, 2)];
    NSString *totalStr = [NSString stringWithFormat:@"%@%@%@%@%@%@",yearStr, monthStr, dayStr, hoursStr, minutesStr, secondsStr];
    return totalStr;
}




#pragma mark ===== 获得字符串的高度 =========
- (CGFloat)heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width
{
    CGSize sizeToFit = [value sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByCharWrapping];//此处的换行类型（lineBreakMode）可根据自己的实际情况进行设置
    CGFloat height = sizeToFit.height;
    return height;
}
#pragma mark ===== 获取字符串的宽度 ====
- (CGFloat)widthForString:(NSString *)value fontSize:(CGFloat)fontSize andHeight:(CGFloat)height
{
    CGSize sizeToFit = [value sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(CGFLOAT_MAX, height) lineBreakMode:NSLineBreakByWordWrapping];//此处的换行类型（lineBreakMode）可根据自己的实际情况进行设置
    CGFloat width = sizeToFit.width;
    return width;
}




#pragma mark ==== 添加底部评论窗口 ==============
-(void)adBottomCommentView{
    _myMaskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScrennWith, KScrennHeight)];
    _myMaskView.backgroundColor = [UIColor clearColor];
   
    _myMaskView.userInteractionEnabled = YES;
    self.bottomCommentView = [[UIView alloc] initWithFrame:CGRectMake(0, KScrennHeight - 49 -37,  KScrennWith, 36)];
    self.bottomCommentView.backgroundColor = [UIColor darkGrayColor];
    [_myMaskView addSubview:_bottomCommentView];
    self.commentTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, 3,KScrennWith - 70, 30)];
    _commentTextView.layer.cornerRadius = 5;
    _commentTextView.layer.masksToBounds = YES;
    _commentTextView.layer.borderWidth = 1;
    _commentTextView.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    _commentTextView.font =[UIFont systemFontOfSize:14];
    _commentTextView.text = @"我也说一句";
    _commentTextView.textColor = [UIColor darkGrayColor];
    _commentTextView.delegate = self;
    [_bottomCommentView addSubview:_commentTextView];
    
    
    self.sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_sendButton setTitle:@"发送" forState:UIControlStateNormal];
    _sendButton.frame = CGRectMake(KScrennWith - 55, 3, 45, 30);
    _sendButton.layer.cornerRadius = 5;
    _sendButton.layer.masksToBounds = YES;
    _sendButton.backgroundColor = [UIColor whiteColor];
    _sendButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [_sendButton addTarget:self action:@selector(sendCommentToServer:) forControlEvents:UIControlEventTouchUpInside];
    [_sendButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_bottomCommentView addSubview:_sendButton];
//    [self.view bringSubviewToFront:_myMaskView];
    
     [self.view addSubview:_myMaskView];
    
}

-(void)sendCommentToServer:(UIButton *)sender{
    
}



//#pragma mark =======  文本视图 代理 ===============
//- (void)textViewDidBeginEditing:(UITextView *)textView {
//    if ([textView.text isEqualToString:@"我也说一句"]) {
//        textView.text = @"";
//        textView.textColor = [UIColor blackColor];
//        textView.font = [UIFont systemFontOfSize:12];
//    }
//}
////3.在结束编辑的代理方法中进行如下操作
//- (void)textViewDidEndEditing:(UITextView *)textView {
//    if (textView.text.length<1) {
//        textView.text = @"我也说一句";
//        textView.textColor = [UIColor darkGrayColor];
//        textView.font = [UIFont systemFontOfSize:14];
//    }
//}




@end
