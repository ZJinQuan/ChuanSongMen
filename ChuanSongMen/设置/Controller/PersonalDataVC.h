//
//  PersonalDataVC.h
//  ChuanSongMen
//
//  Created by apple on 15/9/14.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface PersonalDataVC : BaseViewController
@property (nonatomic, strong) UIImagePickerController *imgPicker;
@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, strong) NSString *filePath;
@property (nonatomic, strong) NSData *userPhotoData;

@property (nonatomic, strong) LPPopup *lp;
@end


