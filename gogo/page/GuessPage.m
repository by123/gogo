//
//  GuessPage.m
//  gogo
//
//  Created by by.huang on 2017/10/29.
//  Copyright © 2017年 by.huang. All rights reserved.
//

#import "GuessPage.h"
#import "GuessView.h"
#import "FightingView.h"
#import "BySegmentView.h"
#import "LivePage.h"
@interface GuessPage ()

@property (strong, nonatomic) UIView *aTeamImageView;
@property (strong, nonatomic) UILabel *aTeamLabel;
@property (strong, nonatomic) UIView *bTeamImageView;
@property (strong, nonatomic) UILabel *bTeamLabel;
@property (strong, nonatomic) UILabel *timeLabel;
@property (strong, nonatomic) UILabel *gameLabel;
@property (strong, nonatomic) UILabel *scoreLabel;


@end

@implementation GuessPage

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

-(void)initView{
    [self initTopView];
    [self initBodyView];
}

-(void)initTopView{
    UIView *topView = [[UIView alloc]init];
    topView.frame = CGRectMake(0, StatuBarHeight, ScreenWidth,[PUtil getActualHeight:459]-StatuBarHeight);
    [self.view addSubview:topView];
    [ColorUtil setGradientColor:topView startColor:c01_blue endColor:c02_red director:Left];
    
    UIButton *backView = [[UIButton alloc]init];
    backView.frame = CGRectMake([PUtil getActualWidth:20], [PUtil getActualHeight:20], [PUtil getActualHeight:48], [PUtil getActualHeight:48]);
    [backView setImage:[UIImage imageNamed:@"ic_back_24"] forState:UIControlStateNormal];
    [backView addTarget:self action:@selector(onBackPage) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:backView];
    
    _aTeamImageView =[[UIView alloc]init];
    _aTeamImageView.backgroundColor = c01_blue;
    _aTeamImageView.layer.masksToBounds = YES;
    _aTeamImageView.layer.cornerRadius = [PUtil getActualHeight:20];
    _aTeamImageView.frame = CGRectMake([PUtil getActualWidth:101], [PUtil getActualHeight:162]-StatuBarHeight, [PUtil getActualWidth:140], [PUtil getActualWidth:140]);
    [topView addSubview:_aTeamImageView];
    
    _aTeamLabel = [[UILabel alloc]init];
    _aTeamLabel.textColor = c08_text;
    _aTeamLabel.text = @"AG超会玩";
    _aTeamLabel.textAlignment = NSTextAlignmentCenter;
    _aTeamLabel.font = [UIFont systemFontOfSize:[PUtil getActualHeight:32]];
    _aTeamLabel.frame = CGRectMake([PUtil getActualWidth:101], [PUtil getActualHeight:318]-StatuBarHeight, [PUtil getActualWidth:140], [PUtil getActualWidth:45]);
    [topView addSubview:_aTeamLabel];
    
    _bTeamImageView =[[UIView alloc]init];
    _bTeamImageView.backgroundColor = c01_blue;
    _bTeamImageView.layer.masksToBounds = YES;
    _bTeamImageView.layer.cornerRadius = [PUtil getActualHeight:20];
    _bTeamImageView.frame = CGRectMake([PUtil getActualWidth:509], [PUtil getActualHeight:162]-StatuBarHeight, [PUtil getActualWidth:140], [PUtil getActualWidth:140]);
    [topView addSubview:_bTeamImageView];
    
    _bTeamLabel = [[UILabel alloc]init];
    _bTeamLabel.textColor = c08_text;
    _bTeamLabel.text = @"GK";
    _bTeamLabel.textAlignment = NSTextAlignmentCenter;
    _bTeamLabel.font = [UIFont systemFontOfSize:[PUtil getActualHeight:32]];
    _bTeamLabel.frame = CGRectMake([PUtil getActualWidth:509], [PUtil getActualHeight:318]-StatuBarHeight, [PUtil getActualWidth:140], [PUtil getActualWidth:45]);
    [topView addSubview:_bTeamLabel];
    
    UILabel *vsLabel = [[UILabel alloc]init];
    vsLabel.textColor = c08_text;
    vsLabel.text = @"VS";
    vsLabel.textAlignment = NSTextAlignmentCenter;
    vsLabel.font = [UIFont systemFontOfSize:[PUtil getActualHeight:72]];
    vsLabel.frame = CGRectMake(0 ,[PUtil getActualHeight:182]-StatuBarHeight, ScreenWidth, [PUtil getActualWidth:100]);
    [topView addSubview:vsLabel];
    
    _scoreLabel = [[UILabel alloc]init];
    _scoreLabel.textColor = c09_tips;
    _scoreLabel.text = @"0 : 0";
    _scoreLabel.textAlignment = NSTextAlignmentCenter;
    _scoreLabel.font = [UIFont systemFontOfSize:[PUtil getActualHeight:34]];
    _scoreLabel.frame = CGRectMake(0 ,[PUtil getActualHeight:292]-StatuBarHeight, ScreenWidth, [PUtil getActualWidth:48]);
    [topView addSubview:_scoreLabel];
    
    _timeLabel = [[UILabel alloc]init];
    _timeLabel.textColor = c09_tips;
    _timeLabel.text = @"2017年10月19日 18:00";
    _timeLabel.textAlignment = NSTextAlignmentCenter;
    _timeLabel.font = [UIFont systemFontOfSize:[PUtil getActualHeight:24]];
    _timeLabel.frame = CGRectMake(0 ,[PUtil getActualHeight:106]-StatuBarHeight, ScreenWidth, [PUtil getActualWidth:33]);
    [topView addSubview:_timeLabel];
    
    _gameLabel = [[UILabel alloc]init];
    _gameLabel.textColor = c09_tips;
    _gameLabel.text = @"KPL秋季赛";
    _gameLabel.textAlignment = NSTextAlignmentCenter;
    _gameLabel.font = [UIFont systemFontOfSize:[PUtil getActualHeight:24]];
    _gameLabel.frame = CGRectMake(0 ,[PUtil getActualHeight:139]-StatuBarHeight, ScreenWidth, [PUtil getActualWidth:33]);
    [topView addSubview:_gameLabel];
    
}

-(void)initBodyView{
    NSMutableArray *views = [[NSMutableArray alloc]init];
    GuessView *guessView = [[GuessView alloc]init];
    guessView.delegate = self;
    FightingView *fligtingView = [[FightingView alloc]init];
    [views addObject:guessView];
    [views addObject:fligtingView];
    
    BySegmentView *segmentView = [[BySegmentView alloc]initWithFrame:CGRectMake(0, [PUtil getActualHeight:459] - StatuBarHeight, ScreenWidth, ScreenHeight - ([PUtil getActualHeight:459] - StatuBarHeight)) andTitleArray:@[@"竞猜", @"赛况"] andShowControllerNameArray:views];
    [self.view addSubview:segmentView];
}

-(void)onBackPage{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)goLivePage{
    LivePage *page = [[LivePage alloc]init];
    [self pushPage:page];
}


@end
