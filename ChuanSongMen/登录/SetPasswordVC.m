//
//  SetPasswordVC.m
//  ChuanSongMen
//
//  Created by femtoapp's macbook pro  on 16/3/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "SetPasswordVC.h"
#import "SetUserNameVC.h"
@interface SetPasswordVC ()
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@end

@implementation SetPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self changeLayerOfSomeControl:self.nextButton];
    [self changeBorderOfSomeControl:self.nextButton borderColor:[UIColor lightGrayColor] borderWidth:1];
    
    

}
- (IBAction)nextAction:(UIButton *)sender {
    SetUserNameVC *setUserNameVC = [[SetUserNameVC alloc] initWithNibName:@"SetUserNameVC" bundle:nil];
    setUserNameVC.password = self.passwordTF.text;
    [self.pararm setObject:self.passwordTF.text forKey:@"user.passWord"];
    NSLog(@"%@", self.pararm);
    setUserNameVC.pararm = self.pararm;
    [self showViewController:setUserNameVC sender:self];
    
    
}

- (IBAction)backAction:(UIButton *)sender {
    [self dismissModalViewControllerAnimated:YES];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

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
