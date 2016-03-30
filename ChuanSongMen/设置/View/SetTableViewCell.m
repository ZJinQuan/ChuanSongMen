//
//  SetTableViewCell.m
//  ChuanSongMen
//
//  Created by apple on 15/9/13.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "SetTableViewCell.h"

@implementation SetTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        NSArray *arrays=[[NSBundle mainBundle] loadNibNamed:@"SetTableCell" owner:self options:nil];
        UIView *view=arrays[0];
        
        [self addSubview:view];
        
    }
    return self;
}


@end
