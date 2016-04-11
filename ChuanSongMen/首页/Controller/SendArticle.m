//
//  SendArticle.m
//  ChuanSongMen
//
//  Created by apple on 15/10/9.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "SendArticle.h"
#import "SGImagePickerController.h"
#import "ZZPhotoKit.h"
#import "AddImageCell.h"
#import "PhotosPreviewVC.h"
#import "LocationVC.h"
@interface SendArticle ()<UITextViewDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
{
    UIButton *_leftButton;
    UIButton *_rightButton;
    NSString *_encodedImageStr;
    LPPopup  *_lp;
}
@property (nonatomic, strong) UIImagePickerController *imgPicker;
@property (nonatomic, strong) NSString *filePath;
@property (nonatomic, strong) NSData *userPhotoData;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *imageArray;
@property (strong, nonatomic) ZZBrowserPickerViewController *browserController;
@property (nonatomic,strong) NSString *publicStyle;
@end

@implementation SendArticle

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshImageArray:) name:@"删除了图片" object:nil];
}

- (void)refreshImageArray:(NSNotification *)notification{
    if (notification != nil) {
        self.imageArray = notification.object;
        [_collectionView reloadData];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
     self.imageArray = [NSMutableArray array];
    self.imgPicker = [[UIImagePickerController alloc] init];
    self.imgPicker.delegate = self;
    self.textView.delegate = self;
    if (self.selectPublishStyle == 1) {
        self.titleLable.text = @"分享悬赏";
        self.publicStyle = @"2";
    }else{
    self.titleLable.text = @"普通发布";
        self.publicStyle = @"1";
        
        
    }
 
    [_collectionView registerNib:[UINib nibWithNibName:@"AddImageCell" bundle:nil] forCellWithReuseIdentifier:@"addImageCell"];
    _collectionView.directionalLockEnabled = YES;

    [self initBaseNavigationLeftBar];
    [self initBaseNavigationRightBar];
}


#pragma mark ========设置导航栏按钮 ===========================
- (void)initBaseNavigationLeftBar{
    _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_leftButton setTitleColor:RGB(66, 196, 228) forState:UIControlStateNormal];
    _leftButton.frame = CGRectMake(10, 20 + 5, 40, 30);
    [_leftButton setTitle:@"返回" forState:UIControlStateNormal];
    
    [_leftButton addTarget:self action:@selector(leftPage) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_leftButton];
}
- (void)initBaseNavigationRightBar{
    _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightButton.frame = CGRectMake(KScrennWith -10 - 40, 20 + 5, 40, 30);
    [_rightButton setTitleColor:RGB(66, 196, 288) forState:UIControlStateNormal];
    [_rightButton setTitle:@"发布" forState:UIControlStateNormal];
    [_rightButton addTarget:self action:@selector(rightPag) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_rightButton];
}


