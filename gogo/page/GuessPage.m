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
#import "RespondModel.h"
#import "RaceModel.h"
#import "TimeUtil.h"
#import "BettingModel.h"
#import "InsetTextField.h"
#import "UserModel.h"
#import "AccountManager.h"
@interface GuessPage ()

@property (strong, nonatomic) UIImageView *aTeamImageView;
@property (strong, nonatomic) UILabel *aTeamLabel;
@property (strong, nonatomic) UIImageView *bTeamImageView;
@property (strong, nonatomic) UILabel *bTeamLabel;
@property (strong, nonatomic) UILabel *timeLabel;
@property (strong, nonatomic) UILabel *gameLabel;
@property (strong, nonatomic) UILabel *scoreLabel;
@property (strong, nonatomic) UIView *guessOrderView;
@property (strong, nonatomic) GuessView *guessView;
@property (strong, nonatomic) UILabel *guessTitleLabel;
@property (strong, nonatomic) UILabel *coinLabel;
@property (strong, nonatomic) UIButton *guessBtn;

@end

@implementation GuessPage{
    RaceModel *raceModel;
    NSMutableArray *bettingArray;
    NSMutableArray *buttons;
    BettingItemModel *selectModel;
    int selectCoin ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    raceModel = [[RaceModel alloc]init];
    bettingArray =[[NSMutableArray alloc]init];
    buttons = [[NSMutableArray alloc]init];
    [self initView];
    [self requestDetail];
}

-(void)initView{
    [self initTopView];
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
    
    _aTeamImageView =[[UIImageView alloc]init];
//    _aTeamImageView.backgroundColor = c01_blue;
    _aTeamImageView.layer.masksToBounds = YES;
    _aTeamImageView.contentMode = UIViewContentModeScaleAspectFit;
    _aTeamImageView.layer.cornerRadius = [PUtil getActualHeight:20];
    _aTeamImageView.frame = CGRectMake([PUtil getActualWidth:101], [PUtil getActualHeight:162]-StatuBarHeight, [PUtil getActualWidth:140], [PUtil getActualWidth:140]);
    [topView addSubview:_aTeamImageView];
    
    _aTeamLabel = [[UILabel alloc]init];
    _aTeamLabel.textColor = c08_text;
    _aTeamLabel.textAlignment = NSTextAlignmentCenter;
    _aTeamLabel.font = [UIFont systemFontOfSize:[PUtil getActualHeight:32]];
    _aTeamLabel.frame = CGRectMake([PUtil getActualWidth:101], [PUtil getActualHeight:318]-StatuBarHeight, [PUtil getActualWidth:140], [PUtil getActualWidth:45]);
    [topView addSubview:_aTeamLabel];
    
    _bTeamImageView =[[UIImageView alloc]init];
//    _bTeamImageView.backgroundColor = c01_blue;
    _bTeamImageView.layer.masksToBounds = YES;
    _bTeamImageView.contentMode = UIViewContentModeScaleAspectFit;
    _bTeamImageView.layer.cornerRadius = [PUtil getActualHeight:20];
    _bTeamImageView.frame = CGRectMake([PUtil getActualWidth:509], [PUtil getActualHeight:162]-StatuBarHeight, [PUtil getActualWidth:140], [PUtil getActualWidth:140]);
    [topView addSubview:_bTeamImageView];
    
    _bTeamLabel = [[UILabel alloc]init];
    _bTeamLabel.textColor = c08_text;
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
    _scoreLabel.textAlignment = NSTextAlignmentCenter;
    _scoreLabel.font = [UIFont systemFontOfSize:[PUtil getActualHeight:34]];
    _scoreLabel.frame = CGRectMake(0 ,[PUtil getActualHeight:292]-StatuBarHeight, ScreenWidth, [PUtil getActualWidth:48]);
    [topView addSubview:_scoreLabel];
    
    _timeLabel = [[UILabel alloc]init];
    _timeLabel.textColor = c09_tips;
    _timeLabel.textAlignment = NSTextAlignmentCenter;
    _timeLabel.font = [UIFont systemFontOfSize:[PUtil getActualHeight:24]];
    _timeLabel.frame = CGRectMake(0 ,[PUtil getActualHeight:106]-StatuBarHeight, ScreenWidth, [PUtil getActualWidth:33]);
    [topView addSubview:_timeLabel];
    
    _gameLabel = [[UILabel alloc]init];
    _gameLabel.textColor = c09_tips;
    _gameLabel.textAlignment = NSTextAlignmentCenter;
    _gameLabel.font = [UIFont systemFontOfSize:[PUtil getActualHeight:24]];
    _gameLabel.frame = CGRectMake(0 ,[PUtil getActualHeight:139]-StatuBarHeight, ScreenWidth, [PUtil getActualWidth:33]);
    [topView addSubview:_gameLabel];
    
}

