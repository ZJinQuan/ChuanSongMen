//
//  HeaderView.m
//  ChuanSongMen
//
//  Created by apple on 15/9/13.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "HeaderView.h"

@interface HeaderView ()

@property (strong, nonatomic) IBOutlet UIView *bgView;

@end


@implementation HeaderView

-(instancetype)initWithFrame:(CGRect)frame{

    self=[super initWithFrame:frame];
    
    if (self) {
        
        
        NSArray *arrays=[[NSBundle mainBundle] loadNibNamed:@"HeaderView" owner:self options:nil];
        UIView *view=arrays[0];
        self.bgView.frame=CGRectMake(0, 0, KScrennWith, 30);
        [self addSubview:view];
        
        
    }

    return self;
}

@end
