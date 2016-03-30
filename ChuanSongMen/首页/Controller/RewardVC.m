//
//  RewardVC.m
//  ChuanSongMen
//
//  Created by apple on 16/2/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "RewardVC.h"
#import "SendArticle.h"
#import "advertisementVC.h"
@interface RewardVC ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *topTF;
@property (weak, nonatomic) IBOutlet UITextField *middleTF;
@property (weak, nonatomic) IBOutlet UIButton *nextStepButton;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

@end

@implementation RewardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLable.text = @"悬赏金额";
    self.middleTF.delegate = self;
    [self changeLayerOfSomeControl:self.nextStepButton];
    

}
#pragma mark ========下一步  =======-=-=-=-=-=-=-=-=-=
- (IBAction)nextSrepAction:(UIButton *)sender {
    if (self.topTF.text.length < 1) {
        [self showMessage:@"请输入分享次数"];
    }else if (self.middleTF.text.length < 1){
        [self showMessage:@"请输入悬赏金额"];
    }else if ([self isValidityOfTheText:self.middleTF]) {
        [self showMessage:@"请输入合法值"];
    }else{
        if (self.selectPublishStyle == 1) {
            SendArticle *sendArticlePage=[[SendArticle alloc] init];
            sendArticlePage.selectPublishStyle = self.selectPublishStyle;
            sendArticlePage.totalMoney = _moneyLabel.text;
            sendArticlePage.price = _middleTF.text;
            sendArticlePage.number = _topTF.text;
            [self.navigationController pushViewController:sendArticlePage animated:YES];
        }else{
            advertisementVC *adVC = [[advertisementVC alloc] initWithNibName:@"advertisementVC" bundle:nil];
            adVC.totalMoney = _moneyLabel.text;
            adVC.price = _middleTF.text;
            adVC.number = _topTF.text;
            [self.navigationController pushViewController:adVC animated:YES];
        }
      
    }
    
}

/*判断是否输入是数字和小数点*/
- (BOOL)isValidityOfTheText:(UITextField *)textField{
    NSCharacterSet *disallowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789."] invertedSet];
    NSRange foundRange = [textField.text rangeOfCharacterFromSet:disallowedCharacters];
    BOOL isValidity = foundRange.location != NSNotFound;
    return isValidity;
}


- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if ([self isValidityOfTheText:textField]) {
        textField.text = @"";
    }else{
        if (_topTF.text.length > 0) {
            _moneyLabel.text = [NSString stringWithFormat:@"¥ %.2f", [_topTF.text floatValue] * [textField.text floatValue]];
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}









@end
