//
//  HomeTableViewCell.m
//  chuansongmen
//
//  Created by apple on 15/9/7.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "HomeTableViewCell.h"
#import "UIUtils.h"

#import "UIButton+UIButtonImageWithLable.h"

#import "photoImageView.h"
#import "UIImageView+WebCache.h"

#import "UIViewAdditions.h"

@interface HomeTableViewCell ()
{
    
    UIImageView *_userImage;
    UILabel *_userNameLabel;
    UILabel *_userNameSubLabel;
    UITextView *_textView;
    UIImageView *_photoImage;
    photoImageView *phoView;
    UIScrollView *scrollView;
    
    UIImageView *_imageView1;
    UIImageView *_imageView2;
    UIImageView *_imageView3;
    
    UILabel *_label1;
    UILabel *_label2;
    UILabel *_label3;
    
    UIButton  *shareButton;
    UIImage *share_image;
    
    UIButton  *pinglunButton;
    UIButton  *zanButton;
    
    
    UILabel *_timeLabel;
    
    
}
@end


@implementation HomeTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addContentView];
        
    }
    
    return self;
}

-(void)addContentView{
    
    //用户头像
    _userImage=[[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
    _userImage.layer.cornerRadius=5;
//    _userImage.layer.borderWidth=1;
    _userImage.clipsToBounds = YES;
    _userImage.layer.borderColor=[UIColor blackColor].CGColor;

    [self addSubview:_userImage];
    
    //增加用户名
    _userNameLabel=[self labelWith];
    
    
    [self addSubview:_userNameLabel];
    //用户名后面标记
    _userNameSubLabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_userNameLabel.frame)+5, CGRectGetMinY(_userImage.frame), [UIUtils getWindowWidth]-CGRectGetMaxX(_userNameLabel.frame)-5-60, 25)];
    _userNameSubLabel.font=[UIFont systemFontOfSize:12];
    _userNameSubLabel.text=@"@Shalajing1122";
    [self addSubview:_userNameSubLabel];
    
#pragma mark ======添加右侧时间标签 ===================
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.right - 130, 15, 120, 20)];
    _timeLabel.font = [UIFont systemFontOfSize:10];
    _timeLabel.textAlignment = NSTextAlignmentRight;
    _timeLabel.textColor = [UIColor grayColor];
    [self addSubview:_timeLabel];
    
    
    
    //增加内容
    _textView=[[UITextView alloc] initWithFrame:CGRectMake(CGRectGetMinX(_userNameLabel.frame), CGRectGetMaxY(_userNameLabel.frame)+5, [UIUtils getWindowWidth]-CGRectGetMaxX(_userImage.frame)-5-5, 40)];
    _textView.editable=NO;
//    _textView.text=@"双料冠dgsga山东省归属感上个上个双料冠dgsga山东省归属感上个上个双料冠dgsga山东省归属感上个上个双料冠dgsga山东省归属感上个上个双料冠dgsga山东省归属感上个上个双料冠dgsga山东省归属感上个上个";
    _textView.userInteractionEnabled=YES;
    _textView.scrollEnabled=NO;
    UITapGestureRecognizer *textViewtap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(textViewTapPress)];
    [_textView addGestureRecognizer:textViewtap];
    
    [self addSubview:_textView];
    
    //计算textview的高度
    float height=[self getTextHeight];
    _textView.frame= CGRectMake ( CGRectGetMinX(_userNameLabel.frame), CGRectGetMaxY(_userNameLabel.frame)+5, [UIUtils getWindowWidth]-CGRectGetMaxX(_userImage.frame)-5-5, height);
    
    NSNumber *numHeight=[NSNumber numberWithFloat:height];
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"textViewHeight" object:numHeight];
    
    
    
  
    phoView=[[photoImageView alloc] initWithFrame:CGRectMake(-5,-5, [UIUtils getWindowWidth]-CGRectGetMaxX(_userImage.frame)-5-10+10, 80+10+60)];
    
    scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(CGRectGetMinX(_userNameLabel.frame), CGRectGetMaxY(_textView.frame)+5, [UIUtils getWindowWidth]-CGRectGetMaxX(_userImage.frame)-5-10, 80+60)];
    scrollView.contentSize=CGSizeMake([UIUtils getWindowWidth]-CGRectGetMaxX(_userImage.frame)-5-10, 80+60);
    scrollView.layer.cornerRadius=5;
    [scrollView addSubview:phoView];
   
    UITapGestureRecognizer *imageTap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoImageViewTapPress)];
    [scrollView addGestureRecognizer:imageTap];
    
    
 //    //图片
