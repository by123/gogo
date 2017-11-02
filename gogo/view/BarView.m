
//
//  BarView.m
//  gogo
//
//  Created by by.huang on 2017/10/26.
//  Copyright © 2017年 by.huang. All rights reserved.
//

#import "BarView.h"

@interface BarView()

@property (strong , nonatomic) UIButton *backView;

@property (strong, nonatomic) UILabel *titleLabel;

@end

@implementation BarView{
    BaseViewController *currentPage;
}

-(instancetype)initWithTitle:(NSString *)title page : (BaseViewController *)cPage{
    if(self == [super init]){
        currentPage = cPage;
        [self initView : title];
    }
    return self;
}

-(void)initView : (NSString *)title{

    self.backgroundColor = c07_bar;
    self.frame = CGRectMake(0, StatuBarHeight,ScreenWidth, [PUtil getActualHeight:88]);
    
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.text = title;
    _titleLabel.textColor = c08_text;
    _titleLabel.frame = CGRectMake(0, 0,ScreenWidth, [PUtil getActualHeight:88]);;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont systemFontOfSize:[PUtil getActualHeight:36]];
    [self addSubview:_titleLabel];
    
    _backView = [[UIButton alloc]init];
    _backView.frame = CGRectMake([PUtil getActualWidth:20], [PUtil getActualHeight:20], [PUtil getActualHeight:48], [PUtil getActualHeight:48]);
    [_backView setImage:[UIImage imageNamed:@"ic_back_24"] forState:UIControlStateNormal];
    [_backView addTarget:self action:@selector(onBackPage) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_backView];
}

-(void)onBackPage{
    if(currentPage){
        [currentPage.navigationController popViewControllerAnimated:YES];
    }
}

@end
