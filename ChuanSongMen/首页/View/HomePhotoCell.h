//
//  HomePhotoCell.h
//  ChuanSongMen
//
//  Created by femtoapp's macbook pro  on 16/3/10.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageModel.h"
@interface HomePhotoCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewHeight;

@property (nonatomic, strong) NSString *urlString;
@property (nonatomic, strong) ImageModel *model;

@property (nonatomic,strong) UIImageView *pictureView;

+ (CGSize)collectionViewHeight:(ImageModel *)model;




@end
