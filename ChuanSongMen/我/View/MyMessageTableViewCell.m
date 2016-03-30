//
//  MyMessageTableViewCell.m
//  chuansongmen
//
//  Created by apple on 15/9/6.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "MyMessageTableViewCell.h"

@implementation MyMessageTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addContentView];
        
    }
    
    return self;
}

-(void)addContentView{
    
    self.backgroundColor=[UIColor redColor];
}
@end
