//
//  ZZPhotoPickerViewController.h
//  ZZFramework
//
//  Created by Yuan on 15/7/7.
//  Copyright (c) 2015年 zzl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"
#import "BaseViewController.h"

@interface ZZPhotoPickerViewController : BaseViewController


@property(strong,nonatomic) void (^PhotoResult)(id responseObject);

@property(assign,nonatomic) NSInteger selectNum;
@property(assign,nonatomic) BOOL isAlubSeclect;
@property(strong,nonatomic) PHFetchResult *fetch;

@property(assign,nonatomic) ZZImageType imageType;


@end
