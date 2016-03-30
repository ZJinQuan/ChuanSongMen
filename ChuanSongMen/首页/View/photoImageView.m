//
//  photoImageView.m
//  ChuanSongMen
//
//  Created by 侯海涛 on 15/10/7.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "photoImageView.h"

@interface photoImageView ()
{
    UIImageView *_imageView1;
    UIImageView *_imageView2;
    UIImageView *_imageView3;
    UIImageView *_imageView4;
    
}
@end

@implementation photoImageView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    
    if (self) {
        [self addContentView];
        
        
    }
    
    return self;
}

-(void)addContentView{
    
    
    _imageView1=[[UIImageView alloc] init];
    
    _imageView2=[[UIImageView alloc] init];
    
    _imageView3=[[UIImageView alloc] init];
    
    _imageView4=[[UIImageView alloc] init];
    
    
    
}

-(void)setContentView:(int)num{
//    switch (num) {
//        case 1:
//           
//            break;
//            
//        case 2:
//            [self grout2];
//            break;
//            
//        case 3:
//            [self grout3];
//            break;
//            
//        case 4:
//            [self grout4];
//            break;
//            
//        default:
//            break;
//    }
    
    
    if (num==1) {
        [self grout1];
    }
    
    if (num==2) {
        [self grout2];
    }
    
    if (num==3) {
        [self grout3];
    }
    
    if (num==4) {
        [self grout4];
    }
    
    if (num>=4) {
        
        
       
        [self grout4];
        UILabel *numImageLabel=[[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width/2+2+((self.bounds.size.width/2-2+3-60)/2), self.bounds.size.height/2+2+(self.bounds.size.height/2-2-30)/2, 60,  30)];
               numImageLabel.text=[NSString stringWithFormat:@"+%d",num-4+1];
        numImageLabel.font=[UIFont systemFontOfSize:25];
        numImageLabel.textAlignment=NSTextAlignmentCenter;
        numImageLabel.textColor=[UIColor whiteColor];
        
        [self addSubview:numImageLabel];
    }
    
    
    
}


-(void)grout1{
    
    
    _imageView1.frame=CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    _imageView1.image=[UIImage imageNamed:@"0001.png"];
    [self addSubview:_imageView1];
    
    
}

-(void)grout2{
    
    _imageView1.frame=CGRectMake(-3, 0, self.bounds.size.width/2-2+3, self.bounds.size.height);
    _imageView1.image=[UIImage imageNamed:@"0001.png"];
    [self addSubview:_imageView1];
    
    _imageView2.frame=CGRectMake( self.bounds.size.width/2+2, 0, self.bounds.size.width/2-2+3, self.bounds.size.height);
    _imageView2.image=[UIImage imageNamed:@"0001.png"];
    [self addSubview:_imageView2];
    
}

-(void)grout3{
    
    
    _imageView1.frame=CGRectMake(self.bounds.size.width/2+2, 0, self.bounds.size.width/2-2, self.bounds.size.height);
    _imageView1.image=[UIImage imageNamed:@"0001.png"];
    [self addSubview:_imageView1];
    
    _imageView2.frame=CGRectMake(0, 0, self.bounds.size.width/2-2+3, self.bounds.size.height/2-2);
    _imageView2.image=[UIImage imageNamed:@"0001.png"];
    [self addSubview:_imageView2];
    
    _imageView3.frame=CGRectMake(0, self.bounds.size.height/2+2, self.bounds.size.width/2-2+3,  self.bounds.size.height/2-2);
    _imageView3.image=[UIImage imageNamed:@"0001.png"];
    [self addSubview:_imageView3];
}

-(void)grout4{
    
    
    _imageView1.frame=CGRectMake(-3, 0, self.bounds.size.width/2-2+3, self.bounds.size.height/2-2);
    _imageView1.image=[UIImage imageNamed:@"0001.png"];
    [self addSubview:_imageView1];
    
    _imageView2.frame=CGRectMake(-3, self.bounds.size.height/2+2, self.bounds.size.width/2-2+3, self.bounds.size.height/2-2);
    _imageView2.image=[UIImage imageNamed:@"0001.png"];
    [self addSubview:_imageView2];
    
    _imageView3.frame=CGRectMake(self.bounds.size.width/2+2, 0, self.bounds.size.width/2-2+3, self.bounds.size.height/2-2);
    _imageView3.image=[UIImage imageNamed:@"0001.png"];
    [self addSubview:_imageView3];
    
    
    _imageView4.frame=CGRectMake(self.bounds.size.width/2+2, self.bounds.size.height/2+2, self.bounds.size.width/2-2+3,  self.bounds.size.height/2-2);
    _imageView4.image=[UIImage imageNamed:@"0001.png"];
    [self addSubview:_imageView4];
}

@end
