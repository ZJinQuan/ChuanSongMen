//
//  PayMoneyVC.m
//  ChuanSongMen
//
//  Created by apple on 16/3/7.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "PayMoneyVC.h"

@interface PayMoneyVC ()
@property (weak, nonatomic) IBOutlet UIButton *authenButton;
@property (weak, nonatomic) IBOutlet UIView *middleView;
@property (weak, nonatomic) IBOutlet UIButton *payButton;
@property (weak, nonatomic) IBOutlet UITextField *authenTF;

@end

@implementation PayMoneyVC

- (void)viewDidLoad {
    [super viewDidLoad];
   self.titleLable.text = @"银行卡";
    [self changeLayerOfSomeControl:self.payButton];
    [self changeLayerOfSomeControl:self.authenButton];
    [self changeLayerOfSomeControl:self.middleView];
}

#pragma  mark ============= 获取验证码 ===========
- (IBAction)authenAction:(UIButton *)sender {
}


#pragma  mark ============= 立即付款 ===========
- (IBAction)payAction:(UIButton *)sender {
    
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
