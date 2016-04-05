//
//  PersonalDataVC.m
//  ChuanSongMen
//
//  Created by apple on 15/9/14.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "PersonalDataVC.h"

#import "PersonFirstCell.h"
#import "PersonCenterCell.h"
#import "PersonThirdCell.h"

#import "UserInformationModel.h"

@interface PersonalDataVC ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate, UITextFieldDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate>

{
    
    UITableView *_tableView;
    
    NSArray *_leftArray;
    PersonFirstCell *_firstCell;
    NSString *_nickName; //昵称
    NSString *_email;
    NSString *_phoneNumber;
    NSString *_address;
    NSString *_school;
    
    NSString *_aboutMe;
    UserInformationModel *_model;
    NSArray *_dataSourceArray;
    NSString *_encodedImageStr;
    
}
@end

@implementation PersonalDataVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
      _leftArray = [NSArray arrayWithObjects:@"用户名:", @"昵   称:", @"邮   箱:", @"手机号:", @"地   址:", @"毕业于:", nil];
    self.navigationController.navigationBarHidden = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.titleLable.text = @"修改资料";
    [self addContentView];//增加内容
    
    self.imageArray = [NSMutableArray array];
    self.imgPicker = [[UIImagePickerController alloc] init];
    self.imgPicker.delegate = self;
     [self requestPersonalInfoFromServer];
    
}

#pragma amrk =====  从服务器获取个人信息 ============
- (void)requestPersonalInfoFromServer{
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    
    NSInteger uid = [[NSUserDefaults standardUserDefaults] integerForKey:@"key_ShortVersion"];
    
    NSString *userid = [[NSNumber numberWithInteger:uid] stringValue];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:userid forKey:@"id"];
    [self showHUD:nil];
    [[HTTPRequestManager sharedManager] POST:[NSString stringWithFormat:BaseUrl@"usergetUserIn"] params:dic result:^(id responseObj, NSError *error) {
        [self hideHUD];
        if ([responseObj[@"result"] intValue] == 0) {
            _model = [UserInformationModel initWithDictionary:responseObj];
            _dataSourceArray = [NSArray arrayWithObjects:_model.userName, _model.niCheng, _model.email, _model.phone, _model.address, _model.school, nil];
            
            _nickName = _dataSourceArray[1];
            _email = _dataSourceArray[2];
            _phoneNumber = _dataSourceArray[3];
            _address = _dataSourceArray[4];
            _school = _dataSourceArray[5];
            _aboutMe = _model.info;
            
            
            [_tableView reloadData];
        }else{
            [self showMessage:responseObj[@"message"]];
        }
    }];
    
}






-(void)addContentView{
    
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 64, KScrennWith, KScrennHeight - 64)];
    _tableView.backgroundColor = navBarColor(233.0, 233.0, 233.0);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [_tableView registerNib:[UINib nibWithNibName:@"PersonFirstCell" bundle:nil] forCellReuseIdentifier:@"firstCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"PersonCenterCell" bundle:nil] forCellReuseIdentifier:@"centerCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"PersonThirdCell" bundle:nil] forCellReuseIdentifier:@"thirdCell"];
    
}

-(void)initBaseNavigationRightBar{
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(KScrennWith -10 - 40, 20 + 5, 40, 30);
    [rightButton setTitle:@"保存" forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(saveAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];

}

#pragma mark =======保存  资料 =====================
- (void)saveAction{
    [self showHUD:@"正在保存"];
    AppDelegate *app =[UIApplication sharedApplication].delegate;
    NSMutableDictionary *pararm = [NSMutableDictionary dictionary];
    
    NSInteger uid = [[NSUserDefaults standardUserDefaults] integerForKey:@"key_ShortVersion"];
    
    NSString *userid = [[NSNumber numberWithInteger:uid] stringValue];
    
    [pararm setObject:userid forKey:@"id"];
    [pararm setObject:_nickName forKey:@"niCheng"];
    [pararm setObject:_email forKey:@"raemail"];
    [pararm setObject:_phoneNumber forKey:@"raphone"];
    [pararm setObject:_school forKey:@"school"];
    [pararm setObject:_aboutMe forKey:@"info"];
    [pararm setObject: _address forKey:@"address"];
    
    NSLog(@"修改个人资料的 params  %@", pararm);
    if (_imageArray.count > 0) {
        [self POSTImage:[NSString stringWithFormat:BaseUrl@"useruploadFile"]  params:nil image:_imageArray result:^(id responseObj, NSError *error) {
        }];
    }
    [[HTTPRequestManager sharedManager]POST:[NSString stringWithFormat:BaseUrl@"userupdateUserIn"] params:pararm result:^(id responseObj, NSError *error) {
    [self hideHUD];
        if ([responseObj[@"result"] intValue] == 0) {
            _lp = [[LPPopup alloc] initWithText:responseObj[@"message"]];
            [_lp showInView:self.view centerAtPoint:self.view.center duration:1 completion:^{
                [self.navigationController popToRootViewControllerAnimated:YES];
            }];
        }else{
            [self showHUD:responseObj[@"message"]];
        }
        
    }];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return _leftArray.count;
    }else{
        
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        PersonFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:@"firstCell"];
        [self changeLayerOfSomeControl: cell.userHeaderImageView];
        if (![_model.url isEqualToString:@""]) {
               [cell.userHeaderImageView sd_setImageWithURL:[NSURL URLWithString:_model.url]];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 1){
        PersonCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"centerCell"];
        cell.termLabel.text = _leftArray[indexPath.row];
        if (_dataSourceArray.count > 0) {
            cell.inputTF.text = _dataSourceArray[indexPath.row];
        }
        cell.inputTF.tag = indexPath.row;
        cell.inputTF.delegate = self;
        NSLog(@"tag = %ld", cell.inputTF.tag);
        if (indexPath.row == 0) {
            [cell.inputTF setEnabled:NO];
            cell.inputTF.textColor = [UIColor grayColor];
        }
        if (indexPath.row == 1) {
        }
        if (indexPath.row == 3) {
            cell.inputTF.keyboardType = UIKeyboardTypeNumberPad;
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        PersonThirdCell *cell = [tableView dequeueReusableCellWithIdentifier:@"thirdCell"];
        cell.bottomTextView.text = _model.info;
        cell.bottomTextView.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }

    
}

