//
//  BankCardVC.m
//  ChuanSongMen
//
//  Created by apple on 15/9/16.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "BankCardVC.h"

#import "Header.h"//中文索引头文件
#import "CardInfoVC.h"

@interface BankCardVC ()<UITableViewDataSource,UITableViewDelegate>
{

    //增加导航菜单
    UISegmentedControl *_segmentedControl;
    
    UITableView *_tableView;//添加下面表视图
    
    NSMutableDictionary *_dataMutableDictionary;//存放列表数据
    NSMutableArray *_keyMuArray;//存放索引


}
@end

@implementation BankCardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationController.navigationBar.translucent = YES;
    
    self.edgesForExtendedLayout=UIRectEdgeNone;
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self setNav];
    
    [self addTopView];//增加segment控件
    
    
    [self loadData];//数据
    [self addTableView];
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden=YES;
    


}

-(void)setNav{
    
    
    UILabel *titleLabel=[[UILabel alloc] initWithFrame:CGRectMake((KScrennWith-80)/2, 20+5, 80, 30)];
    titleLabel.text=@"选择银行";
    titleLabel.textAlignment=NSTextAlignmentCenter;
    titleLabel.font=[UIFont systemFontOfSize:18];
    titleLabel.textColor=[UIColor whiteColor];
    self.navigationItem.titleView=titleLabel;

    
    
    UIButton *leftButton=[UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame=CGRectMake(10, 20+5, 30, 30);
    [leftButton setImage:[UIImage imageNamed:@"nav_back.png"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(cancleButtonPress) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButton=[[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    self.navigationItem.leftBarButtonItem=leftBarButton;
    
}

-(void)addTopView{

    NSArray *segmentedData = [[NSArray alloc]initWithObjects:@"信用卡",@"储蓄卡",nil];
    _segmentedControl=[[UISegmentedControl alloc] initWithItems:segmentedData];
    _segmentedControl.frame=CGRectMake(40,10, KScrennWith-80, 30);
    _segmentedControl.tintColor=[UIColor colorWithRed:0.0/255 green:115.0/255 blue:179.0/255 alpha:1.0f];;
    
    _segmentedControl.selectedSegmentIndex=1;
    /*
     下面的代码实同正常状态和按下状态的属性控制,比如字体的大小和颜色等
     */
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:14],NSFontAttributeName,[UIColor blackColor], NSForegroundColorAttributeName, nil ];
    
    
    [_segmentedControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
    
    
    NSDictionary *highlightedAttributes = [NSDictionary dictionaryWithObject:[UIColor colorWithRed:0.0/255 green:115.0/255 blue:179.0/255 alpha:1.0f] forKey:NSForegroundColorAttributeName];
    
    [_segmentedControl setTitleTextAttributes:highlightedAttributes forState:UIControlStateHighlighted];
    
    //设置分段控件点击相应事件
    [_segmentedControl addTarget:self action:@selector(doSomethingInSegment:)forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:_segmentedControl];
    
    
}



-(void)loadData{
    
    NSString *path=[[NSBundle mainBundle] pathForResource:@"city" ofType:@"plist"];
    
    NSArray *citiesArray=[[NSArray alloc] initWithContentsOfFile:path];
    
    //生成对应的数组
    NSMutableDictionary *charesDictionary=[[NSMutableDictionary alloc] initWithCapacity:0];
    _keyMuArray=[[NSMutableArray alloc] initWithCapacity:0];
    for (char chares='a'; chares<='z'; chares++) {
        NSMutableArray *charesMuArray=[[NSMutableArray alloc] initWithCapacity:0];
        [charesDictionary setValue:charesMuArray forKey:[NSString stringWithFormat:@"%c",chares]];
        [_keyMuArray addObject:[NSString stringWithFormat:@"%c",chares]];
    }
    
    //遍历数据，把数据分类存放
    for (int i=0; i<citiesArray.count; i++) {
        // NSLog(@"%c", pinyinFirstLetter([citiesArray[i] characterAtIndex:0]));
        NSMutableArray *muArra=[charesDictionary objectForKey:[NSString stringWithFormat:@"%c",pinyinFirstLetter([citiesArray[i] characterAtIndex:0])]];//取出key对应的可变数组
        
        [muArra addObject:citiesArray[i]];//把当前对象添加到可变数组
    }
    
    //删除数组中为空的数组
    for (char charest='a'; charest<'z'; charest++) {
        NSMutableArray *muA=  [charesDictionary objectForKey:[NSString stringWithFormat:@"%c",charest]];
        if (muA.count==0) {
            [charesDictionary removeObjectForKey:[NSString stringWithFormat:@"%c",charest]];
            [_keyMuArray removeObject:[NSString stringWithFormat:@"%c",charest]];
        }
    }
    
    _dataMutableDictionary=charesDictionary;
    
}


-(void)addTableView{

    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_segmentedControl.frame)+5, KScrennWith, KScrennHeight-CGRectGetMaxY(_segmentedControl.frame)) style:UITableViewStylePlain];
    
    _tableView.dataSource=self;
    _tableView.delegate=self;
    
    _tableView.sectionIndexBackgroundColor=[UIColor clearColor];//清除索引背景色
    _tableView.sectionIndexColor=[UIColor orangeColor];
    
    [self.view addSubview:_tableView];


}




-(void)cancleButtonPress{

    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 菜单栏按钮点击方法
-(void)doSomethingInSegment:(UISegmentedControl *)Seg
{
    
    NSInteger Index = Seg.selectedSegmentIndex;
    
    switch (Index)
    {
        case 0:
            NSLog(@"0");
            break;
        case 1:
            NSLog(@"1");
            break;
        default:
            break;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//生成索引
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    
    
    return _keyMuArray;
    
}


#pragma mark UITableViewDelegate

#pragma mark 跳转到对应的银行卡界面
//跳转到对应的银行卡界面
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *array=[_dataMutableDictionary objectForKey:_keyMuArray[indexPath.section]];

    NSString *title =  array[indexPath.row];
    
    CardInfoVC *cardInfoVC = [[CardInfoVC alloc] initWithNibName:@"CardInfoVC" bundle:nil];
 
     cardInfoVC.cardTypeLabel.text = title;
    [self.navigationController pushViewController:cardInfoVC animated:YES];
    
    
    

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _keyMuArray.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 30;
    }else{
     return 0;
    }

}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section==0) {
        UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
        view.backgroundColor=navBarColor(248.0, 248.0, 248.0);
        UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(20, 0, view.frame.size.width-30, 30)];
        label.text=@"热门";
        label.font=[UIFont systemFontOfSize:14];
        [view addSubview:label];
        
        return view;

    }else{
    
    
        return nil;
    
    }
    
    
    
}

#pragma mark UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSArray *array=[_dataMutableDictionary objectForKey:_keyMuArray[section]];
    
    return array.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier=@"cellIdentifier";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    NSArray *array=[_dataMutableDictionary objectForKey:_keyMuArray[indexPath.section]];
    
    [cell.textLabel setText:array[indexPath.row]];
    cell.textLabel.font=[UIFont systemFontOfSize:14];
    
    return cell;
}


@end
