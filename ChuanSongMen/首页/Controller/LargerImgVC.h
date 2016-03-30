//
//  LargerImgVC.h
//  BlueClient
//
//  Created by femtoapp's macbook pro  on 16/1/13.
//  Copyright © 2016年 马远征. All rights reserved.
//

#import "BaseViewController.h"
@interface LargerImgVC : BaseViewController
/**
 数据,里面存的是模型
 */
@property (nonatomic, strong) NSArray * imgDataArr;
/**
 当前显示第几张
 */
@property (nonatomic,assign) NSInteger currentIndex;
@end