#pragma mark 导航栏按钮点击方法
-(void)leftPage{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark ========发布按钮 ==========================
-(void)rightPag{
    
    NSInteger uid = [[NSUserDefaults standardUserDefaults] integerForKey:@"key_ShortVersion"];
    
    NSString *userid = [[NSNumber numberWithInteger:uid] stringValue];
    
    NSLog(@"点击开始发布广告");
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    
    if ([self.textView.text isEqualToString:@"有什么新鲜事?"]) {
        
        [self showMessage:@"请输入内容"];
        
    }else{
       
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:userid forKey:@"document.user.id"];
        
        [params setObject:self.textView.text forKey:@"document.info"];
        [params setObject:@"1" forKey:@"document.isSee"];
        int number =  arc4random() % 100000 + 890000;
        NSString *str = [NSString stringWithFormat:@"%@%d%d",[self getNowDate], number, 12];
        [params setObject:str forKey:@"document.token"];
        [params setObject:self.publicStyle forKey:@"document.type"];
        
        if ([self.publicStyle isEqualToString:@"2"]) {
            [params setObject:self.totalMoney forKey:@"document.allPrice"];
            [params setObject:self.price forKey:@"document.price"];
            [params setObject:self.number forKey:@"document.count"];
        }
        
        [self POSTImage:@"http://120.24.46.199/Door/useraddDocument"  params:params image:_imageArray result:^(id responseObj, NSError *error) {
        }];

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









#pragma mark ===========显示位置按钮方法实现 ==================
- (IBAction)showCurrentLocation:(UIButton *)sender {
    
}


#pragma mark ===========添加图片 ==================
- (IBAction)addPicturesAction:(UIButton *)sender {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"请选择操作" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相册", @"拍照", nil];
    sheet.tag = 1001;
    [sheet showInView:self.view];

    
}
#pragma mark ===========坐标定位 ==================
- (IBAction)locationActiion:(UIButton *)sender {
    LocationVC *location = [[LocationVC alloc] initWithNibName:@"LocationVC" bundle:nil];
    [self.navigationController pushViewController:location animated:YES];
}

#pragma mark ===========录制视频 ==================
- (IBAction)recordVideoAciton:(UIButton *)sender {
    
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (actionSheet.tag == 1001) { //照片
        switch (buttonIndex) {
            case 0: {  //相册
//                if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
//                   self.imgPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//                    // 呈现图库
//                    [self presentViewController:_imgPicker animated:YES completion:nil];
//                }
                ZZPhotoController *photoController = [[ZZPhotoController alloc]init];
                photoController.selectPhotoOfMax = 50;
                [photoController showIn:self result:^(id responseObject){
                    NSArray *array = (NSArray *)responseObject;
                    NSLog(@"%@",responseObject);
                    [self.imageArray addObjectsFromArray:array];
                    [_collectionView reloadData];
            }];
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
}



#pragma mark =========== 集合视图 代理  ===================
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    AddImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"addImageCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[AddImageCell alloc]init];
    }
    cell.imageView.image = self.imageArray[indexPath.row];
    UITapGestureExtension *tap = [[UITapGestureExtension alloc] initWithTarget:self action:@selector(deleteThePicture:)];
    tap.row = indexPath.row;
    [cell.deledeView addGestureRecognizer:tap];
    return cell;
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 2;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    collectionView.contentSize = CGSizeMake((KScrennWith - 4) / 3 * self.imageArray.count, collectionView.frame.size.height);
    return CGSizeMake((KScrennWith - 4) / 3, collectionView.frame.size.height);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    PhotosPreviewVC *phot = [[PhotosPreviewVC alloc] init];
    phot.imageArray = self.imageArray;
    phot.currentPhotoIndex = (int)indexPath.row + 1;
    phot.totalPhotoNumber = self.imageArray.count;
    [self.navigationController pushViewController:phot animated:YES];



}


- (void)deleteThePicture:(UITapGestureExtension *)gesture{
    [self.imageArray removeObjectAtIndex:gesture.row];
    [self.collectionView reloadData];
}


#pragma mark  =============  文本域 代理 =========================
//在开始编辑的代理方法中进行如下操作
- (void)textViewDidBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@"有什么新鲜事?"]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
        textView.font = [UIFont systemFontOfSize:14];
    }
}
//3.在结束编辑的代理方法中进行如下操作
- (void)textViewDidEndEditing:(UITextView *)textView {
    if (textView.text.length<1) {
        textView.text = @"有什么新鲜事?";
        textView.textColor = [UIColor darkGrayColor];
        textView.font = [UIFont systemFontOfSize:17];
    }
}



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        //先把图片转成NSData
        UIImage* image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        //        userImage = image;
//        self.imageCell.headerImage.image= image;
//        NSLog(@"%@", info);
//        self.imageCell.headerImage.hidden = NO;
        //        [self.tableView reloadData];
        NSData *data;
        if (image != nil) {
            self.userPhotoData = UIImageJPEGRepresentation(image, 0.1);
            _encodedImageStr = [NSString stringWithFormat:@"%@",self.userPhotoData];//进行64位转码转为字符串
        }
        //        else
        //        {
        //            userPhotoData = UIImagePNGRepresentation(image);
        //        }
        
        
        
        //图片保存的路径
        //这里将图片放在沙盒的documents文件夹中
        NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        
        //文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        //把刚刚图片转换的data对象拷贝至沙盒中 并保存为image.png
        [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
        [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:@"/image.png"] contents:data attributes:nil];
        
        //得到选择后沙盒中图片的完整路径
        self.filePath = [[NSString alloc]initWithFormat:@"%@%@",DocumentsPath,  @"/image.png"];
        
        //关闭相册界面
        //        [picker dismissModalViewControllerAnimated:YES];
        [picker dismissViewControllerAnimated:YES completion:nil];
        //创建一个选择后图片的小图标放在下方
        //类似微薄选择图后的效果
        //        UIImageView *smallimage = [[UIImageView alloc] initWithFrame:CGRectMake(50, 120, 40, 40)];
        
//        self.imageCell.headerImage.image = image;
        //        [self.tableView reloadData];
        //        self.isFromChangeUserPic = YES;
    }
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
