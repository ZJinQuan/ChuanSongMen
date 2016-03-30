//
//  MyCollectionCell.m
//  ChuanSongMen
//
//  Created by femtoapp's macbook pro  on 16/3/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MyCollectionCell.h"
#import "HomePageCell.h"
@implementation MyCollectionCell

- (void)awakeFromNib {
    [_tableView registerNib:[UINib nibWithNibName:@"HomePageCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    _tableView.rowHeight = 345;
    _tableView.dataSource = self;
    _tableView.delegate = self;

}



- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomePageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    return cell;
}


-(void)layoutSubviews{
    [_tableView reloadData];
}


@end
