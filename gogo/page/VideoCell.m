//
//  VideoCell.m
//  gogo
//
//  Created by by.huang on 2017/11/24.
//  Copyright © 2017年 by.huang. All rights reserved.
//

#import "VideoCell.h"
#import "RHPlayerView.h"
#import "RHVideoModel.h"

@interface VideoCell()

@property (strong ,nonatomic) UILabel *mTitleLabel;
@property (strong, nonatomic) UIImageView *mTypeImage;
@property (strong ,nonatomic) UILabel *mTypeLabel;
@property (strong, nonatomic) UIImageView *mCommentImage;
@property (strong ,nonatomic) UILabel *mCommentLabel;
@property (strong ,nonatomic) UIImageView *mImageView;
@property (strong ,nonatomic) UIView  *lineView;
@property (strong, nonatomic) RHPlayerView *playView;

@end

@implementation VideoCell{
    BaseViewController *vc;
    id<RHPlayerViewDelegate> _delegate;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier controller:(BaseViewController *)controller delegate : (id<RHPlayerViewDelegate>)delegate{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        vc = controller;
        _delegate = delegate;
        [self initView];
    }
    return self;
}

-(void)initView{
    self.contentView.backgroundColor = c06_backgroud;
    
    _mTitleLabel = [[UILabel alloc]init];
    _mTitleLabel.frame = CGRectMake([PUtil getActualWidth:30], [PUtil getActualHeight:24], ScreenWidth - [PUtil getActualHeight:30]*2, [PUtil getActualHeight:84]);
    _mTitleLabel.textColor = c08_text;
    _mTitleLabel.font = [UIFont systemFontOfSize:[PUtil getActualHeight:30]];
    _mTitleLabel.numberOfLines = 0;
    _mTitleLabel.lineBreakMode = NSLineBreakByCharWrapping;
    [self.contentView addSubview:_mTitleLabel];
    
    _mTypeImage = [[UIImageView alloc]init];
    _mTypeImage.image = [UIImage imageNamed:@"ic_info_12"];
    _mTypeImage.frame = CGRectMake([PUtil getActualWidth:30], [PUtil getActualHeight:560], [PUtil getActualWidth:24], [PUtil getActualWidth:24]);
    [self.contentView addSubview:_mTypeImage];
    
    _mTypeLabel = [[UILabel alloc]init];
    _mTypeLabel.frame = CGRectMake([PUtil getActualWidth:62], [PUtil getActualHeight:555], [PUtil getActualWidth:300], [PUtil getActualHeight:33]);
    _mTypeLabel.textColor = c09_tips;
    _mTypeLabel.font = [UIFont systemFontOfSize:[PUtil getActualHeight:24]];
    [self.contentView addSubview:_mTypeLabel];
    
    _mCommentImage = [[UIImageView alloc]init];
    _mCommentImage.image = [UIImage imageNamed:@"ic_comment_12"];
    _mCommentImage.frame = CGRectMake([PUtil getActualWidth:440], [PUtil getActualHeight:560], [PUtil getActualWidth:24], [PUtil getActualWidth:24]);
    [self.contentView addSubview:_mCommentImage];
    
    _mCommentLabel = [[UILabel alloc]init];
    _mCommentLabel.frame = CGRectMake([PUtil getActualWidth:472], [PUtil getActualHeight:555], [PUtil getActualWidth:60], [PUtil getActualHeight:33]);
    _mCommentLabel.textColor = c09_tips;
    _mCommentLabel.font = [UIFont systemFontOfSize:[PUtil getActualHeight:24]];
    [self.contentView addSubview:_mCommentLabel];
    
    _playView = [[RHPlayerView alloc]initWithFrame:CGRectMake(0, [PUtil getActualHeight:105], ScreenWidth, ScreenWidth * ScreenWidth / ScreenHeight) currentVC:vc parentView : self.contentView];
    _playView.delegate = _delegate;
    [self.contentView addSubview:_playView];
    
    _lineView = [[UIView alloc]init];
    _lineView.backgroundColor = c05_divider;
    _lineView.frame = CGRectMake([PUtil getActualWidth:30],  [PUtil getActualHeight:600]-1, ScreenWidth - ([PUtil getActualWidth:30]*2), 1);
    [self.contentView addSubview:_lineView];
}


-(void)setData : (NewsModel *)model{
    _mTitleLabel.text = model.title;
    _mTypeLabel.text = model.tp;
    _mCommentLabel.text = model.comment_count;
    
    NSMutableArray *dataArr = [[NSMutableArray alloc]init];
    NSString *vedioId = [NSString stringWithFormat:@"%ld",model.news_id];
    RHVideoModel *videoModel = [[RHVideoModel alloc] initWithVideoId:vedioId title:@"" url:model.video currentTime:0];
    [dataArr addObject:videoModel];
    [_playView setVideoModels:dataArr playVideoId:vedioId];
    if(!model.isPlay){
        [_playView pause];
    }
//    [_playView playVideoWithVideoId:vedioId];
    
}

+(NSString *)identify{
    return @"VideoCell";
}

-(void)setVedioPause{
    [_playView pause];
}


@end

