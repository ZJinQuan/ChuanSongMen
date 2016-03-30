//
//  UIButton+UIButtonImageWithLable.m
//  chuansongmen
//
//  Created by apple on 15/9/6.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "UIButton+UIButtonImageWithLable.h"

@implementation UIButton (UIButtonImageWithLable)

- (void) setImage:(UIImage *)image withTitle:(NSString *)title forState:(UIControlState)stateType {
    
    //UIEdgeInsetsMake(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right)
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:10]};
    
    CGSize titleSize = [title sizeWithAttributes:attributes];
    
    [self.imageView setContentMode:UIViewContentModeCenter];
    
    [self setImageEdgeInsets:UIEdgeInsetsMake(-8.0,
                                              
                                              0,
                                              
                                              0.0,
                                              
                                              -titleSize.width)];
    
    [self setImage:image forState:stateType];
    
    
    
    [self.titleLabel setContentMode:UIViewContentModeCenter];
    
    [self.titleLabel setBackgroundColor:[UIColor clearColor]];
    
    [self.titleLabel setFont:[UIFont systemFontOfSize:10]];
    
    [self.titleLabel setTextColor:[UIColor blackColor]];
    
    [self setTitleEdgeInsets:UIEdgeInsetsMake(30.0,
                                              
                                              -image.size.width,
                                              
                                              0.0,
                                              
                                              0.0)];
    
    [self setTitle:title forState:stateType];
    
}

//主页按钮
- (void) setImage1:(UIImage *)image withTitle:(NSString *)title forState:(UIControlState)stateType {
    
    //UIEdgeInsetsMake(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right)
    
    
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:12]};
    
    CGSize titleSize = [title sizeWithAttributes:attributes];
    [self.imageView setContentMode:UIViewContentModeCenter];
    
    [self setImageEdgeInsets:UIEdgeInsetsMake(-8.0,
                                              
                                              0,
                                              
                                              0.0,
                                              
                                              -titleSize.width)];
    
    [self setImage:image forState:stateType];
    
    
    
    [self.titleLabel setContentMode:UIViewContentModeCenter];
    
    [self.titleLabel setBackgroundColor:[UIColor clearColor]];
    
    [self.titleLabel setFont:[UIFont systemFontOfSize:12]];
    
    [self.titleLabel setTextColor:[UIColor blackColor]];
    
    [self setTitleEdgeInsets:UIEdgeInsetsMake(30.0,
                                              
                                              -image.size.width,
                                              
                                              0.0,
                                              
                                              0.0)];
    
    [self setTitle:title forState:stateType];
    
}


//主页按钮
- (void) setImage2:(UIImage *)image withTitle:(NSString *)title forState:(UIControlState)stateType {
    
    //UIEdgeInsetsMake(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right)
    
    
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:12]};
    
    CGSize titleSize = [title sizeWithAttributes:attributes];
    [self.imageView setContentMode:UIViewContentModeCenter];
    
    [self setImageEdgeInsets:UIEdgeInsetsMake(-8.0,
                                              
                                              -30.0,
                                              
                                              0.0,
                                              
                                              -titleSize.width)];
    
    [self setImage:image forState:stateType];
    
    
    
    [self.titleLabel setContentMode:UIViewContentModeCenter];
    
    [self.titleLabel setBackgroundColor:[UIColor clearColor]];
    
    [self.titleLabel setFont:[UIFont systemFontOfSize:12]];
    
    [self.titleLabel setTextColor:[UIColor blackColor]];
    
    [self setTitleEdgeInsets:UIEdgeInsetsMake(-8.0,
                                              
                                              5.0,
                                              
                                              0.0,
                                              
                                              0.0)];
    
    [self setTitle:title forState:stateType];
    
}



@end
