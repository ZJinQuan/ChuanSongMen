//
//  AddShareImage.m
//  ChuanSongMen
//
//  Created by QUAN on 16/4/12.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "AddShareImage.h"

@implementation AddShareImage

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self = [[[NSBundle mainBundle] loadNibNamed:@"AddShareImage" owner:self options:nil] lastObject];
        
    }
    return self;
}

@end
