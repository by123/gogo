//
//  CommentCell.m
//  gogo
//
//  Created by by.huang on 2017/10/26.
//  Copyright © 2017年 by.huang. All rights reserved.
//


#import "CommentCell.h"
#import "TimeUtil.h"
@interface CommentCell()

@property (strong, nonatomic) UIImageView *imgView;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *timeLabel;
@property (strong, nonatomic) UILabel *contenLabel;
@property (strong ,nonatomic) UIView  *lineView;

@end

@implementation CommentCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initView];
    }
    return self;
}


-(void)initView{
    
    self.contentView.backgroundColor = c06_backgroud;
    
    _imgView = [[UIImageView alloc]init];
    _imgView.layer.masksToBounds = YES;
    _imgView.contentMode = UIViewContentModeScaleAspectFill;
    _imgView.layer.cornerRadius = [PUtil getActualHeight:64]/2;
    _imgView.frame = CGRectMake([PUtil getActualWidth:30], [PUtil getActualWidth:30], [PUtil getActualHeight:64], [PUtil getActualHeight:64]);
    [self.contentView addSubview:_imgView];
    
    _nameLabel = [[UILabel alloc]init];
    _nameLabel.frame = CGRectMake([PUtil getActualWidth:110], [PUtil getActualHeight:32], [PUtil getActualWidth:300], [PUtil getActualHeight:33]);
    _nameLabel.textColor = c09_tips;
    _nameLabel.font = [UIFont systemFontOfSize:[PUtil getActualHeight:24]];
    [self.contentView addSubview:_nameLabel];
    
    _timeLabel = [[UILabel alloc]init];
    _timeLabel.frame = CGRectMake([PUtil getActualWidth:110], [PUtil getActualHeight:65], [PUtil getActualWidth:300], [PUtil getActualHeight:28]);
    _timeLabel.textColor = c08_text;
    _timeLabel.font = [UIFont systemFontOfSize:[PUtil getActualHeight:20]];
    [self.contentView addSubview:_timeLabel];
    
    _contenLabel = [[UILabel alloc]init];
    _contenLabel.frame = CGRectMake([PUtil getActualWidth:30], [PUtil getActualHeight:110], ScreenWidth - [PUtil getActualWidth:30]*2, [PUtil getActualHeight:40]);
    _contenLabel.textColor = c08_text;
    _contenLabel.font = [UIFont systemFontOfSize:[PUtil getActualHeight:28]];
    [self.contentView addSubview:_contenLabel];
    
    _lineView = [[UIView alloc]init];
    _lineView.backgroundColor = c05_divider;
    _lineView.frame = CGRectMake([PUtil getActualWidth:30],  [PUtil getActualHeight:180]-1, ScreenWidth - [PUtil getActualWidth:30], 1);
    [self.contentView addSubview:_lineView];
}

-(void)setData : (CommentListModel *)model{
    UserModel *userModel = [UserModel mj_objectWithKeyValues:model.user];
    CommentModel *commentModel = [CommentModel mj_objectWithKeyValues:model.comment];
    _nameLabel.text = userModel.username;
    _timeLabel.text = [TimeUtil generateAll:commentModel.create_ts];
    _contenLabel.text = commentModel.content;
    [_imgView sd_setImageWithURL:[NSURL URLWithString:userModel.avatar] placeholderImage:[UIImage imageNamed:@"ic_default_head"]];
}

+(NSString *)identify{
    return @"CommentCell";
}

@end
