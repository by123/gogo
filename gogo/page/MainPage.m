//
//  MainPage.m
//  gogo
//
//  Created by by.huang on 2017/10/22.
//  Copyright © 2017年 by.huang. All rights reserved.
//

#import "MainPage.h"
#import "BottomView.h"
#import "HomeView.h"
#import "GamePage.h"
#import "MallPage.h"
#import "MinePage.h"
#import "NewsDetailPage.h"
#import "ScheduleDetailPage.h"


#define TitleHeight [PUtil getActualHeight:88]

@interface MainPage ()<BottomViewDelegate,MainHandleDelegate>

@property (strong, nonatomic) UILabel *mTitleLabel;
@property (strong, nonatomic) UIView  *mBodyView;

@end

@implementation MainPage
{
    NSArray * titles;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

-(void)initView{
    titles = @[@"首页",@"赛事",@"商城",@"我的"];
    [self initBar];
    [self initBody];
    [self initBottom];
    [self addHomePage];
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
    _mBodyView = [[UIView alloc]init];
    _mBodyView.frame = CGRectMake(0, StatuBarHeight + TitleHeight, ScreenWidth, ScreenHeight - ( StatuBarHeight + TitleHeight + [PUtil getActualHeight:100]));
    [self.view addSubview:_mBodyView];
}

-(void)initBottom{
    BottomView *bottomView = [[BottomView alloc]initWithTitles:titles delegate:self];
    [self.view addSubview:bottomView];
}


-(void)OnTabSelected:(NSInteger)index{
    _mTitleLabel.text = [titles objectAtIndex:index];
    switch (index) {
        case 0:
            [self addHomePage];
            break;
        case 1:
            [self addGamePage];
            break;
        case 2:
            [self addMallPage];
            break;
        case 3:
            [self addMinePage];
            break;
        default:
            break;
    }
}


#pragma mark 移除所有UI
-(void)removeBodySubView{
    for(UIView *view in [_mBodyView subviews]){
        [view removeFromSuperview];
    }
}

#pragma mark 添加首页
-(void)addHomePage{
    [self removeBodySubView];
    HomeView *homeView = [[HomeView alloc]initWithFrame:CGRectMake(0, 0,ScreenWidth, _mBodyView.mj_h)];
    homeView.handleDelegate = self;
    [_mBodyView addSubview:homeView];
}

#pragma mark 添加赛事
-(void)addGamePage{
    [self removeBodySubView];
    GamePage *gamepage = [[GamePage alloc]init];
    gamepage.handleDelegate = self;
    [_mBodyView addSubview:gamepage.view];
}

#pragma mark 添加商城
-(void)addMallPage{
    [self removeBodySubView];
    MallPage *mallpage = [[MallPage alloc]init];
    [_mBodyView addSubview:mallpage.view];
}

#pragma mark 添加我的
-(void)addMinePage{
    [self removeBodySubView];
    MinePage *minepage = [[MinePage alloc]init];
    [_mBodyView addSubview:minepage.view];
}


#pragma mark 跳转到新闻详细页
-(void)goNewsDetailPage:(long)nid{
    NewsDetailPage *page = [[NewsDetailPage alloc]init];
    [self pushPage:page];
}

#pragma mark 跳转到赛事安排详细页
-(void)goScheduleDetailPage : (long)nid{
    ScheduleDetailPage *page = [[ScheduleDetailPage alloc]init];
    [self pushPage:page];
}


@end
