//
//  SearchFriendVC.m
//  ChuanSongMen
//
//  Created by apple on 16/3/17.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "SearchFriendVC.h"
#import "SearchFriendResultCell.h"
#import "UIButtonExtension.h"
@interface SearchFriendVC ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (nonatomic, strong) UITableView *tableView;


@end

@implementation SearchFriendVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)initBaseNavigationRightBar{
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.titleLabel.textColor = [UIColor blackColor];
    rightButton.frame = CGRectMake(KScrennWith -10 - 40, 20 + 5, 40, 30);
    [rightButton setTitle:@"查找" forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
}

- (void)searchAction{
    if (self.searchTextField.text.length < 1) {
        [self showMessage:@"请输入用户名"];
    }else{
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 114, KScrennWith, KScrennHeight - 114 - 49) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    [_tableView registerNib:[UINib nibWithNibName:@"SearchFriendResultCell" bundle:nil] forCellReuseIdentifier:@"SearchFriendCell"];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = 60;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SearchFriendResultCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchFriendCell"];
    
    [cell.addButton addTarget:self action:@selector(addFriendAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.addButton.row = indexPath.row;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


- (void)addFriendAction:(UIButtonExtension *)sender{

    NSLog(@"添加好友");
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
