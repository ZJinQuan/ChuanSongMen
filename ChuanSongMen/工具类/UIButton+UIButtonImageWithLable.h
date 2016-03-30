//
//  UIButton+UIButtonImageWithLable.h
//  chuansongmen
//
//  Created by apple on 15/9/6.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (UIButtonImageWithLable)
- (void) setImage:(UIImage *)image withTitle:(NSString *)title forState:(UIControlState)stateType;
- (void) setImage1:(UIImage *)image withTitle:(NSString *)title forState:(UIControlState)stateType;
- (void) setImage2:(UIImage *)image withTitle:(NSString *)title forState:(UIControlState)stateType;
@end