#pragma mark ==========  表视图 点击事件 ==================
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        _firstCell = [tableView cellForRowAtIndexPath:indexPath];
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"请选择操作" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相册", @"拍照", nil];
        sheet.tag = 1001;
        [sheet showInView:self.view];
    }
    
}


-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 70;
    }else if (indexPath.section == 1){
        return 42;
    }else{
        return 164;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 0;
    }else if (section == 1){
        
        return 5;
    }else{
        return 10;
        
    }
}


#pragma mark  ============= UITextFieldDelegate ============
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.tag == 1) {
        _nickName = textField.text;
    }
    if (textField.tag == 2) { //邮箱是否合法
        if (![self isValidateEmail:textField.text]) {
            textField.text = @"";
        }else{
            _email = textField.text;
        }
    }
    if (textField.tag == 3) {  // 手机是否合法
        if (![self isValidateMobile:textField.text]) {
            textField.text = @"";
        }else{
            _phoneNumber = textField.text;
        }
    }
    if (textField.tag == 4) { // 地址
        _address = textField.text;
    }
    if (textField.tag == 5) {
        _school = textField.text;
    }
}


#pragma mark  ========== UITextViewDelegate ============
- (void)textViewDidChange:(UITextView *)textView{
    NSLog(@"%@",textView);
    _aboutMe = textView.text;
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    if ([textView.text isEqualToString:@"关于我..."]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
        textView.font = [UIFont systemFontOfSize:14];
    }
    
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"关于我...";
        textView.textColor = [UIColor darkGrayColor];
        textView.font = [UIFont systemFontOfSize:17];
    }
}

#pragma mark ========= ActionSheetDelegate ==================
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


#pragma mark =====  图片选择器 代理 =====================

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        //先把图片转成NSData
        UIImage* image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        _firstCell.userHeaderImageView.image = image;
        
        if (image != nil) {
            self.userPhotoData = UIImageJPEGRepresentation(image, 0.1);
            _encodedImageStr = [NSString stringWithFormat:@"%@",self.userPhotoData];//进行64位转码转为字符串
        }
        
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
        [self.imageArray removeAllObjects];
        [self.imageArray addObject:image];
    }
    
}






#pragma mark ========== 上传图片的网络封装 ==================
- (void)POSTImage:(NSString *)url params:(id)params image:(NSArray *)image result:(ResultBlock)resultBlock
{
//   [self showHUD:@"正在上传..."];
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.requestSerializer = [AFHTTPRequestSerializer serializer];
    [mgr POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [self hideHUD];
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
            [formData appendPartWithFileData:iconData name:@"doc" fileName:[NSString stringWithFormat:@"photo.jpg"] mimeType:mimeType];
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //使用通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"topBtnClick" object:nil];
        [self hideHUD];
        NSLog(@"%@", responseObject);
        NSDictionary * dict = responseObject;
        if ([dict[@"result"] intValue] == 0) {
//            _lp = [[LPPopup alloc] initWithText:dict[@"message"]];
//            [_lp showInView:self.view centerAtPoint:self.view.center duration:1 completion:^{
//                [self.navigationController popToRootViewControllerAnimated:YES];
//            }];
        } else {
            [self showMessage:dict[@"message"]];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self hideHUD];
        NSLog(@"error == %@", error);
    }];
}




@end
