//
//  CommentCell.m
//  ChuanSongMen
//
//  Created by apple on 16/3/17.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CommentCell.h"
#import "UIImageView+WebCache.h"
@implementation CommentCell

- (void)awakeFromNib {
    self.userHeaderImageView.layer.cornerRadius = 5;
    self.userHeaderImageView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


- (void)setModel:(CommentModel *)model{
    _model = model;
    
    [_userHeaderImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:BasePicAppending@"%@", _model.userHead]]];
    
    _nickNameLabel.text = _model.niCheng;
    _userNameLabel.text = _model.userName;
    
    _timeLabel.text = _model.createDate;
    
    _infoLabel.text = _model.info;
    
    CGRect rect = [_model.info boundingRectWithSize:CGSizeMake(_infoLabel.frame.size.width, 0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil];
    _infoHeight.constant = rect.size.height;
  _nickNameWidth.constant = [self widthForString:_model.niCheng fontSize:17 andHeight:21];
    
    NSLog(@"%f", _nickNameWidth.constant);

}



+(CGFloat)heightForCellByModel:(CommentModel *)model{
    if ([model.info isEqualToString:@""]) {
        return 70;
    }else{
        CGRect rect = [model.info boundingRectWithSize:CGSizeMake(   KScrennWith - 78, 0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil];
        return rect.size.height + 50;
    }
    
}




#pragma mark ===== 获取字符串的宽度 ====
- (CGFloat)widthForString:(NSString *)value fontSize:(CGFloat)fontSize andHeight:(CGFloat)height
{
    CGSize sizeToFit = [value sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(CGFLOAT_MAX, height) lineBreakMode:NSLineBreakByWordWrapping];//此处的换行类型（lineBreakMode）可根据自己的实际情况进行设置
    CGFloat width = sizeToFit.width;
    return width;
}


@end
