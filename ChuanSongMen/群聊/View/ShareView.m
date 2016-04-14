//
//  shareView.m
//  ChuanSongMen
//
//  Created by QUAN on 16/4/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ShareView.h"
#import "EMMessage.h"
#import "IChatManagerChat.h"

@interface ShareView ()

@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UIImageView *shareImage;

@property (weak, nonatomic) IBOutlet UILabel *detailsLab;

@property (weak, nonatomic) IBOutlet UILabel *detailsLab2;

@end

@implementation ShareView

-(void)setModel:(UsergetMyAction *)model{
    
    _model = model;
    
    self.name.text = model.niCheng;
    
}

-(void)setModel2:(HomePageModel *)model2{
    
    _model2 = model2;
    
    
    self.detailsLab.text = model2.info;
    self.detailsLab2.text = model2.info;
    
    
    if (model2.photoList.count != 0) {
        
        [_shareImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://120.24.46.199/Door%@",model2.photoList[0][@"url"]]]];
        
    }else{
        self.shareImage.hidden = YES;
        
        self.detailsLab.hidden = YES;
        
        self.detailsLab2.hidden = NO;
    }
    
    
    
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"ShareView" owner:self options:nil] lastObject];
        
        if (self.model2.photoList.count == 0) {
            
            self.detailsLab.x = self.shareImage.x;
            
        }
        
        
        
        
        
    }
    return self;
}


- (IBAction)clickSendOutBtn:(id)sender {
    
    NSLog(@"发送");
    
    
    EMChatText *txtChat = [[EMChatText alloc] initWithText:@"要发送的消息"];
    EMTextMessageBody *body = [[EMTextMessageBody alloc] initWithChatObject:txtChat];
    
    // 生成message
    EMMessage *message = [[EMMessage alloc] initWithReceiver:self.model.userId bodies:@[body]];
    message.messageType = eMessageTypeChat;
    
//    [IChatManagerChat ];
    
    NSLog(@"%@",message);
}


- (IBAction)clickBack:(id)sender {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"返回" object:nil];
    
}
@end
