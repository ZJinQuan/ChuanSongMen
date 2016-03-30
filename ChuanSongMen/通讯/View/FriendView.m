//
//  FriendView.m
//  chuansongmen
//
//  Created by apple on 15/9/8.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "FriendView.h"
#import "UIUtils.h"

#import "FriendTableViewCell.h"

@interface FriendView ()<UITableViewDataSource,UITableViewDelegate>
{

    UITableView *_tableView;

    NSArray *_tableData;

}
@end

@implementation FriendView

-(instancetype)initWithFrame:(CGRect)frame{

    self=[super initWithFrame:frame];
    if (self) {
        [self addContentView];
    }


    return self;
}


-(void)addContentView{

    [self addTableView];
    
    [self tableData];

}


-(void)tableData{
    
    _tableData=@[
                 @{@"image":@"转发.png",@"title":@"AnnaBlum",@"text":@"@shanghai",@"image1":@"follow.png",@"image2":@"communication_btn_add1.png"},
                 @{@"image":@"转发.png",@"title":@"Jack",@"text":@"@shanghai",@"image1":@"follow.png",@"image2":@"communication_btn_add1.png"},
                 @{@"image":@"转发.png",@"title":@"AnnaBlum",@"text":@"@shanghai",@"image1":@"follow.png",@"image2":@"communication_btn_add1.png"}
                 ,
                 @{@"image":@"转发.png",@"title":@"Jack",@"text":@"@shanghai2",@"image1":@"follow.png",@"image2":@"communication_btn_add1.png"},
                 @{@"image":@"转发.png",@"title":@"Jack",@"text":@"22",@"image1":@"follow.png",@"image2":@"communication_btn_add1.png"}
                 ,
                 @{@"image":@"转发.png",@"title":@"AnnaBlum",@"text":@"666666622",@"image1":@"follow.png",@"image2":@"communication_btn_add1.png"},
                 @{@"image":@"转发.png",@"title":@"Jack",@"text":@"56622",@"image1":@"follow.png",@"image2":@"communication_btn_add1.png"}
                 ,
                 @{@"image":@"转发.png",@"title":@"Jack",@"text":@"5622",@"image1":@"follow.png",@"image2":@"communication_btn_add1.png"},
                 @{@"image":@"转发.png",@"title":@"AnnaBlum",@"text":@"5666622",@"image1":@"follow.png",@"image2":@"communication_btn_add1.png"}
                 ,
                 @{@"image":@"转发.png",@"title":@"Jack",@"text":@"56622",@"image1":@"follow.png",@"image2":@"communication_btn_add1.png"}
                 ];
}



//增加表视图
-(void)addTableView{
    
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIUtils getWindowWidth], [UIUtils getWindowHeight]-20-40-47) style:UITableViewStylePlain];
    
    _tableView.delegate=self;
    _tableView.dataSource=self;
   // _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor=[UIColor yellowColor];
    [self addSubview:_tableView];
    
}

#pragma mark UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{


    return 80;

}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier=@"cellIdentifier";
    FriendTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell=[[FriendTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        
    }
    
    [cell setCOntentView:_tableData[indexPath.row]];
    
    return cell;
}


@end
