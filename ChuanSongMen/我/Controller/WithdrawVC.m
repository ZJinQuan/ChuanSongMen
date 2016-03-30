//
//  WithdrawVC.m
//  ChuanSongMen
//
//  Created by apple on 16/3/7.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "WithdrawVC.h"
#import "PublishCell.h"
@interface WithdrawVC ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
@property (nonatomic, strong) NSArray *imagesArray;
@property (nonatomic, strong) NSArray *titlesArray;
@property (nonatomic, strong) NSArray *subTitlesArray;
@property (nonatomic, assign) NSInteger selectPublishStyle;
@end

@implementation WithdrawVC

- (void)viewDidLoad {
    [super viewDidLoad];
   self.titleLable.text = @"余额提现";
    [self changeLayerOfSomeControl:_nextButton];
    
 self.imagesArray = [NSArray arrayWithObjects:@"zhifubao", @"悬赏", @"pay_yinlian", nil];
 self.titlesArray = [NSArray arrayWithObjects:@"支付宝客户端", @"微信支付", @"银行卡支付", nil];
 self.subTitlesArray = [NSArray arrayWithObjects:@"推荐安装支付宝客户端的用户使用", @"推荐安装微信5.0以上版本使用", @"支付银联快捷方式", nil];


    [self.tableView registerNib:[UINib nibWithNibName:@"PublishCell" bundle:nil] forCellReuseIdentifier:@"PublishCell"];
    self.tableView.rowHeight = 80;
}


- (void)initBaseNavigationRightBar{
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(KScrennWith - 100, 25, 100, 30);
    rightButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [rightButton setTitle:@"提现记录" forState:UIControlStateNormal];
    rightButton.titleLabel.textAlignment = NSTextAlignmentRight;
    [rightButton addTarget:self action:@selector(recordAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
}


#pragma mark ==========提现记录 ============
- (void)recordAction{
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PublishCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PublishCell"];
    cell.leftImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", self.imagesArray[indexPath.row]]];
    cell.titleLabel.text = self.titlesArray[indexPath.row];
    cell.subTitleLabel.text  = self.subTitlesArray[indexPath.row];
    cell.rightImageView.image = [UIImage imageNamed:@"unchecked"];
    return cell;
    
};



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PublishCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.rightImageView.image = [UIImage imageNamed:@"xuan"];
    for (int i = 0; i < self.titlesArray.count; i++) {
        if (i != indexPath.row) {
            NSIndexPath *indexPaths = [NSIndexPath indexPathForRow:i inSection:0];
            PublishCell *cell = [tableView cellForRowAtIndexPath:indexPaths];
            cell.rightImageView.image = [UIImage imageNamed:@"unchecked"];
        }
    }
    
    if (indexPath.row == 0) {
        self.selectPublishStyle = 0;
    }
    if (indexPath.row == 1) {
        self.selectPublishStyle = 1;
    }
    if (indexPath.row == 2) {
        self.selectPublishStyle = 2;
    }
    

    
    
}


#pragma mark ========下一步操作 ==================================
- (IBAction)nextAction:(UIButton *)sender {
    if (self.selectPublishStyle == 0) { //支付宝客户端
        
    }else if(self.selectPublishStyle == 1) { //微信支付
        
    }else{ //银行卡支付
        
    }
    


}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
















@end
