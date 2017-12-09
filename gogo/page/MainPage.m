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
#import "MineView.h"
#import "NewsDetailPage.h"
#import "ScheduleDetailPage.h"
#import "CorpsDetailPage.h"
#import "LoginPage.h"
#import "ChargePage.h"
#import "AddressPage.h"
#import "GuessHistoryPage.h"
#import "ExchangePage.h"
#import "AboutPage.h"
#import "PersonalPage.h"
#import "GuessPage.h"
#import "GoodsDetailPage.h"
#import "RespondModel.h"
#import "UserModel.h"
#import "AccountManager.h"
#import "SettingPage.h"
#import <AVKit/AVKit.h>
#import "SignView.h"

#define TitleHeight [PUtil getActualHeight:88]

@interface MainPage ()<BottomViewDelegate,MainHandleDelegate>

@property (strong, nonatomic) UILabel *mTitleLabel;
@property (strong, nonatomic) UIView  *mBodyView;
@property (strong, nonatomic) MineView *mineView;
@property (strong, nonatomic) HomeView *homeView;

@end

@implementation MainPage
{
    NSArray * titles;
    NSArray * images;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appBecomeActive:)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appWillResignActive:)
                                                 name:UIApplicationWillResignActiveNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoPlayEnd) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
}


-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    [self getUserInfo];
}


//切换到后台
- (void)appWillResignActive:(NSNotification *)notification{
    if(_homeView){
        [_homeView appWillResignActive];
    }
}

//切换回前台
- (void)appBecomeActive:(NSNotification *)notification{
    
}

//播放结束
- (void)videoPlayEnd{
    if(_homeView){
        [_homeView videoPlayEnd];
    }
}

-(void)initView{
    titles = @[@"首页",@"赛事",@"商城",@"我的"];
    images =@[@"ic_home_0_24",@"ic_home_1_24",@"ic_game_0_24",@"ic_game_1_24",@"ic_store_0_24",@"ic_store_1_24",@"ic_me_0_24",@"ic_me_1_24"];
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
    BottomView *bottomView = [[BottomView alloc]initWithTitles:titles images:images delegate:self];
    [self.view addSubview:bottomView];
}


-(void)OnTabSelected:(NSInteger)index{
    if(_homeView){
        [_homeView restore];
    }
    [self removeBodySubView];
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
    _homeView = [[HomeView alloc]initWithFrame:CGRectMake(0, 0,ScreenWidth, _mBodyView.mj_h)];
    _homeView.handleDelegate = self;
    _homeView.vc = self;
    [_mBodyView addSubview:_homeView];
}

#pragma mark 添加赛事
-(void)addGamePage{
    GamePage *gamepage = [[GamePage alloc]init];
    gamepage.handleDelegate = self;
    [_mBodyView addSubview:gamepage.view];
}

#pragma mark 添加商城
-(void)addMallPage{
    MallPage *mallpage = [[MallPage alloc]init];
    mallpage.handleDelegate = self;
    [_mBodyView addSubview:mallpage.view];
}

#pragma mark 添加我的
-(void)addMinePage{
    _mineView = [[MineView alloc]initWithFrame:CGRectMake(0, 0,ScreenWidth, _mBodyView.mj_h)];
    _mineView.handleDelegate = self;
    [_mBodyView addSubview:_mineView];
}


#pragma mark 跳转到新闻详细页
-(void)goNewsDetailPage:(long)nid{
    NewsDetailPage *page = [[NewsDetailPage alloc]init];
    page.news_id = nid;
    [self pushPage:page];
}

#pragma mark 跳转到赛事安排详细页
-(void)goScheduleDetailPage : (long)nid{
    ScheduleDetailPage *page = [[ScheduleDetailPage alloc]init];
    [self pushPage:page];
}

#pragma mark 跳转到战队详细页
-(void)goCorpsDetailPage : (long)nid{
    CorpsDetailPage *page = [[CorpsDetailPage alloc]init];
    page.team_id = nid;
    [self pushPage:page];
}

#pragma mark 跳转到登录页
-(void)goLoginPage{
    LoginPage *page = [[LoginPage alloc]init];
    [self pushPage:page];
}

#pragma mark 跳转到充值页
-(void)goChargePage{
    ChargePage *page = [[ChargePage alloc]init];
    [self pushPage:page];
}

#pragma mark 跳转到地址信息
-(void)goAddressPage{
    AddressPage *page = [[AddressPage alloc]init];
    [self pushPage:page];
}

#pragma mark 跳转竞猜历史
-(void)goHistoryPage{
    GuessHistoryPage *page = [[GuessHistoryPage alloc]init];
    [self pushPage:page];
}

#pragma mark 跳转到兑换记录
-(void)goExchangePage{
    ExchangePage *page = [[ExchangePage alloc]init];
    [self pushPage:page];
}

#pragma mark 跳转到设置
-(void)goSettingPage{
    SettingPage *page = [[SettingPage alloc]init];
    [self pushPage:page];
}

#pragma mark 跳转到个人信息
-(void)goPersonalPage{
    PersonalPage *page = [[PersonalPage alloc]init];
    [self pushPage:page];
}

#pragma mark 跳转到竞猜
-(void)goGuessPage:(long)race_id end:(Boolean *)isEnd{
    GuessPage *page = [[GuessPage alloc]init];
    page.race_id = race_id;
    page.isEnd = isEnd;
    [self pushPage:page];
}

#pragma mark 跳转到商品详情
-(void)goGoodsDetailPage:(long)nid{
    GoodsDetailPage *page = [[GoodsDetailPage alloc]init];
    page.goods_id = nid;
    [self pushPage:page];
}



-(void)getUserInfo{
    [ByNetUtil get:API_USERINFO parameters:nil success:^(RespondModel *respondModel) {
        if(respondModel.code == 200){
            id data = respondModel.data;
            UserModel *userModel = [UserModel mj_objectWithKeyValues:data];
            [[AccountManager sharedAccountManager]saveUserInfo:userModel];
            if(_mineView){
                [_mineView updateUserInfo];
            }
       }
    } failure:^(NSError *error) {
        
    }];
}


#pragma mark 显示签到UI
-(void)showSignView : (id<SignViewDelegate>)delegate{
    SignView *signView =[[SignView alloc]init];
    signView.delegate = delegate;
    [self.view addSubview:signView];
}

@end
