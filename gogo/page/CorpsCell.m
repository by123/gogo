//
//  CorpsCell.m
//  gogo
//
//  Created by by.huang on 2017/10/25.
//  Copyright © 2017年 by.huang. All rights reserved.
//

#import "CorpsCell.h"

@interface CorpsCell()

@property (strong, nonatomic) UIView *aView;

@property (strong, nonatomic) UILabel *mTitleLabel;

@property (strong, nonatomic) UIView *bView;

@property (strong, nonatomic) UIView *lineView;


@end

@implementation CorpsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initView];
    }
    return self;
}

-(void)initView{
    
    self.contentView.backgroundColor = c06_backgroud;
    
    _aView = [[UIView alloc]init];
    _aView.frame = CGRectMake([PUtil getActualWidth:30], [PUtil getActualHeight:26], [PUtil getActualHeight:58], [PUtil getActualHeight:58]);
    _aView.backgroundColor = c01_blue;
    [self.contentView addSubview:_aView];
    
    _mTitleLabel = [[UILabel alloc]init];
    _mTitleLabel.frame = CGRectMake([PUtil getActualWidth:108], [PUtil getActualHeight:31], ScreenWidth, [PUtil getActualHeight:48]);
    _mTitleLabel.textColor = c09_tips;
    _mTitleLabel.font = [UIFont systemFontOfSize:[PUtil getActualHeight:34]];
    [self.contentView addSubview:_mTitleLabel];
    
    _bView = [[UIView alloc]init];
    _bView.frame = CGRectMake([PUtil getActualWidth:688], [PUtil getActualHeight:39], [PUtil getActualHeight:32], [PUtil getActualHeight:32]);
    _bView.backgroundColor = c10_icon;
    [self.contentView addSubview:_bView];
    
    _lineView = [[UIView alloc]init];
    _lineView.backgroundColor = c05_divider;
    _lineView.frame = CGRectMake([PUtil getActualWidth:30], [PUtil getActualHeight:110]-1, ScreenWidth - [PUtil getActualWidth:30], 1);
    [self.contentView addSubview:_lineView];
    
}


-(void)setData : (NSString *)title{
    _mTitleLabel.text = title;
    
}

+(NSString *)identify{
    return @"CorpsCell";
}

@end
