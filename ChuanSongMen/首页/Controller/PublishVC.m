//
//  PublishVC.m
//  ChuanSongMen
//
//  Created by apple on 16/2/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "PublishVC.h"
#import "PublishCell.h"
#import "SendArticle.h"
#import "RewardVC.h"
@interface PublishVC ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *nextStepButton;
@property (nonatomic, strong) NSArray *imagesArray;
@property (nonatomic, strong) NSArray *titlesArray;
@property (nonatomic, strong) NSArray *subTitlesArray;
@property (nonatomic, assign) NSInteger selectPublishStyle;

@end

@implementation PublishVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
     self.titleLable.text = @"选择发布方式";
    [self changeLayerOfSomeControl:self.nextStepButton];
    
    self.imagesArray = [NSArray arrayWithObjects:@"免费", @"悬赏", @"guang", nil];
    self.titlesArray = [NSArray arrayWithObjects:@"普通发布", @"分享悬赏发布", @"广告位悬赏发布", nil];
    self.subTitlesArray = [NSArray arrayWithObjects:@"免费发布文章,与好友进行互动", @"设定赏金,有利于用户积极转发,获得赏金的用户5小时内不可删除您的文章", @"让用户积极的将您的广告图展示在他们的广告位,5小时不可更改", nil];
    [self.tableView registerNib:[UINib nibWithNibName:@"PublishCell" bundle:nil] forCellReuseIdentifier:@"PublishCell"];
    self.tableView.rowHeight = 80;
    


}
#pragma mark ========点击下一步操作
- (IBAction)nextStepAction:(UIButton *)sender {
    if (self.selectPublishStyle == 0) {
        SendArticle *sendArticlePage=[[SendArticle alloc] init];
        [self.navigationController pushViewController:sendArticlePage animated:YES];

    }
    if (self.selectPublishStyle == 1 || self.selectPublishStyle == 2) {
        RewardVC *rewardVc = [[RewardVC alloc] initWithNibName:@"RewardVC" bundle:nil];
        rewardVc.selectPublishStyle = self.selectPublishStyle;
        [self.navigationController pushViewController:rewardVc animated:YES];
    }
    
    
}

#pragma mark ====== UITableViewDataSource,, UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PublishCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PublishCell"];
    cell.leftImageView.image = [UIImage imageNamed:self.imagesArray[indexPath.row]];
    cell.titleLabel.text = self.titlesArray[indexPath.row];
    cell.subTitleLabel.text = self.subTitlesArray[indexPath.row];
    if (indexPath.row != 0) {
        cell.rightImageView.image = [UIImage imageNamed:@"unchecked"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
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