//    _photoImage=[[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(_userNameLabel.frame), CGRectGetMaxY(_textView.frame)+5, [UIUtils getWindowWidth]-CGRectGetMaxX(_userImage.frame)-5-10, 80)];
//    _photoImage.image=[UIImage imageNamed:@"0001.png"];
    [self addSubview:scrollView];
 
    
    //增加底部按钮视图
    [self addButtomButton];
    
    
    //增加横线
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 160+height-1+60, [UIUtils getWindowWidth], 1)];
    view.backgroundColor=[UIColor grayColor];
    [self addSubview:view];
    
    
    
}
#pragma mark ==========添加底部控件 ==============================
-(void)addButtomButton{
    
    //赞按钮
    UIImage *image1=[UIImage imageNamed:@"home_btn_zan.png"];
    zanButton=[UIButton buttonWithType:UIButtonTypeCustom];
    zanButton.frame=CGRectMake(CGRectGetMinX(_userNameLabel.frame), CGRectGetMaxY(scrollView.frame)+5, 55, 30);
    [zanButton setImage2:image1 withTitle:@"评论" forState:UIControlStateNormal];
    [zanButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [zanButton addTarget:self action:@selector(zanButtonPress) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:zanButton];
    
    _label1=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(zanButton.frame), CGRectGetMaxY(scrollView.frame)+5, 60, 25)];
    _label1.text=@"300";
    _label1.font=[UIFont systemFontOfSize:10];
    [self addSubview:_label1];
    
    
    
    //评论按钮
    UIImage *image2=[UIImage imageNamed:@"home_btn_tlak.png"];
    pinglunButton=[UIButton buttonWithType:UIButtonTypeCustom];
    pinglunButton.frame=CGRectMake(CGRectGetMinX(zanButton.frame)+([UIUtils getWindowWidth]- CGRectGetMinX(zanButton.frame)-15)/3, CGRectGetMaxY(scrollView.frame)+5, 55, 30);
    [pinglunButton setImage2:image2 withTitle:@"评论" forState:UIControlStateNormal];
    [pinglunButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [pinglunButton addTarget:self action:@selector(pinglunButtonPress) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:pinglunButton];
    
    _label2=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(pinglunButton.frame), CGRectGetMaxY(scrollView.frame)+5, 60, 25)];
    _label2.text=@"300";
    _label2.font=[UIFont systemFontOfSize:10];
    [self addSubview:_label2];
    
    
    
   
    
    
    //分享按钮
    
    shareButton=[UIButton buttonWithType:UIButtonTypeCustom];
    shareButton.frame=CGRectMake(CGRectGetMinX(pinglunButton.frame)+([UIUtils getWindowWidth]- CGRectGetMinX(zanButton.frame)-15)/3, CGRectGetMaxY(scrollView.frame)+5, 75, 30);
    
    [shareButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(shareButtonPress) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:shareButton];
    
    _label3=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(shareButton.frame)-5, CGRectGetMaxY(scrollView.frame)+5, 60, 25)];
    
    _label3.font=[UIFont systemFontOfSize:10];
    [self addSubview:_label3];
    
    
}

-(void)shareButtonPress{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(HomeTableViewCellShareButtonPress:)]) {
        [self.delegate HomeTableViewCellShareButtonPress:(int)self.tag];
    }
    
    
}
-(void)pinglunButtonPress{
    if (self.delegate && [self.delegate respondsToSelector:@selector(HomeTableViewCellPingLunButtonPress:)]) {
        [self.delegate HomeTableViewCellPingLunButtonPress:(int)self.tag];
    }
    
    
}

