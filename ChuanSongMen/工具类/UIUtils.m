//
//  UIUtils.m
//  旅拍1.0
//
//  Created by scsys on 15/7/6.
//  Copyright (c) 2015年 szdy. All rights reserved.
//

#import "UIUtils.h"

@implementation UIUtils

+(CGFloat)getWindowWidth{

    UIWindow *mainWindow=[UIApplication sharedApplication].windows[0];
    return mainWindow.frame.size.width;
   
}

+(CGFloat)getWindowHeight{

    UIWindow *mainWindow=[UIApplication sharedApplication].windows[0];
    return mainWindow.frame.size.height;

}

+(NSString *)getCurrentTime{

    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateTime=[formatter stringFromDate:[NSDate date]];
    
    return dateTime;

}



@end
