//
//  SearchResultVC.h
//  ChuanSongMen
//
//  Created by FemtoappMacpro15 on 16/3/23.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BaseViewController.h"

@interface SearchResultVC : BaseViewController

@property (nonatomic, strong) NSMutableArray *friendsDataSourceArray;
@property (nonatomic, strong) NSMutableArray *articleDataSourceArray;
@property (nonatomic, strong) NSString *searchInfo;
@property (nonatomic, strong) UINavigationController *navi;
@end
