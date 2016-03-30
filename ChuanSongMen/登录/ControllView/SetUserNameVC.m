//
//  SetUserNameVC.m
//  ChuanSongMen
//
//  Created by femtoapp's macbook pro  on 16/3/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "SetUserNameVC.h"
#import "LoginViewController.h"
@interface SetUserNameVC ()

@property (weak, nonatomic) IBOutlet UIButton *completedButton;
@property (weak, nonatomic) IBOutlet UITextField *userNameTF;
@property (nonatomic, strong) NSString *phoneNumber;
@property (nonatomic, strong) NSString *authenCode;
@property (nonatomic, strong) NSString *emailName;
@property (nonatomic, assign) int registerStyle;
@property (nonatomic, strong) LPPopup *lp;

@end

@implementation SetUserNameVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
 
}

-(void)getPhoneAndAutheonCode:(NSNotification *)notification{
    if (notification != nil) {
        NSArray *ar = notification.object;
        self.phoneNumber = ar[0];
        self.authenCode = ar[1];
        self.registerStyle = 1;
    }
}

- (void)getEmail:(NSNotification *)notification{
    if (notification != nil) {
        self.emailName = notification.object;
        self.registerStyle = 2;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self changeLayerOfSomeControl:self.completedButton];
    [self changeBorderOfSomeControl:self.completedButton borderColor:[UIColor lightGrayColor] borderWidth:1];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getPhoneAndAutheonCode:) name:@"transmit" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getEmail:) name:@"regisgterByEmail" object:nil];
    self.lp = [[LPPopup alloc] init];
    
 
    
}
- (IBAction)backAction:(UIButton *)sender {
    [self dismissModalViewControllerAnimated:YES];
}



- (IBAction)firstNameButton:(UIButton *)sender {
    self.userNameTF.text  = sender.titleLabel.text;
}

- (IBAction)secondNameAciton:(UIButton *)sender {
    self.userNameTF.text  = sender.titleLabel.text;
}
- (IBAction)thirdNameAciton:(UIButton *)sender {
    self.userNameTF.text  = sender.titleLabel.text;
}

#pragma mark ========= 点击完成按钮, 进行注册 =================
- (IBAction)completedAction:(UIButton *)sender {
    NSLog(@" self.phoneNumber ==%@,\n self.authenCode == %@,\n  self.emailName%@", self.phoneNumber, self.authenCode, self.emailName);
    NSLog(@" registerStyle = %d", self.registerStyle);
  
    [self.pararm setObject:self.userNameTF.text forKey:@"user.userName"];
    NSLog(@"%@", self.pararm);
    
    NSString * str = [NSString stringWithFormat:BaseUrl@"userregist"];
    NSLog(@"%@", str);
    [[HTTPRequestManager sharedManager] POST:str params:self.pararm result:^(id responseObj, NSError *error) {
        if ([responseObj[@"result"] intValue] == 0) {
            
            LPPopup *popup = [LPPopup popupWithText:responseObj[@"message"]];
            popup.textColor = [UIColor blackColor];
            [popup showInView:self.view
                centerAtPoint:self.view.center
                     duration:1
                   completion:^{
                       LoginViewController *loginVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
                       NSArray *array = [NSArray arrayWithObjects:self.pararm[@"user.name"], self.pararm[@"user.passWord"] ,nil];
//                       [[NSNotificationCenter defaultCenter] postNotificationName:@"registerScuucess" object:array];
                if ([self.RegisterDelegate respondsToSelector:@selector(returnTheUsernameAndPassword:)]) {
                [self.RegisterDelegate returnTheUsernameAndPassword:array];
                    }
                [self showViewController:loginVC sender:self];
                   }];


        }else{
            [self showMessage:responseObj[@"message"]];
        }
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
