//
//  MyCollectionCell.h
//  ChuanSongMen
//
//  Created by femtoapp's macbook pro  on 16/3/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCollectionCell : UICollectionViewCell<UITableViewDataSource, UITableViewDelegate>


@property (weak, nonatomic) IBOutlet UITableView *tableView;



@end
