//
//  HomePhotoCell.m
//  ChuanSongMen
//
//  Created by femtoapp's macbook pro  on 16/3/10.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "HomePhotoCell.h"
#import "UIImageView+WebCache.h"
@implementation HomePhotoCell

- (void)awakeFromNib {
    
    self.pictureView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KScrennWith, _scrollView.frame.size.height)];
    [self.scrollView addSubview:self.pictureView];
    
    self.imageView.layer.cornerRadius = 5;
    self.imageView.layer.masksToBounds = YES;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.maximumZoomScale = 2;
    self.scrollView.minimumZoomScale = 0.5;

    UIPinchGestureRecognizer *pin = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(showThePicture:)];
    [self.scrollView addGestureRecognizer:pin];
    
}

- (void)showThePicture:(UIPinchGestureRecognizer *)gesture{
    gesture.view.transform = CGAffineTransformScale(gesture.view.transform, gesture.scale, gesture.scale);
    gesture.scale = 1.0;
}

- (void)setModel:(ImageModel *)model{
    _model = model;
     [self.pictureView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:BaseUrl@"%@", _model.url]]];
    if (self.pictureView.image != nil) {
        CGFloat scale = self.pictureView.image.size.height / self.pictureView.image.size.width;
        self.scrollViewHeight.constant = KScrennWith * scale;
        self.pictureView.frame = self.scrollView.bounds;
    }
    
}

//- (void)setUrlString:(NSString *)urlString{
//    _urlString = urlString;
//     [self.imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:BaseUrl@"%@", _urlString]]];
//    if (self.imageView.image != nil) {
//        CGFloat scale = self.imageView.image.size.height / self.imageView.image.size.width;
//        self.scrollViewHeight.constant = KScrennWith * scale;
//        self.imageView.frame = self.scrollView.bounds;
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"ItemSize" object:[NSNumber numberWithFloat:self.scrollView.frame.size.height]];
//    }
//
//}

@end
