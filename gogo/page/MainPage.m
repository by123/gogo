//
//  MainPage.m
//  gogo
//
//  Created by by.huang on 2017/10/22.
//  Copyright © 2017年 by.huang. All rights reserved.
//

#import "MainPage.h"
#import "BySegmentView.h"


#define TitleHeight [PUtil getActualHeight:88]

@interface MainPage ()<BySegmentViewDelegate>

@property (strong, nonatomic) UILabel *mTitleLabel;

@end

@implementation MainPage
{
    NSArray * titleArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

-(void)initView{
    titleArr = @[@"首页",@"赛事",@"商城",@"我的"];
    [self initBar];
    [self initBody];

}

-(void)initBar{
    [self setStatuBarBackgroud:c07_bar];
    _mTitleLabel = [[UILabel alloc]init];
    _mTitleLabel.backgroundColor = c07_bar;
    _mTitleLabel.frame = CGRectMake(0, StatuBarHeight, ScreenWidth, TitleHeight);
    _mTitleLabel.text = @"首页";
    _mTitleLabel.font = [UIFont systemFontOfSize:18.0f];
    _mTitleLabel.textColor = c08_text;
    _mTitleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_mTitleLabel];
    
}

-(void)initBody{
    NSArray * controllerNameArray = @[@"HomePage",@"GamePage",@"MallPage",@"MinePage"];
    CGRect rect =  CGRectMake(0, StatuBarHeight + TitleHeight, ScreenWidth, ScreenHeight - (StatuBarHeight + TitleHeight));
    BySegmentView * segmentView = [[BySegmentView alloc]initWithFrame:rect andTitleArray:titleArr andShowControllerNameArray:controllerNameArray];
    segmentView.delegate = self;
    [self.view addSubview:segmentView];
}


-(void)didSelectIndex:(NSInteger)index{
    _mTitleLabel.text = [titleArr objectAtIndex:index];
}



@end