-(void)initBodyView{
    NSMutableArray *views = [[NSMutableArray alloc]init];
    _guessView = [[GuessView alloc]initWithDatas:bettingArray];
    _guessView.delegate = self;
    FightingView *fligtingView = [[FightingView alloc]init];
    [views addObject:_guessView];
    [views addObject:fligtingView];
    
    BySegmentView *segmentView = [[BySegmentView alloc]initWithFrame:CGRectMake(0, [PUtil getActualHeight:459] - StatuBarHeight, ScreenWidth, ScreenHeight - ([PUtil getActualHeight:459] - StatuBarHeight)) andTitleArray:@[@"竞猜", @"赛况"] andShowControllerNameArray:views];
    [self.view addSubview:segmentView];
    [self initGuessOrderView];
}

-(void)initGuessOrderView{
    _guessOrderView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, ScreenHeight)];
    [self.view addSubview:_guessOrderView];
    
    UIView *guessContentView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight- [PUtil getActualHeight:360], ScreenWidth, [PUtil getActualHeight:360])];
    guessContentView.backgroundColor = c07_bar;
    [_guessOrderView addSubview:guessContentView];
    _guessOrderView.hidden = YES;
    
    UIButton *closeBtn = [[UIButton alloc]init];
    [closeBtn setImage:[UIImage imageNamed:@"ic_close"] forState:UIControlStateNormal];
    closeBtn.frame = CGRectMake(ScreenWidth - [PUtil getActualWidth:70], [PUtil getActualHeight:30], [PUtil getActualWidth:40], [PUtil getActualWidth:40]);
    [closeBtn addTarget:self action:@selector(CloseGuessOrderView) forControlEvents:UIControlEventTouchUpInside];
    [guessContentView addSubview:closeBtn];
    
    _guessTitleLabel = [[UILabel alloc]init];
    _guessTitleLabel.text = @"竞猜0，猜中可得0竞猜币";
    _guessTitleLabel.textColor = c08_text;
    _guessTitleLabel.font = [UIFont systemFontOfSize:[PUtil getActualHeight:24]];
    _guessTitleLabel.frame = CGRectMake([PUtil getActualWidth:30], [PUtil getActualHeight:30], [PUtil getActualWidth:500],  [PUtil getActualHeight:28]);
    [guessContentView addSubview:_guessTitleLabel];
    
    _coinLabel = [[UILabel alloc]init];
    _coinLabel.text = @"余额：123123";
    _coinLabel.textColor = c03_yellow;
    _coinLabel.font = [UIFont systemFontOfSize:[PUtil getActualHeight:24]];
    _coinLabel.frame = CGRectMake([PUtil getActualWidth:30], [PUtil getActualHeight:80], [PUtil getActualWidth:500],  [PUtil getActualHeight:28]);
    [guessContentView addSubview:_coinLabel];
    

    int width = (ScreenWidth - [PUtil getActualWidth:120])/4;
    for(int i = 0 ; i < 4 ;i ++){
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake([PUtil getActualWidth:30] +( width + [PUtil getActualWidth:20])*i, [PUtil getActualHeight:140], width, [PUtil getActualHeight:60])];
        button.tag = i;
        NSString *title;
        switch (i) {
            case 0:
                title = @"100";
                break;
            case 1:
                title = @"500";
                break;
            case 2:
                title = @"1000";
                break;
            case 3:
                title = @"5000";
                break;
            default:
                break;
        }
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:c08_text forState:UIControlStateNormal];
        button.layer.cornerRadius = [PUtil getActualHeight:10];
        button.layer.borderWidth = 1;
        button.layer.borderColor = c01_blue.CGColor;
        [button addTarget:self action:@selector(OnGuessBtnSelect:) forControlEvents:UIControlEventTouchUpInside];
        [buttons addObject:button];
        [guessContentView addSubview:button];
    }
    
    _guessBtn  = [[UIButton alloc]init];
    _guessBtn.frame = CGRectMake([PUtil getActualWidth:30], [PUtil getActualHeight:230],ScreenWidth - [PUtil getActualWidth:30]*2 , [PUtil getActualHeight:110]);
    [_guessBtn setTitle:@"立即竞猜" forState:UIControlStateNormal];
    _guessBtn.layer.masksToBounds = YES;
    _guessBtn.layer.cornerRadius = [PUtil getActualHeight:10];
    [_guessBtn addTarget:self action:@selector(requestGuess) forControlEvents:UIControlEventTouchUpInside];
    [guessContentView addSubview:_guessBtn];
    [ColorUtil setGradientColor:_guessBtn startColor:c01_blue endColor:c02_red director:Left];
    
}

