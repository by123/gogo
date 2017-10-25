//
//  TitleView.m
//  gogo
//
//  Created by by.huang on 2017/10/26.
//  Copyright © 2017年 by.huang. All rights reserved.
//

#import "TitleView.h"

@implementation TitleView

-(instancetype)initWithTitle:(int)height title:(NSString *)title{
    if(self == [super init]){
        [self initView:height title:title];
    }
    return self;
}

-(void)initView:(int)height title:(NSString *)title{
    self.frame = CGRectMake(0, height, ScreenWidth, [PUtil getActualHeight:88]);
    self.backgroundColor = c07_bar;
    UIView *leftView = [[UIView alloc]init];
    leftView.backgroundColor = c01_blue;
    leftView.frame = CGRectMake(0, [PUtil getActualHeight:27], [PUtil getActualWidth:6],[PUtil getActualHeight:34]);
    [self addSubview:leftView];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = title;
    titleLabel.font = [UIFont systemFontOfSize:[PUtil getActualHeight:34]];
    titleLabel.textColor = c08_text;
    titleLabel.frame = CGRectMake([PUtil getActualWidth:22],[PUtil getActualHeight:20],[PUtil getActualWidth:400] , [PUtil getActualHeight:48]);
    [self addSubview:titleLabel];
}


@end
