//
//  NoticeView.m
//  chuansongmen
//
//  Created by apple on 15/9/8.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "NoticeView.h"
#import "UIUtils.h"
#import "NoticeTableViewCell.h"
#import "NoticeSecondTableViewCell.h"

@interface NoticeView ()<UITableViewDataSource,UITableViewDelegate>
{
    
    UITableView *_tableView;
    
    NSArray *_tableData;
    
}
@end

@implementation NoticeView
-(instancetype)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    if (self) {
        [self addContentView];
    }
    
    
    return self;
}


-(void)addContentView{
    
    [self addTableView];
    

    
}
//增加表视图
-(void)addTableView{
    
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIUtils getWindowWidth], [UIUtils getWindowHeight]-20-40-47) style:UITableViewStylePlain];
    
    _tableView.delegate=self;
    _tableView.dataSource=self;
    // _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_tableView];
    
}

#pragma mark UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section==0){
        if (indexPath.row==0) {
            return 80;
        }
    
    }
    
    return 160;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 30;

}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIUtils getWindowWidth], 20)];
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(10, 10, [UIUtils getWindowWidth]-10, 15)];
    label.font=[UIFont systemFontOfSize:14];
    if (section==0) {
        label.text=@"加好友请求";
        [view addSubview:label];
        
        return view;
    }else{
    label.text=@"推荐";
        [view addSubview:label];
        return view;
    
    }
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }else{
    
        return 1;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        
        
        static NSString *cellIr=@"cellIr";
        NoticeTableViewCell *cell1=[tableView dequeueReusableCellWithIdentifier:cellIr];
        if (!cell1) {
            cell1=[[NoticeTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIr];
            
        }
        
        return cell1;
    }else{
    static NSString *cellIdentifier=@"cellIdentifier";
    NoticeSecondTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell=[[NoticeSecondTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        
    }
    
    return cell;
        }
}

@end
