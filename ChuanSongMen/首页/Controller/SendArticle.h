//
//  SendArticle.h
//  ChuanSongMen
//
//  Created by apple on 15/10/9.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "BaseViewController.h"

@interface SendArticle : BaseViewController
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (nonatomic, assign) NSInteger selectPublishStyle;
@property (nonatomic, strong) NSString *totalMoney;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *number;
@end
