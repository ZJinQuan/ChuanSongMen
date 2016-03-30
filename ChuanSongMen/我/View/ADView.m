//
//  ADView.m
//  ChuanSongMen
//
//  Created by apple on 15/9/23.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "ADView.h"

@implementation ADView

-(instancetype)initWithFrame:(CGRect)frame{


    self=[super initWithFrame:frame];
    if (self) {
        
        UIView *view=[[[NSBundle mainBundle] loadNibNamed:@"ADView" owner:self options:nil] lastObject];
        view.frame=CGRectMake(0, 0, KScrennWith, KScrennHeight/2-30);
        [self addSubview:view];
        
    }
    return self;
}

@end
