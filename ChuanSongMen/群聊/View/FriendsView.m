//
//  FriendsView.m
//  ChuanSongMen
//
//  Created by QUAN on 16/4/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "FriendsView.h"
#import "UsergetMyAction.h"

@interface FriendsView ()

@property (nonatomic, strong) NSMutableArray *userMode;

@end

@implementation FriendsView

-(void)setModel:(UsergetMyAction *)model{
    
    _model = model;
    
    
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        
        
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    NSLog(@"%@",self.model.name);
    
    cell.textLabel.text = self.model.name;
    
    
    return cell;
}


@end
