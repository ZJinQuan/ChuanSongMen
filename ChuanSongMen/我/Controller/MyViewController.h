//
//  MyViewController.h
//  ChuanSongMen
//
//  Created by apple on 15/9/12.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "BaseViewController.h"
#import "HomePageCell.h"
#import "HomePageModel.h"
@interface MyViewController : BaseViewController
@property (nonatomic, strong) UIScrollView *bigScrollView;
@property (nonatomic, strong) UIScrollView *smallScrollView;
@property (nonatomic, strong) UITableView  *firstTableView;
@property (nonatomic, strong) UITableView  *secondTableView;
@property (nonatomic, strong) UITableView  *thirdTableView;


@property (nonatomic, strong) NSMutableArray *firstSourceArray;
@property (nonatomic, strong) NSMutableArray *secondSourceArray;
@property (nonatomic, strong) NSMutableArray *thirdSourceArray;

//@property (nonatomic, strong) UIView      *myMaskView;
//@property (nonatomic, strong) UIView      *bottomCommentView;
//@property (nonatomic, strong) UITextView  *commentTextView;
//@property (nonatomic, strong) UIButton    *sendButton;


@property (nonatomic, strong) HomePageCell  *homeCell;
@property (nonatomic, strong) HomePageModel *mainModel;



@end
