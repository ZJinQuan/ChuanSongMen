//
//  VideoPlayVc.m
//  ChuanSongMen
//
//  Created by FemtoappMacpro15 on 16/3/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "VideoPlayVc.h"
#import "CDPVideoPlayer.h"
@interface VideoPlayVc () <CDPVideoPlayerDelegate> {
    CDPVideoPlayer *_player;
    
}


@end

@implementation VideoPlayVc

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    [UIApplication sharedApplication].statusBarStyle=UIStatusBarStyleLightContent;
    
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(5, 25, 40,40);
    [backButton setImage:[UIImage imageNamed:@"shanchu"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    [self createUI];
    //开始播放
    [_player play];
    
}



-(BOOL)shouldAutorotate{
    return !_player.isSwitch;
}
#pragma mark - 创建UI
-(void)createUI{
    
    //播放器
    _player=[[CDPVideoPlayer alloc] initWithFrame:CGRectMake(0,self.view.center.y - (KScrennWith * 3 / 4) / 2 ,KScrennWith,KScrennWith * 3 / 4)
                                              url:self.videoUrl
                                         delegate:self
                                   haveOriginalUI:YES];
    _player.title=@"";
    [self.view addSubview:_player];
    
}
#pragma mark - 点击事件
//返回
-(void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)dealloc{
    //关闭播放器并销毁当前播放view
    //一定要在退出时使用,否则内存可能释放不了
    [_player close];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end
