//
//  PhotosPreviewVC.h
//  ChuanSongMen
//
//  Created by apple on 16/3/9.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BaseViewController.h"

@interface PhotosPreviewVC : BaseViewController
@property (nonatomic, assign) NSInteger totalPhotoNumber;
@property (nonatomic, assign) int currentPhotoIndex;
@property (nonatomic, strong) NSMutableArray *imageArray;


@property (nonatomic, strong) UIScrollView * scrollViews;
@property (nonatomic, assign) CGFloat offSet;
@property (nonatomic, strong) NSMutableArray * dataArr;

@end
