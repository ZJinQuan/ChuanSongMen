//
//  RegisterViewController.m
//  ChuanSongMen
//
//  Created by femtoapp's macbook pro  on 16/3/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegisterByEmailVC.h"
#import "SetPasswordVC.h"
@interface RegisterViewController ()


@property (weak, nonatomic) IBOutlet UITextField *phoneTF;

@property (weak, nonatomic) IBOutlet UITextField *authenTF;

@property (weak, nonatomic) IBOutlet UIButton *authenButton;

@property (weak, nonatomic) IBOutlet UIButton *nextStepButton;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger time;
@property (nonatomic, strong) NSMutableDictionary *pararm;

@end

@implementation RegisterViewController
- (IBAction)ahthenAction:(UIButton *)sender {
    if (self.phoneTF.text.length < 1) {
        [self showMessage:@"请输入手机号"];
    }else if(![self isValidateMobile:self.phoneTF.text]){
        [self showMessage:@"请输入合法的手机号"];
    }else{
        // MARK: 获取验证码
        NSMutableDictionary * paramas = [NSMutableDictionary dictionary];
        [paramas setObject:self.phoneTF.text  forKey:@"user.name"];
        [[HTTPRequestManager sharedManager] POST:[NSString stringWithFormat:BaseUrl@"usersendCode"] params:paramas result:^(id responseObj, NSError *error) {
            NSDictionary *response = responseObj;
            [self showMessage:responseObj[@"message"]];
            if ([[response objectForKey:@"result"]intValue] == 0) {
                sender.userInteractionEnabled = NO;
                sender.selected = YES;
                self.time = 45;
                [self.authenButton setTitle:[NSString stringWithFormat:@"(%zd)已发送",self.time] forState:UIControlStateNormal];
                self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(changeSendBtnTex) userInfo:nil repeats:YES];
                [self.timer fire];
            }
            
        }];
    }
}

// 改变发送验证码按钮的时间
- (void)changeSendBtnTex{
    self.time --;
    [self.authenButton setTitle:[NSString stringWithFormat:@"(%zd)已发送",self.time] forState:UIControlStateNormal];
    if (self.time == -1) {
        self.authenButton.userInteractionEnabled = YES;
        self.authenButton.selected = NO;
        [self.authenButton setTitle:@"重新发送" forState:UIControlStateNormal];
        [self.timer invalidate];
    }
}


- (IBAction)emailButton:(UIButton *)sender {
    RegisterByEmailVC *emailVC = [[RegisterByEmailVC alloc] initWithNibName:@"RegisterByEmailVC" bundle:nil];
//    [self.navigationController pushViewController:emailVC animated:YES];
    [self showViewController:emailVC sender:self];
    
}
- (IBAction)nextStepAction:(UIButton *)sender {
    if (self.phoneTF.text.length < 1) {
        [self showMessage:@"请输入手机号"];
    }else if (self.authenTF.text.length < 1){
        [self showMessage:@"请输入验证码"];
    }else if(![self isValidateMobile:self.phoneTF.text]){
        [self showMessage:@"请输入合法的手机号"];
    }else{
        NSArray *array = [NSArray arrayWithObjects:self.phoneTF.text, self.authenTF.text ,nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"transmit" object:array];
        
        [self.pararm removeAllObjects];
        [self.pararm setObject:self.phoneTF.text forKey:@"user.name"];
        [self.pararm setObject:self.authenTF.text forKey:@"code"];
        
        
        SetPasswordVC *passVC = [[SetPasswordVC alloc] initWithNibName:@"SetPasswordVC" bundle:nil];
        passVC.pararm = self.pararm;
        [self showViewController:passVC sender:self];
        
        
    }
}

- (IBAction)backAction:(UIButton *)sender {
    [self dismissModalViewControllerAnimated:YES];
}




- (void)viewDidLoad {
    [super viewDidLoad];
    [self changeSomeControlLayerValue];
    
    self.pararm = [NSMutableDictionary dictionary];
    
}



#pragma mark ========改变控件的layer 属性 ================
-(void)changeSomeControlLayerValue{
    [self changeLayerOfSomeControl:self.authenButton];
    [self changeLayerOfSomeControl:self.nextStepButton];
    [self changeBorderOfSomeControl:self.authenButton borderColor:[UIColor lightGrayColor] borderWidth:1];
    [self changeBorderOfSomeControl:self.nextStepButton borderColor:[UIColor lightGrayColor] borderWidth:1];
}



//删除定时
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.timer  invalidate];
    self.timer = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
