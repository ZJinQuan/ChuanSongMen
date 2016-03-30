//
//  RegisterByEmailVC.m
//  ChuanSongMen
//
//  Created by femtoapp's macbook pro  on 16/3/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "RegisterByEmailVC.h"
#import "SetPasswordVC.h"
@interface RegisterByEmailVC ()
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UITextField *emailTF;
@property (nonatomic, strong) NSMutableDictionary *pararm;
@end

@implementation RegisterByEmailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self changeLayerOfSomeControl:self.nextButton];
    [self changeBorderOfSomeControl:self.nextButton borderColor:[UIColor lightGrayColor] borderWidth:1];
    self.pararm = [NSMutableDictionary dictionary];
}
- (IBAction)phoneRegisterAction:(UIButton *)sender {
[self dismissModalViewControllerAnimated:YES];
}

- (IBAction)nextAction:(UIButton *)sender {
    if (![self isValidateEmail:self.emailTF.text]) {
        [self showMessage:@"请输入合法邮箱"];
    }else{
        
        [self.pararm removeAllObjects];
        [self.pararm setObject:self.emailTF.text forKey:@"user.name"];
        
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"regisgterByEmail" object:self.emailTF.text];
        SetPasswordVC *passVC = [[SetPasswordVC alloc] initWithNibName:@"SetPasswordVC" bundle:nil];
        
        passVC.pararm = self.pararm;
        [self showViewController:passVC sender:self];

    }
    

}

- (IBAction)backAction:(UIButton *)sender {
//    [self.navigationController popViewControllerAnimated:YES];
    [self dismissModalViewControllerAnimated:YES];
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
