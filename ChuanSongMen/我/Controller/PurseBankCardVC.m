//
//  PurseBankCardVC.m
//  ChuanSongMen
//
//  Created by apple on 16/3/7.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "PurseBankCardVC.h"
#import "CardCell.h"

#import "BankCardVC.h"
@interface PurseBankCardVC ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end

@implementation PurseBankCardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLable.text = @"银行卡";
    [self changeBorderOfSomeControl:self.bottomView borderColor:[UIColor lightGrayColor] borderWidth:1];
    self.tableView.backgroundColor = RGB(245, 245, 245);
    
    [_tableView registerNib:[UINib nibWithNibName:@"CardCell" bundle:nil] forCellReuseIdentifier:@"cardCell"];
    _tableView.rowHeight = 130;
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addCord)];
    [self.bottomView addGestureRecognizer:tap];

}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionP{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CardCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cardCell"];
    cell.leftImageView.image = [UIImage imageNamed:@"info_btn_setup"];
    [self changeLayerOfSomeControl: cell.roundView];
    [self changeBorderOfSomeControl:cell.roundView borderColor:[UIColor lightGrayColor] borderWidth:1];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}




#pragma MARK =========添加银行卡 =================
- (void)addCord{
    
    BankCardVC *bankCardVC = [[BankCardVC alloc] init];
    [self.navigationController pushViewController:bankCardVC animated:YES];
}








- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
