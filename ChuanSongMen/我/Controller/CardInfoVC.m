//
//  CardInfoVC.m
//  ChuanSongMen
//
//  Created by apple on 16/3/7.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CardInfoVC.h"
#import "CardInfoCell.h"
#import "CardNumberCell.h"
#import "PayMoneyVC.h"
@interface CardInfoVC () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIButton *agreeButton;

@property (weak, nonatomic) IBOutlet UIButton *nextButton;


@end

@implementation CardInfoVC

#pragma mark ====下一步操作 ============
- (IBAction)nextAction:(UIButton *)sender {
    PayMoneyVC *payMoneyVC = [[PayMoneyVC alloc] initWithNibName:@"PayMoneyVC" bundle:nil];
    [self.navigationController pushViewController:payMoneyVC animated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLable.text =  @"银行卡";
    [self changeLayerOfSomeControl:self.nextButton];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CardInfoCell" bundle:nil] forCellReuseIdentifier:@"cardInfoCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CardNumberCell" bundle:nil] forCellReuseIdentifier:@"numberCell"];
    _tableView.rowHeight = 35;
    

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 2) {
        CardNumberCell *cell = [tableView dequeueReusableCellWithIdentifier:@"numberCell"];
        return  cell;
    }else{
    CardInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cardInfoCell"];
    cell.InfotextField.delegate = self;
    cell.InfotextField.tag = 1000 + indexPath.row;
        if (indexPath.row == 0) {
            cell.InfotextField.placeholder = @"储蓄卡卡号";
            cell.InfotextField.keyboardType = UIKeyboardTypeNumberPad;
        }
        if (indexPath.row == 1) {
            cell.InfotextField.placeholder = @"姓名";
        }
        if (indexPath.row == 3) {
            cell.InfotextField.placeholder = @"证件号";
        }
        if (indexPath.row == 4) {
            cell.InfotextField.placeholder = @"银行预留手机号";
            cell.InfotextField.keyboardType = UIKeyboardTypeNumberPad;
        }
        
        
        
        return  cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}



- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField.tag == 1000) {
        
    }
    if (textField.tag == 1001) {
        
    }
    if (textField.tag == 1003) {
        
    }
    if (textField.tag == 1004) {
        
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.tag == 1000) {
        
    }
    if (textField.tag == 1001) {
        
    }
    if (textField.tag == 1003) {
        
    }
    if (textField.tag == 1004) {
        
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end