-(void)OpenGuessOrderView:(BettingItemModel *)model{
    selectModel = model;
    _guessOrderView.hidden = NO;
    UserModel *userModel = [[AccountManager sharedAccountManager]getUserInfo];
    _coinLabel.text = [NSString stringWithFormat:@"余额：%@",userModel.coin];
    __weak UIView *tempView  = _guessOrderView;
    [UIView animateWithDuration:0.3f animations:^{
        tempView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    }];
}

-(void)CloseGuessOrderView{
    __weak UIView *tempView  = _guessOrderView;
    [UIView animateWithDuration:0.3f animations:^{
        tempView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, ScreenHeight);
    } completion:^(BOOL finished) {
        tempView.hidden = YES;
        [_guessView restoreItems];
        for(UIButton *tempBtn in buttons){
            tempBtn.backgroundColor = [UIColor clearColor];
        }
        _guessTitleLabel.text = @"竞猜0，猜中可得0竞猜币";

    }];
}

-(void)onBackPage{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)goLivePage{
    LivePage *page = [[LivePage alloc]init];
    [self pushPage:page];
}

-(void)requestDetail{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *requestUrl = [NSString stringWithFormat:@"%@%ld",API_GUESS_DETAIL,_race_id];
    [ByNetUtil get:requestUrl parameters:nil success:^(RespondModel *respondModel) {
        if(respondModel.code == 200){
            id data = respondModel.data;
            id race = [data objectForKey:@"race"];
            raceModel = [RaceModel mj_objectWithKeyValues:race];
            id betting = [data objectForKey:@"betting"];
            bettingArray = [BettingModel mj_objectArrayWithKeyValuesArray:betting];
            [self updateTopView];
            
        }else{
            [DialogHelper showFailureAlertSheet:respondModel.msg];
        }
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    } failure:^(NSError *error) {
        [DialogHelper showFailureAlertSheet:@"请求失败"];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
}

-(void)updateTopView{
    TeamModel *aTeamModel = [TeamModel mj_objectWithKeyValues:raceModel.team_a];
    TeamModel *bTeamModel = [TeamModel mj_objectWithKeyValues:raceModel.team_b];
    _aTeamLabel.text = aTeamModel.team_name;
    _bTeamLabel.text = bTeamModel.team_name;
    _scoreLabel.text = [NSString stringWithFormat:@"%@ : %@",raceModel.score_a,raceModel.score_b];
    [_aTeamImageView sd_setImageWithURL:[NSURL URLWithString:aTeamModel.logo]];
    [_bTeamImageView sd_setImageWithURL:[NSURL URLWithString:bTeamModel.logo]];
    _timeLabel.text = [TimeUtil generateAll:raceModel.race_ts];
    _gameLabel.text = raceModel.race_name;
    [self initBodyView];
}

-(void)OnGuessBtnSelect : (id)sender{
    UIButton *button = sender;
    UserModel *userModel = [[AccountManager sharedAccountManager]getUserInfo];
    int coin = 0;
    switch (button.tag) {
        case 0:
            coin = 100;
            break;
        case 1:
            coin = 500;
            break;
        case 2:
            coin = 1000;
            break;
        case 3:
            coin = 5000;
            break;
        default:
            break;
    }
    if([userModel.coin intValue] < coin){
        [DialogHelper showFailureAlertSheet:@"余额不足"];
        return;
    }
    selectCoin = coin;
    for(UIButton *tempBtn in buttons){
        tempBtn.backgroundColor = [UIColor clearColor];
    }
    button.backgroundColor = c01_blue;
    _guessTitleLabel.text = [NSString stringWithFormat:@"竞猜%d， 猜中可得%.f竞猜币",coin,coin *  [selectModel.odds floatValue]];
}

-(void)getUserInfo{
    [ByNetUtil get:API_USERINFO parameters:nil success:^(RespondModel *respondModel) {
        if(respondModel.code == 200){
            id data = respondModel.data;
            UserModel *userModel = [UserModel mj_objectWithKeyValues:data];
            [[AccountManager sharedAccountManager]saveUserInfo:userModel];
            
        }
    } failure:^(NSError *error) {
        
    }];
}

//立即竞猜
-(void)requestGuess{
    if(selectCoin == 0){
        [DialogHelper showWarnTips:@"请选择一个金额"];
        return;
    }
    NSMutableArray *array = [[NSMutableArray alloc]init];
    [array addObject:@(selectModel.betting_item_id)];

    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    dic[@"coin"] = @(selectCoin);
    dic[@"betting_item_id_list"] = array;
    
    [ByNetUtil post:API_GUESS content:dic.mj_JSONString success:^(RespondModel *respondModel) {
        if(respondModel.code == 200){
            [self getUserInfo];
            [self CloseGuessOrderView];
            [DialogHelper showSuccessTips:@"投注成功"];
        }else{
            [DialogHelper showFailureAlertSheet:respondModel.msg];
        }
    } failure:^(NSError *error) {
        [DialogHelper showFailureAlertSheet:@"请求失败"];
    }];
}

@end