-(void)zanButtonPress{
    int num=[_label1.text intValue];
    _label1.text=[NSString stringWithFormat:@"%d",++num];
    if (self.delegate && [self.delegate respondsToSelector:@selector(HomeTableViewCellZanButtonPress:)]) {
        [self.delegate HomeTableViewCellZanButtonPress:(int)self.tag];
    }
    
    
}

//点击文本跳转
-(void)textViewTapPress{
    if (self.delegate && [self.delegate respondsToSelector:@selector(HomeTableViewCellTextViewButtonPress:)]) {
        [self.delegate HomeTableViewCellTextViewButtonPress:(int)self.tag];
    }
    
}
//点击文本跳转
-(void)photoImageViewTapPress{
    if (self.delegate && [self.delegate respondsToSelector:@selector(HomeTableViewCellPhotoImageViewButtonPress:)]) {
        [self.delegate HomeTableViewCellPhotoImageViewButtonPress:(int)self.tag];
    }
    
}

-(void)setContentView:(NSDictionary *)dictionary andIndex:(int)num andImgType:(NSString *)imgType{
    
    [phoView setContentView:num];
    
    if ([imgType isEqualToString:@"1"]) {
        share_image=[UIImage imageNamed:@"home_btn_tlak.png"];
                    [shareButton setImage2:share_image withTitle:@"分享" forState:UIControlStateNormal];
                     _userImage.image=[UIImage imageNamed:@"tab_i.png"];
                    _label3.text=@"45";

    }
    if ([imgType isEqualToString:@"2"]) {
                    share_image=[UIImage imageNamed:@"home_xuanshang.png"];
                    [shareButton setImage2:share_image withTitle:@"悬赏" forState:UIControlStateNormal];
                     _userImage.image=[UIImage imageNamed:@"home_shangjin.png"];
                    _label3.text=@"100元";
    }

    if ([imgType isEqualToString:@"3"]) {
                    share_image=[UIImage imageNamed:@"home_xuanshang.png"];
                    [shareButton setImage2:share_image withTitle:@"广告位" forState:UIControlStateNormal];
                    _userImage.image=[UIImage imageNamed:@"home_shangjin.png"];
                    _label3.text=@"100元";
        
    }

    
    
//    _userImage.image=[UIImage imageNamed:dictionary[@"image"]];
//    _userNameLabel.text=dictionary[@"title"];
   // _textView.text=dictionary[@"text"];
    
}




//获取textview的高度   文本的高度
- (CGFloat)getTextHeight
{
    //计算出text的高度
    int textHeight=0;
    if (isIos7System) {
        CGSize newSize = [_textView sizeThatFits:CGSizeMake([UIUtils getWindowWidth]-CGRectGetMaxX(_userImage.frame)-5-5, MAXFLOAT)];
        textHeight = newSize.height;
    } else {
        textHeight = _textView.contentSize.height;
    }
    return textHeight;
    
}


-(UILabel *)labelWith{
    
    UILabel *label= [[UILabel alloc] initWithFrame:CGRectMake(0,0,0,0)];
    [_userNameLabel setNumberOfLines:0];
    NSString *s =@"传送门有限公司";
    UIFont *font = [UIFont fontWithName:@"Arial" size:14];
    CGSize size = CGSizeMake(320,2000);
    CGSize labelsize = [s sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    label.frame = CGRectMake(CGRectGetMaxX(_userImage.frame)+5,CGRectGetMinY(_userImage.frame), labelsize.width, 25 );
    label.text = s;
    label.font = font;
    return label;
}

#pragma mark  ============= 给cell赋值 ====================
- (void)setModel:(HomePageModel *)model{
    _model = model;
    [_userImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://112.74.72.48/Door%@",_model.documentUserHead]]];
    
    _userNameLabel.text = _model.documentNiCheng;
    _userNameSubLabel.text = _model.documentUserName;
    _textView.text = _model.info;
    _label1.text = _model.topCount;
    _label2.text = _model.discussCount;
    _timeLabel.text = _model.homeDate;
    
    
}


@end
