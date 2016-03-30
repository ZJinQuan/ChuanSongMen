//
//  SearchViewController.m
//  ChuanSongMen
//
//  Created by FemtoappMacpro15 on 16/3/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchResultVC.h"
#import "SearchHistoryCell.h"
#import "DataBaseHelper.h"
@interface SearchViewController ()<UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;

@property (weak, nonatomic) IBOutlet UITableView *tableView;



@property (nonatomic, strong) NSMutableArray *friendArray;
@property (nonatomic, strong) NSMutableArray *articleArray;
@property (nonatomic, strong) NSMutableArray *searchHistoryArray;

@property (nonatomic, strong) NSArray *resultArray;
@property (nonatomic, strong) DataBaseHelper *helper;
@property (nonatomic, assign) int searchID;
@end

@implementation SearchViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    
   _resultArray =  [[[NSUserDefaults standardUserDefaults]objectForKey:@"searchHistory"] copy];
    NSLog(@"%@", _resultArray);
    
    self.searchID = [[[NSUserDefaults standardUserDefaults]objectForKey:@"searchID"] intValue];
}


- (IBAction)cancleAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self changeLayerOfSomeControl:self.topView];
    self.searchTextField.delegate = self;
//    
    self.helper = [DataBaseHelper shareDataBaseHelper];
//    self.searchHistoryArray = [self.helper querySearchInfo];
//

    self.articleArray =[NSMutableArray array];
    self.friendArray = [NSMutableArray array];

    
    
//    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstStart"]){
//        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstStart"];
//        //是第一次启动
//       [[NSUserDefaults standardUserDefaults] setObject:_searchHistoryArray  forKey:@"searchHistory"];
//    }else{
//        NSLog(@"不是第一次启动");
//    }
    
    
 
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SearchHistoryCell" bundle:nil] forCellReuseIdentifier:@"historyCell"];
//    self.tableView.dataSource = self;
//    self.tableView.delegate = self;
    
}





-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.text.length < 1) {
        [self showMessage:@"搜索内容不能为空"];
    }else{
    [textField resignFirstResponder];
        
        
//       NSMutableArray *array = [[NSUserDefaults standardUserDefaults]objectForKey:@"searchHistory"];
//        [array addObject:self.searchTextField.text];
//        [[NSUserDefaults standardUserDefaults] setObject:array  forKey:@"searchHistory"];
        
        
        
        [self.articleArray removeAllObjects];
        [self.friendArray removeAllObjects];
        
        AppDelegate *app = [UIApplication sharedApplication].delegate;
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:app.userId forKey:@"userId"];
        [params setObject:textField.text forKey:@"condition"];
        self.searchID += 1;
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:self.searchID] forKey:@"searchID"];
        
        //插入数据
//        [self.helper insertSearchID:self.searchID Result:textField.text];
        
        
    [[HTTPRequestManager sharedManager] POST:[NSString stringWithFormat:BaseUrl@"userlookupFriend"] params:params result:^(id responseObj, NSError *error) {
        if ([responseObj[@"result"] intValue] == 0) {
            
            for (NSDictionary *dic in responseObj[@"msg"]) {
                 if ([[dic allKeys] containsObject:@"atten"]) {
                     [self.friendArray addObject:dic];
                 }else{
                     [self.articleArray addObject:dic];
                 }
            }
            SearchResultVC *searchVC = [[SearchResultVC alloc] initWithNibName:@"SearchResultVC" bundle:nil];
            searchVC.friendsDataSourceArray = self.friendArray;
            searchVC.articleDataSourceArray = self.articleArray;
            searchVC.searchInfo = self.searchTextField.text;
            searchVC.navi =self.navigationController;
            [self.navigationController pushViewController:searchVC animated:YES];
        }else{

            SearchResultVC *searchVC = [[SearchResultVC alloc] initWithNibName:@"SearchResultVC" bundle:nil];
             searchVC.searchInfo = self.searchTextField.text;
                        searchVC.navi =self.navigationController;
              [self.navigationController pushViewController:searchVC animated:YES];
        }
        
    }];
        
    }
    return YES; // 小二
}




//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    
//    return self.searchHistoryArray.count;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    SearchHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"historyCell"];
//    
//    cell.titleLabel.text  = self.searchHistoryArray[indexPath.row];
//    return cell;
//
//}








- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

    
}



@end
