//
//  ScheduleContentCell.m
//  gogo
//
//  Created by by.huang on 2017/10/25.
//  Copyright © 2017年 by.huang. All rights reserved.
//

#import "ScheduleContentCell.h"
#import "TimeUtil.h"
@interface ScheduleContentCell()

@property (strong, nonatomic) UIImageView *aView;

@property (strong, nonatomic) UIImageView *bView;

@property (strong, nonatomic) UIView *timeView;

@property (strong, nonatomic) UILabel *timeLabel;

@property (strong, nonatomic) UIButton *guessBtn;

@property (strong, nonatomic) UIView *lineView;

@end

@implementation ScheduleContentCell{
    id <MainHandleDelegate> handleDelegate;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initView];
    }
    return self;
}

-(void)initView{
    
    self.contentView.backgroundColor = c07_bar;
    _aView = [[UIImageView alloc]init];
    _aView.frame = CGRectMake([PUtil getActualWidth:110], [PUtil getActualHeight:42], [PUtil getActualHeight:80], [PUtil getActualHeight:80]);
    _aView.layer.masksToBounds = YES;
    _aView.layer.cornerRadius = [PUtil getActualHeight:60]/2;
    _aView.contentMode = UIViewContentModeScaleAspectFit;
//    _aView.backgroundColor = c01_blue;
    [self.contentView addSubview:_aView];

    _timeView = [[UIView alloc]init];
    _timeView.frame = CGRectMake([PUtil getActualWidth:230],  [PUtil getActualHeight:62], [PUtil getActualWidth:116], [PUtil getActualHeight:40]);
    _timeView.layer.masksToBounds = YES;
    _timeView.layer.cornerRadius = [PUtil getActualHeight:40]/2;
    [self.contentView addSubview:_timeView];
    [ColorUtil setGradientColor:_timeView startColor:c01_blue endColor:c02_red director:Left];

    
    _timeLabel = [[UILabel alloc]init];
    _timeLabel.frame = CGRectMake([PUtil getActualWidth:230],  [PUtil getActualHeight:62], [PUtil getActualWidth:116], [PUtil getActualHeight:40]);
    _timeLabel.font = [UIFont systemFontOfSize:[PUtil getActualHeight:24]];
    _timeLabel.textColor = c08_text;
    _timeLabel.textAlignment = NSTextAlignmentCenter;
    _timeLabel.layer.masksToBounds = YES;
    _timeLabel.layer.cornerRadius = [PUtil getActualHeight:40]/2;
    [self.contentView addSubview:_timeLabel];

    
    _bView = [[UIImageView alloc]init];
    _bView.frame = CGRectMake([PUtil getActualWidth:406], [PUtil getActualHeight:42], [PUtil getActualHeight:80], [PUtil getActualHeight:80]);
    _bView.layer.masksToBounds = YES;
    _bView.layer.cornerRadius = [PUtil getActualHeight:60]/2;
//    _bView.backgroundColor = c02_red;
    _bView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_bView];
    
    _guessBtn = [[UIButton alloc]init];
    _guessBtn.frame = CGRectMake([PUtil getActualWidth:576], [PUtil getActualHeight:50], [PUtil getActualWidth:144], [PUtil getActualHeight:64]);
    [_guessBtn setTitle:@"竞猜" forState:UIControlStateNormal];
    [_guessBtn setTitleColor:c08_text forState:UIControlStateNormal];
    _guessBtn.backgroundColor = c01_blue;
    _guessBtn.layer.masksToBounds = YES;
    _guessBtn.layer.cornerRadius = [PUtil getActualHeight:6];
    _guessBtn.titleLabel.font = [UIFont systemFontOfSize:[PUtil getActualHeight:28]];
    [_guessBtn addTarget:self action:@selector(goGuessPage) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_guessBtn];
    
    _lineView = [[UIView alloc]init];
    _lineView.backgroundColor = c05_divider;
    _lineView.frame = CGRectMake([PUtil getActualWidth:30], [PUtil getActualHeight:164]-1, ScreenWidth - [PUtil getActualWidth:30], 1);
    [self.contentView addSubview:_lineView];
    
}

-(void)setData : (ScheduleItemModel *)model{
    _timeLabel.text = [TimeUtil generateTime:model.race_ts];
    TeamModel *aTeamModel = [TeamModel mj_objectWithKeyValues:model.team_a];
    [_aView sd_setImageWithURL:[NSURL URLWithString:aTeamModel.logo]];
    TeamModel *bTeamModel = [TeamModel mj_objectWithKeyValues:model.team_b];
    [_bView sd_setImageWithURL:[NSURL URLWithString:bTeamModel.logo]];

    if(model.hideLine){
        [_lineView setHidden:YES];
    }
}

-(void)setDelegate : (id<MainHandleDelegate>)delegate{
    handleDelegate = delegate;
}

-(void)goGuessPage{
    if(handleDelegate){
        [handleDelegate goGuessPage];
    }
}

+(NSString *)identify{
    return @"ScheduleContentCell";
}

@end
