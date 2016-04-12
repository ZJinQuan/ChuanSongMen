//
//  ShareViewC.m
//  ChuanSongMen
//
//  Created by QUAN on 16/4/12.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ShareViewC.h"
#import "AddShareImage.h"

@interface ShareViewC ()

@property (weak, nonatomic) IBOutlet UIScrollView *shareSV;


@end

@implementation ShareViewC

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    AddShareImage *addShare = [[AddShareImage alloc] init];
    
    [self.shareSV addSubview:addShare];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIButton *addToImage = [[UIButton alloc] initWithFrame:CGRectMake(0, self.shareSV.height - 50, self.shareSV.width, 50)];
    addToImage.layer.cornerRadius = 15;
    addToImage.layer.masksToBounds = YES;
    addToImage.backgroundColor = RGB(245, 245, 245);
    
    [addToImage setTitle:@"添加图片" forState:UIControlStateNormal];
    [addToImage setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [addToImage addTarget:self action:@selector(addToImage) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:addToImage];
    
}

-(void)addToImage{
    
    NSLog(@"添加图片");
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        AddShareImage *addShare = [[AddShareImage alloc] initWithFrame:CGRectMake(0, 200, self.shareSV.width, 200)];
        [self.shareSV addSubview:addShare];
        
    });
    
    
    
    
    
}

@end
