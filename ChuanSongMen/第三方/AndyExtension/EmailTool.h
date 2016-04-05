//
//  EmailTool.h
//  BuyAi
//
//  Created by apple on 15/12/14.
//  Copyright © 2015年 femto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MessageUI/MessageUI.h>

@interface EmailTool : NSObject
+(instancetype)shareEmailTool;
- (void)displayMailPickerWithVC:(UIViewController *)vc;
@end
