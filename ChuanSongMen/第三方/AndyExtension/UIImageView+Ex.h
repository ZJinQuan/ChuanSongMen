//
//  UIImageView+Ex.h
//

#import <UIKit/UIKit.h>

@interface UIImageView (Ex)

//-------------------------------------------------------
//设置圆图
- (void)isCornerRadius;

//-------------------------------------------------------
//抛物线动画
-(void)parabolaToPoint:(CGPoint)point;
-(void)parabolaToPoint:(CGPoint)point scaleTo:(float)scale;

@end
