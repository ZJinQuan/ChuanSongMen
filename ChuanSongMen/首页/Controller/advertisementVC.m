//
//  advertisementVC.m
//  ChuanSongMen
//
//  Created by apple on 16/2/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "advertisementVC.h"

@interface advertisementVC ()<UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (nonatomic, strong) UIImagePickerController *imgPicker;
@property (weak, nonatomic) IBOutlet UIImageView *middleImageView;
@property (nonatomic, strong) NSString *filePath;
@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, strong) LPPopup *lp;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pictureWidth;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pictureHeight;


@end

@implementation advertisementVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLable.text = @"广告位悬赏";
    UITapGestureRecognizer *tap =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addPhoto:)];
    [self.middleImageView addGestureRecognizer:tap];
    self.imageArray = [NSMutableArray array];
    self.imgPicker = [[UIImagePickerController alloc] init];
    self.imgPicker.delegate = self;

}


-(void)addPhoto:(UITapGestureRecognizer *)gesture{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"请选择操作" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相册", @"拍照", nil];
    sheet.tag = 1001;
    [sheet showInView:self.view];
}


#pragma mark ========设置导航栏按钮 ===========================
- (void)initBaseNavigationLeftBar{
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(10, 20 + 5, 40, 30);
    [leftButton setTitle:@"返回" forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftPage) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
}
- (void)initBaseNavigationRightBar{
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(KScrennWith -10 - 40, 20 + 5, 40, 30);
    [rightButton setTitle:@"发布" forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightPage) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
}


#pragma mark 导航栏按钮点击方法
-(void)leftPage{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightPage{
    
    NSLog(@"点击开始发布广告");
    if (self.imageArray.count < 1) {
        [self showMessage:@"请选择图片"];
    }else{
        
        NSInteger uid = [[NSUserDefaults standardUserDefaults] integerForKey:@"key_ShortVersion"];
        
        NSString *userid = [[NSNumber numberWithInteger:uid] stringValue];
        
        AppDelegate *app = [UIApplication sharedApplication].delegate;
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:userid forKey:@"document.user.id"];
        [params setObject:self.textField.text forKey:@"document.info"];
        [params setObject:@"1" forKey:@"document.isSee"];
        int number =  arc4random() % 100000 + 890000;
        NSString *str = [NSString stringWithFormat:@"%@%d%d",[self getNowDate],number, self.userId];
        [params setObject:str forKey:@"document.token"];
        [params setObject:@"3" forKey:@"document.type"];
        [params setObject:self.totalMoney forKey:@"document.allPrice"];
        [params setObject:self.price forKey:@"document.price"];
        [params setObject:self.number forKey:@"document.count"];
      
        [self POSTImage:@"http://120.24.46.199/Door/useraddDocument"  params:params image:_imageArray result:^(id responseObj, NSError *error) {
        }];
        
    }
    
    
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
        switch (buttonIndex) {
            case 0: {  //相册
                if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                    self.imgPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    // 呈现图库
                    [self presentViewController:_imgPicker animated:YES completion:nil];
                }
            }
                break;
            case 1: { //拍照
                // 调用摄像头
                if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                    self.imgPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                    // 呈现图库
                    [self presentViewController:_imgPicker animated:YES completion:nil];
                }
            }
                break;
            default:
                break;
        }
        
}




- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        //先把图片转成NSData
        UIImage* image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        self.middleImageView.image = image;
        //图片保存的路径
        //这里将图片放在沙盒的documents文件夹中
        NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        //文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        //把刚刚图片转换的data对象拷贝至沙盒中 并保存为image.png
         NSData *data;
        [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
        [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:@"/image.png"] contents:data attributes:nil];
        //得到选择后沙盒中图片的完整路径
        self.filePath = [[NSString alloc]initWithFormat:@"%@%@",DocumentsPath,  @"/image.png"];
        [picker dismissViewControllerAnimated:YES completion:nil];
        
        NSLog(@"imagInfo == %@", image);
        self.pictureWidth.constant  = KScrennWith;
        self.pictureHeight.constant = KScrennWith / 4 * 3;
        self.middleImageView.image = image;
        [self.imageArray removeAllObjects];
        [self.imageArray addObject:image];
    }
    
}






#pragma mark - 上传图片的网络封装
- (void)POSTImage:(NSString *)url params:(id)params image:(NSArray *)image result:(ResultBlock)resultBlock
{
    [self showHUD:@"正在上传..."];
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.requestSerializer = [AFHTTPRequestSerializer serializer];
    [mgr POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        for (int i = 0; i < image.count; i++) {
            // jpg图片转二进制
            NSData *iconData = UIImageJPEGRepresentation(image[i], 0.5);
            
            //如果你的图片本身就是2进制的NSData形式，那么可以判断第一个字节得出类型：
            uint8_t c;
            NSString * mimeType;
            [iconData getBytes:&c length:1];
            switch (c) {
                    
                case 0xFF:
                    
                    mimeType = @"image/jpeg";
                    break;
                case 0x89:
                    
                    mimeType = @"image/png";
                    break;
                case 0x47:
                    
                    mimeType = @"image/gif";
                    break;
                case 0x4D:
                    
                    mimeType = @"image/tiff";
                    break;
                default:
                    break;
            }
            // 拼装Body
            [formData appendPartWithFileData:iconData name:@"pic" fileName:[NSString stringWithFormat:@"photo.jpg"] mimeType:mimeType];
        }
        
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //使用通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"topBtnClick" object:nil];
        [self hideHUD];
        NSLog(@"%@", responseObject);
        NSDictionary * dict = responseObject;
        if ([dict[@"result"] integerValue] == 0) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"发布成功" object:nil];
            _lp = [[LPPopup alloc] initWithText:dict[@"message"]];
            [_lp showInView:self.view centerAtPoint:self.view.center duration:1 completion:^{
                [self.navigationController popToRootViewControllerAnimated:YES];
            }];
        } else {
            [self showMessage:dict[@"message"]];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self hideHUD];
        NSLog(@"error == %@", error);
    }];
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
