//
//  GrouChatView.m
//  chuansongmen
//
//  Created by apple on 15/9/9.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "GrouChatView.h"

@interface GrouChatView ()
{
    UIImageView *_imageView1;
    UIImageView *_imageView2;
    UIImageView *_imageView3;
    UIImageView *_imageView4;
    
}
@end


@implementation GrouChatView

-(instancetype)initWithFrame:(CGRect)frame{

    self=[super initWithFrame:frame];
    
    if (self) {
       [self addContentView];
        
        self.backgroundColor=[UIColor whiteColor];
        
        
    }
    
    return self;
}

-(void)addContentView{


    _imageView1=[[UIImageView alloc] init];
    _imageView1.backgroundColor=[UIColor yellowColor];
    
    _imageView2=[[UIImageView alloc] init];
    _imageView2.backgroundColor=[UIColor greenColor];
    
    _imageView3=[[UIImageView alloc] init];
    _imageView3.backgroundColor=[UIColor blueColor];
    
    _imageView4=[[UIImageView alloc] init];
    _imageView4.backgroundColor=[UIColor whiteColor];
    
 
    
}

-(void)setContentView:(int)num{
    switch (num) {
        case 1:
            [self grout1];
            break;
            
        case 2:
            [self grout2];
            break;
            
        case 3:
            [self grout3];
            break;
            
        case 4:
            [self grout4];
            break;
            
        default:
            break;
    }



}


-(void)grout1{
    
    
    _imageView1.frame=CGRectMake(0, 0, 80, 80);
    _imageView1.image=[UIImage imageNamed:@"0003.png"];
    [self addSubview:_imageView1];


}

-(void)grout2{
    
    _imageView1.frame=CGRectMake(0, 0, 80, 80);
    _imageView1.image=[UIImage imageNamed:@"0003.png"];
    [self addSubview:_imageView1];
    
    _imageView2.frame=CGRectMake(40, 0, 80, 80);
    _imageView2.image=[UIImage imageNamed:@"0003.png"];
    [self addSubview:_imageView2];
    
}

-(void)grout3{
    
    
    _imageView1.frame=CGRectMake(0, 0, 80, 80);
    _imageView1.image=[UIImage imageNamed:@"0003.png"];
    [self addSubview:_imageView1];
    
    _imageView2.frame=CGRectMake(40, 0, 40, 40);
    _imageView2.image=[UIImage imageNamed:@"0003.png"];
    [self addSubview:_imageView2];
    
    _imageView3.frame=CGRectMake(40, 40, 40, 40);
    _imageView3.image=[UIImage imageNamed:@"0003.png"];
    [self addSubview:_imageView3];
}

-(void)grout4{
    
    
    _imageView1.frame=CGRectMake(0, 0, 40, 40);
    _imageView1.image=[UIImage imageNamed:@"0003.png"];
    [self addSubview:_imageView1];
    
    _imageView2.frame=CGRectMake(0, 40, 40, 40);
    _imageView2.image=[UIImage imageNamed:@"0003.png"];
    [self addSubview:_imageView2];
    
    _imageView3.frame=CGRectMake(40, 0, 40, 40);
    _imageView3.image=[UIImage imageNamed:@"0003.png"];
    [self addSubview:_imageView3];
    
    
    _imageView4.frame=CGRectMake(40, 40,40,40);
    _imageView4.image=[UIImage imageNamed:@"0003.png"];
    [self addSubview:_imageView4];
}


@end
