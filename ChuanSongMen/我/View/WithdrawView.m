//
//  WithdrawView.m
//  ChuanSongMen
//
//  Created by apple on 15/9/22.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "WithdrawView.h"
#import "UIUtils.h"

@implementation WithdrawView

-(instancetype)initWithFrame:(CGRect)frame{

    self=[super initWithFrame:frame];
    if (self) {
        
        UIView *view=[[[NSBundle mainBundle] loadNibNamed:@"WithdrawView" owner:self options:nil] lastObject];
        view.frame=CGRectMake(0, 0, [UIUtils getWindowWidth], [UIUtils getWindowHeight]);
        [self addSubview:view];
        
        
    }
    return self;

}
@end
