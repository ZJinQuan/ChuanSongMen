//
//  UIImageView+Ex.m
//
#import <QuartzCore/QuartzCore.h>
#import "UIImageView+Ex.h"

@implementation UIImageView (Ex)

- (void)isCornerRadius {
    self.layer.cornerRadius = MAX(self.frame.size.height,self.frame.size.height)/2;
    self.layer.masksToBounds = YES;
}

-(void)parabolaToPoint:(CGPoint)point{
    [self.layer addAnimation:[self pathAnimationQuadCurveToPoint:point scaleTo:1] forKey:@"parabola"];
    self.center = point;
}
-(void)parabolaToPoint:(CGPoint)point scaleTo:(float)scale{
    [self.layer addAnimation:[self pathAnimationQuadCurveToPoint:point scaleTo:scale] forKey:@"parabola"];
    self.transform =CGAffineTransformMakeScale(scale, scale);
    self.center = point;
}

- (CAAnimation*)pathAnimationQuadCurveToPoint:(CGPoint )pt scaleTo:(float)sc;
{
    float duration = 1.0;
    
    CGPoint orignal =  self.center;
    CGPoint focus = CGPointZero;
    CGPoint symPoint = CGPointZero;
    CGPoint destPoint = pt;
    focus.x = orignal.x + (destPoint.x - orignal.x)/2;
    focus.y = orignal.y - (destPoint.y - orignal.y);
    
    symPoint.x = 2* focus.x - orignal.x;
    symPoint.y = orignal.y;
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path,NULL,orignal.x,orignal.y);
    CGPathAddQuadCurveToPoint(path,NULL,focus.x ,focus.y,destPoint.x,destPoint.y);
    CAKeyframeAnimation *
    animation = [CAKeyframeAnimation
                 animationWithKeyPath:@"position"];
    [animation setPath:path];
    [animation setDuration:duration];
    //    [animation setKeyTimes:@[@0,@1,@3]];
    CFRelease(path);
    CABasicAnimation * scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = @1.0;
    scaleAnimation.toValue = [NSNumber numberWithFloat:sc];
    scaleAnimation.duration = duration;
    
    
    CAAnimationGroup * animationGp = [CAAnimationGroup animation];
    animationGp.duration = duration;
    animationGp.animations = @[animation,scaleAnimation];
    return animationGp;
}

@end
